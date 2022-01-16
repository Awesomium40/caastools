from caastools.database.model import *
from caastools.database.database import atomic, db
from peewee import PeeweeException
from typing import Iterable, Type, Optional, Union


__all__ = ['Translation', 'TranslationError', 'Translator']


def copy_decorator(method):
    def inner(self, *args, **kwargs):
        clone = self.clone()
        method(clone, *args, **kwargs)
        return clone
    return inner


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



def _add_translation_(
        source_system_name: str,
        target_system_name: str,
        source_values: Iterable[Union[GlobalValue, PropertyValue]],
        target_value: Union[GlobalValue, PropertyValue],
        translation_type: str
) -> Translation:
    """
    Adds a translation to the Translation object graph
    :param source_system_name: Name of the system of the translations source
    :param target_system_name Name of the coding system of the translation's target
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

    source_system = CodingSystem.select().where(CodingSystem.cs_name == source_system_name).get()
    target_system = CodingSystem.select().where(CodingSystem.cs_name == target_system_name).get()

    validation_query = model_type.select(CodingSystem.cs_name).join(property_entity).join(CodingSystem)

    # Ensure that provided PropertyValue are members of respective coding systems
    for sv in source_values:
        cs_name = validation_query.where(getattr(model_type, id_attr) == getattr(sv, id_attr)).scalar()

        if cs_name != source_system_name:
            raise ValueError(f"PropertyValue {sv} is not a member of {source_system_name}")

    cs_name = validation_query.where(getattr(model_type, id_attr) == getattr(target_value, id_attr)).scalar()
    if cs_name != target_system_name:
        raise ValueError(f"PropertyValue {model_type} is not a member of {target_system_name}")

    # Construct the model instances to be saved
    new_translation = Translation(
        description=f'{source_system_name} to {target_system_name}: ' +
                    '/'.join(getattr(s, value_attr) for s in source_values) +
                    f' to {target_value.pv_value}', source_cs=source_system, target_cs=target_system
    )
    target = TranslationTarget(translation=new_translation,
                               parent_table_name=parent_table_name, parent_primary_key=getattr(target_value, id_attr))

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


def _translate_(
        source_values: Iterable[Union[GlobalValue, PropertyValue]],
        source_system_name: str,
        target_system_name: str,
        translation_type: str
) -> Union[PropertyValue, GlobalValue]:
    """

    :param source_values: GlobalValue or PropertyValue objects which meet the rule parts of the translation source
    :param source_system_name: name of coding system which meet coding system source rule
    :param target_system_name: name of coding system which meets coding system target rule
    :param translation_type: whether to translate GlobalValue or PropertyValue
    :return: GlobalValue or PropertyValue which is the result of successful translation
    :raises: DoesNotExist if translation fails
    """

    value_entities = {'global': GlobalValue, 'property': PropertyValue}
    parent_tables = {'global': 'GlobalValue', 'property': 'PropertyValue'}

    source_system: CodingSystem = CodingSystem.alias('source_cs')
    target_system: CodingSystem = CodingSystem.alias('target_cs')
    target_value: Union[Type[GlobalValue, PropertyValue]] = value_entities.get(translation_type)
    parent_table_name: str = parent_tables.get(translation_type)

    if target_value is None:
        raise ValueError(
            f"parameter 'translation_type' expected one of ['global', 'property'], got '{translation_type}'.")

    # The basic predicate of the where clause requires that source and target systems are as specified
    # and that parent table name is correct
    predicate = (
            (target_system.cs_name == target_system_name) &
            (source_system.cs_name == source_system_name) &
            (TranslationTarget.parent_table_name == parent_table_name)
    )

    query = (
        target_value
        .select()
        .join(TranslationTarget, on=target_value.property_value_id == TranslationTarget.parent_primary_key)
        .join(Translation)
        .join(target_system, on=Translation.target_cs == target_system.coding_system_id)
        .switch(Translation)
        .join(source_system, on=Translation.source_cs == source_system.coding_system_id)
        .switch(Translation)
    )

    # Each source value represents part of the rule for translation
    # Join the rule to the basic query and construct the predicate for the where clause
    for i, pv in enumerate(source_values):  # type: Union[Type[GlobalValue, PropertyValue]]
        new_source: TranslationSource = TranslationSource.alias(f'source_{i}')
        query = query.join(new_source).switch(Translation)
        predicate = predicate & (
                (new_source.parent_table_name == parent_table_name) &
                (new_source.parent_primary_key == pv.property_value_id)
        )

    # With the query constructed, attempt to retrieve the translation
    result = query.first()
    if result is None:
        raise TranslationError(translation_type, source_system_name, target_system_name,
                               [int(x) for x in source_values])

    return result


def add_property_translation(
        source_system_name: str,
        target_system_name: str,
        source_values: Iterable[PropertyValue],
        target_value: PropertyValue
) -> Translation:
    """
    Adds a new PropertyValue translation to the database
    :param source_system_name: Name of the source coding system
    :param target_system_name: Name of the target coding system
    :param source_values: PropertyValue objects which form the source of the translation
    :param target_value: PropertyValue object which is the result of translation
    :return: Translation
    :raises: CodingSystem.DoesNotExist if no CodingSystem exists with source_system_name or target_system_name
    :raises
    """

    return _add_translation_(source_system_name, target_system_name, source_values, target_value, 'property')


def add_global_translation(
        source_system_name: str,
        target_system_name: str,
        source_values: Iterable[GlobalValue],
        target_value: GlobalValue
) -> Translation:
    """

    :param source_system_name:
    :param target_system_name:
    :param source_values:
    :param target_value:
    :return:
    """

    return _add_translation_(source_system_name, target_system_name, source_values, target_value, 'global')


def translate_global_values(
        global_values: Iterable[GlobalValue],
        source_system_name: str,
        target_system_name: str
) -> GlobalValue:
    """
    Attempts translation of global_values from source_system_name to target_system_name
    :param global_values: GlobalValue which are the source of the translation
    :param source_system_name: the coding system from which the GlobalValues derive
    :param target_system_name: the coding system from which the translated GlobalValue derives
    :return: GlobalValue
    :raises: GlobalValue.DoesNotExist if no translation can be found
    """
    return _translate_(global_values, source_system_name, target_system_name, translation_type='global')


def translate_property_values(
        property_values: Iterable[PropertyValue],
        source_system_name: str,
        target_system_name: str,
) -> PropertyValue:
    """
    Attempts to translate property_values into an equivalent PropertyValue object from target system and property
    :param property_values: Iterable of PropertyValue objects which are to be collectively translated
    :param source_system_name: Name of the coding system from which to translate
    :param target_system_name: The name of the coding system into which to translate
    :return: PropertyValue
    :raises PropertyValue.DoesNotExist: if no translation exists
    """
    return _translate_(property_values, source_system_name, target_system_name, translation_type='property')
