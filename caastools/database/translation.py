from caastools.database.model import *
from caastools.database.database import atomic, db
from peewee import PeeweeException
from typing import Iterable, Type, Optional, Union


__all__ = ['TranslationError', 'Translator']


class TranslationError(Exception):
    def __init__(
            self,
            translation_type: str,
            source_system_name: str,
            target_system_name: str,
            source_value_ids: Iterable[int]
    ):
        super().__init__(f"Unable to translate {translation_type} ({source_value_ids}) " +
                         f"from {source_system_name} to {target_system_name}")
        self._translation_type = translation_type
        self._source_system = source_system_name
        self._target_system = target_system_name
        self._source_pks = source_value_ids


class Translator:

    _query_params_ = {'global': (GlobalValue, 'GlobalValue', GlobalValue.global_value_id.name),
                      'property': (PropertyValue, 'PropertyValue', PropertyValue.property_value_id.name)}

    def __init__(self, source_cs_name, target_cs_name):
        super().__init__()
        self._source_system = CodingSystem.select().where(CodingSystem.cs_name == source_cs_name).get()
        self._target_system = CodingSystem.select().where(CodingSystem.cs_name == target_cs_name).get()
        self._target_pv = None
        self._source_pvs = []
        self._predicate = (
                (Translation.source_cs == self._source_system) &
                (Translation.target_cs == self._target_system)
        )

    def translate(self, translation_type, *sources) -> Optional[PropertyValue]:
        """
        Performs a translation of type translation_type from sources to their target
        :param translation_type: type of translation to perform ('global' | 'property')
        :param sources: iterable of PropertyValue objects from which a translation occurs
        :return: PropertyValue that is the result of translation of None if not found
        """
        if len(sources) == 0:
            raise ValueError("No sources provided for translation.")

        predicate = self._predicate

        parent_table, parent_table_name, id_attr = self._query_params_.get(translation_type, (None, None, None))
        target_table = parent_table.alias('target')

        if parent_table is None:
            raise ValueError(f"parameter 'translation_type' expected ['global'|'property'], got {translation_type}")

        target_cs_table: CodingSystem = CodingSystem.alias('target_system')
        source_cs_table: CodingSystem = CodingSystem.alias('source_system')

        # Construct the basic query - select the target value were source and target coding systems match specified
        query = (
            target_table
            .select()
            .join(TranslationTarget, on=target_table.property_value_id == TranslationTarget.parent_primary_key)
            .join(Translation)
            .join(target_cs_table, on=Translation.target_cs_id == target_cs_table.coding_system_id)
            .switch(Translation)
            .join(source_cs_table, on=Translation.source_cs == source_cs_table.coding_system_id)
            .switch(Translation)
        )

        # Each source value represents part of the rule for translation
        # Join the rule to the basic query and construct the predicate for the where clause
        for i, pv in enumerate(sources):  # type: Union[Type[GlobalValue, PropertyValue]]
            new_source: TranslationSource = TranslationSource.alias(f'source_{i}')
            query = query.join(new_source).switch(Translation)
            predicate = predicate & (
                    (new_source.parent_table_name == parent_table_name) &
                    (new_source.parent_primary_key == getattr(pv, id_attr))
            )

        result = query.where(predicate).first()

        return result

    def add_translation(
            self,
            description: str,
            source_values: Iterable[Union[GlobalValue, PropertyValue]],
            target_value: Union[GlobalValue, PropertyValue],
            translation_type: str) -> Translation:
        """
        Adds a translation to the Translation object graph
        :param description: Brief description of the translation to be made
        :param source_values: Values that serve as the rules for the translation source
        :param target_value: Value that serves as the result of the translation
        :param translation_type: Whether to create GlobalValue ('global') or PropertyValue ('property') translation
        :return: Translation
        :raises PeeweeException: If insertion cannot be completed
        """
        query_params = {
            'global': (GlobalValue, GlobalProperty, 'GlobalValue', 'global_value_id', 'gv_value'),
            'property': (PropertyValue, CodingProperty, 'PropertyValue', 'property_value_id', 'pv_value')
        }

        model_type, property_entity, parent_table_name, id_attr, value_attr = query_params.get(
            translation_type, (None, None, None, None, None)
        )

        if model_type is None:
            raise ValueError(
                f"parameter 'translation_type' expected one of ['global', 'property'], got '{translation_type}'.")

        validation_query = model_type.select(CodingSystem.cs_name).join(property_entity).join(CodingSystem)

        # Ensure that provided PropertyValue are members of respective coding systems
        for sv in source_values:
            cs_name = validation_query.where(getattr(model_type, id_attr) == getattr(sv, id_attr)).scalar()

            if cs_name != self._source_system.cs_name:
                raise ValueError(f"PropertyValue {sv} is not a member of {self._source_system.cs_name}")

        cs_name = validation_query.where(getattr(model_type, id_attr) == getattr(target_value, id_attr)).scalar()
        if cs_name != self._target_system.cs_name:
            raise ValueError(f"PropertyValue {model_type} is not a member of {self._target_system.cs_name}")

        # Construct the model instances to be saved
        new_translation = Translation(
            description=description, source_cs=self._source_system, target_cs=self._target_system
        )

        target = TranslationTarget(
            translation=new_translation, parent_table_name=parent_table_name,
            parent_primary_key=getattr(target_value, id_attr)
        )

        source_rules = [{'translation': new_translation, 'parent_table_name': parent_table_name,
                         'parent_primary_key': getattr(s, id_attr)}
                        for s in source_values
                        ]

        # Perform an atomic insertion of model instances
        with atomic() as transaction:
            try:
                new_translation.save()
                target.save()
                TranslationSource.bulk_insert(source_rules, on_conflict='ignore')
                transaction.commit()
            except PeeweeException as err:
                transaction.rollback()
                raise err

        return new_translation
