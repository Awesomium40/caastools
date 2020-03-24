from ..constants import CactiAttributes, CactiNodes, IaProperties
from peewee import AutoField, BooleanField, chunked, FloatField, ForeignKeyField, IntegerField, Model, PeeweeException, \
    SQL, TextField
from playhouse.sqlite_ext import SqliteExtDatabase
from typing import Sequence
import logging
import lxml.etree as et
import sqlite3

logging.getLogger('database.models').addHandler(logging.NullHandler())
db = SqliteExtDatabase(None)

__all__ = ['close_database', 'CodingSystem', 'CodingProperty', 'PropertyValue', 'Interview', 'Utterance',
           'UtteranceCode', 'GlobalProperty', 'GlobalValue', 'GlobalRating', 'init_database']

IV_XFORM = "interview_transform.xslt"
CS_XFORM = "cs_transform.xslt"
MEMORY = ":memory:"


class BaseModel(Model):
    source_id = IntegerField(null=True, index=True, unique=False)

    @classmethod
    def bulk_insert(cls, row_dicts: Sequence[dict]) -> int:
        """
        BaseModel.bulk_insert(row_dict: dict) -> int
        Performs an atomic bulk insertion of the data provided in row_dicts and returns the number of rows inserted
        :param row_dicts: sequence of dictionary objects mapping field names to values to insert
        :return int: The number of rows inserted
        :raise peewee.PeeweeException: if bulk insertion fails
        """
        rows_inserted = 0
        with cls._meta.database.atomic() as transaction:
            for batch in chunked(row_dicts, 100):
                rows_inserted += cls.insert_many(batch).execute()

        return rows_inserted

    class Meta:
        database = db


class CodingSystem(BaseModel):
    coding_system_id = AutoField()
    source_id = IntegerField(null=True, index=True, unique=True)
    cs_name = TextField(null=False, index=True, unique=True)
    cs_path = TextField(null=False, index=True, unique=True)


class Interview(BaseModel):
    source_id = IntegerField(null=True, index=True, unique=True)
    interview_id = AutoField()
    interview_name = TextField(null=False, index=True, unique=True)
    coding_system = ForeignKeyField(CodingSystem, backref="interviews")
    study_id = IntegerField(null=True, unique=False, index=True)
    client_id = TextField(null=False, unique=False, index=True)
    rater_id = IntegerField(null=False, unique=False, index=True)
    therapist_id = IntegerField(null=True, unique=False, index=False)
    language_id = IntegerField(null=True, unique=False, index=False)
    treatment_condition_id = IntegerField(null=True, unique=False, index=False)


class CodingProperty(BaseModel):
    coding_property_id = AutoField()
    coding_system = ForeignKeyField(CodingSystem, backref="coding_properties", on_update="CASCADE",
                                    on_delete="CASCADE", null=False, index=True, unique=False,
                                    column_name="coding_system_id")
    cp_name = TextField(null=False, index=False, unique=False)
    cp_display_name = TextField(null=False, index=False, unique=False)
    cp_abbreviation = TextField(null=True, index=False, unique=False)
    cp_sort_order = IntegerField(null=False, index=False, unique=False, default=0)
    cp_data_type = TextField(null=False, index=False, unique=False, default="string")
    cp_decimal_digits = IntegerField(null=False, default=0)
    cp_zero_pad = BooleanField(null=False, default=False)
    cp_description = TextField(null=False, index=False, unique=False)

    class Meta:
        constraints = [SQL('CONSTRAINT cp_name_cs_id_unique UNIQUE(cp_name, coding_system_id)'),
                       SQL('CONSTRAINT cp_source_id_cs_id_unique UNIQUE(source_id, coding_system_id)')]

    @classmethod
    def insert_from_cacti_xml(cls, property_node, coding_system):
        """
        CodingProperty.insert_from_cacti_xml(property_node, cs_entity, property_type, transaction) -> CodingProperty
        Performs an insertion of the <code> elements contained in the <codes> element represented by property_node
        and returns the resulting entity.
        :param property_node: the <codes> or <components> CACTI element containing the property data to be inserted
        :param coding_system: the peewee Model instance corresponding to the CodingSystem
        :return: CodingProperty created as a result of the insert
        :raise peewee.PeeweeException: when insertion fails
        """

        with cls._meta.database.atomic() as transaction:
            try:
                code_property = cls.create(coding_system=coding_system,
                                           cp_name=property_node.get(CactiAttributes.CP_NAME),
                                           cp_display_name=property_node.get(CactiAttributes.CP_NAME),
                                           cp_description=property_node.get(CactiAttributes.CP_NAME),
                                           cp_data_type='numeric' if property_node.tag == CactiNodes.COMPONENTS
                                           else 'string')
            except Exception as err:
                transaction.rollback()
                raise err

        return code_property

    @classmethod
    def insert_from_ia_xml(cls, property_node, coding_system):
        """
        CodingProperty.insert_from_ia_xml(property_node, coding_system) -> CodingProperty
        :param property_node: the <CodingProperty> node containing data to be inserted
        :param coding_system: The CodingSystem entity to which the CodingProperty belongs
        :return: CodingProperty
        """

        with cls._meta.database.atomic as transaction:
            try:
                coding_property = cls.create(coding_system=coding_system,
                                             cp_name=property_node.get(IaProperties.PROPERTY_NAME),
                                             cp_display_name=property_node.get(IaProperties.DISPLAY_NAME),
                                             cp_abbreviation=property_node.get(IaProperties.ABBREVIATION),
                                             cp_sort_order=property_node.get(IaProperties.SORT_ORDER),
                                             cp_data_type=property_node.get(IaProperties.DATA_TYPE),
                                             cp_zero_pad=property_node.get(IaProperties.ZERO_PAD),
                                             cp_description=property_node.get(IaProperties.DESCRIPTION),
                                             source_id=int(property_node.get(IaProperties.PROPERTY_ID)))

            except Exception as err:
                transaction.rollback()
                raise err
            else:
                transaction.commit()

            return coding_property


class GlobalProperty(BaseModel):
    global_property_id = AutoField()
    coding_system = ForeignKeyField(CodingSystem, backref="globals", on_delete="CASCADE", on_update="CASCADE",
                                    column_name="coding_system_id", index=True)
    gp_name = TextField(null=False, unique=False)
    gp_description = TextField(null=False, unique=False)
    gp_data_type = TextField(null=False, index=False, unique=False, default="string")

    cacti_map_func = lambda node, cp_entity: {GlobalProperty.gp_name.name: node.get(CactiAttributes.NAME),
                                              GlobalProperty.gp_description.name: node.get(
                                                  CactiAttributes.DESCRIPTION),
                                              GlobalProperty.coding_system.name: cp_entity,
                                              GlobalProperty.source_id.name: node.get(CactiAttributes.VALUE),
                                              GlobalProperty.gp_data_type.name: 'numeric'}

    ia_map_func = lambda node, cp_entity: {GlobalProperty.gp_name.name: node.get(IaProperties.PROPERTY_NAME),
                                           GlobalProperty.gp_description.name: node.get(IaProperties.DESCRIPTION),
                                           GlobalProperty.source_id.name: int(node.get(IaProperties.PROPERTY_ID)),
                                           GlobalProperty.coding_system.name: cp_entity,
                                           GlobalProperty.gp_data_type.name: node.get(IaProperties.PROPERTY_TYPE)}

    class Meta:
        constraints = [SQL('CONSTRAINT gp_source_id_cs_id_unique UNIQUE(source_id, coding_system_id)')]

    @classmethod
    def bulk_insert_from_cacti_xml(cls, global_nodes, coding_system_entity):
        """
        GlobalProperty.insert_from_cacti_xml(global_nodes, coding_system_entity) -> int
        :param global_nodes: the sequence of CACTI userConfiguration.xml global element from which to insert
        :param coding_system_entity: the previously inserted CodingSystem entity
        :return: The number of rows inserted
        """

        gp_rows = [cls.cacti_map_func(node, coding_system_entity) for node in global_nodes]

        return cls.bulk_insert(gp_rows)

    @classmethod
    def bulk_insert_from_ia_xml(cls, global_nodes, coding_system_entity):
        """
        GlobalProperty.insert_from_ia_xml(global_nodes, coding_system_entity) -> int
        :param global_nodes: the CACTI userConfiguration.xml global element from which to insert
        :param coding_system_entity: the previously inserted CodingSystem entity
        :return: The number of rows inserted
        """
        gv_rows = [cls.ia_map_func(node, coding_system_entity) for node in global_nodes]

        return cls.bulk_insert(gv_rows)


class GlobalValue(BaseModel):
    global_value_id = AutoField()
    global_property = ForeignKeyField(GlobalProperty, backref="global_values", index=True,
                                      column_name="global_property_id", on_update="CASCADE", on_delete="CASCADE")
    gv_value = TextField(null=False, column_name="gv_value")
    gv_description = TextField(null=False, unique=False)

    class Meta:
        constraints = [SQL('CONSTRAINT gv_value_gp_id_unique UNIQUE(gv_value, global_property_id)'),
                       SQL('CONSTRAINT gv_source_id_gp_id_unique UNIQUE(source_id, global_property_id)')]

    @classmethod
    def bulk_insert_from_cacti_xml(cls, global_node: et._Element, global_property_entity: GlobalProperty):
        """
        GlobalValue.bulk_insert_from_cacti_xml(globals_node, global_property_entity) -> int
        :param global_node: the CACTI userConfiguration.xml global element from which to insert
        :param global_property_entity: the previously inserted GlobalProperty entity
        :return: number of rows inserted
        """

        min_rating = int(global_node.get(CactiAttributes.MIN_RATING))
        max_rating = int(global_node.get(CactiAttributes.MAX_RATING)) + 1
        gv_rows = [{GlobalValue.global_property.name: global_property_entity,
                    GlobalValue.gv_value.name: value,
                    GlobalValue.gv_description.name: global_property_entity.gp_description + " " + str(value)}
                   for value in range(min_rating, max_rating)]

        cls.bulk_insert(gv_rows)

    @classmethod
    def bulk_insert_from_ia_xml(cls, gv_nodes: list, gp_entity: GlobalProperty):
        """
        GlobalValue.bulk_insert_from_ia_xml(gv_nodes: list[et._Element], gp_entity: GlobalProperty) -> int
        Performs a bulk insertion of all global PropertyValue elements into the database and returns the number of rows inserted
        Requires that all global Property elements have previously been inserted
        """

        gv_rows = ({GlobalValue.source_id.name: int(node.get(IaProperties.PROPERTY_VALUE_ID)),
                    GlobalValue.gv_value.name: node.get(IaProperties.VALUE),
                    GlobalValue.gv_description.name: node.get(IaProperties.DESCRIPTION),
                    GlobalValue.global_property.name: gp_entity}
                   for node in gv_nodes)

        return cls.bulk_insert(gv_rows)


class PropertyValue(BaseModel):
    property_value_id = AutoField()
    coding_property = ForeignKeyField(CodingProperty, backref="property_values", null=False, index=True,
                                      column_name="coding_property_id", on_delete="CASCADE", on_update="CASCADE")
    pv_value = TextField(null=False, index=True, unique=False, column_name="pv_value")
    pv_description = TextField(null=False, index=False, unique=False)
    pv_summary_mode = TextField(null=True)

    class Meta:
        constraints = [SQL('CONSTRAINT pv_value_cp_id_unique UNIQUE (coding_property_id, pv_value)'),
                       SQL('CONSTRAINT source_id_cp_id_unique UNIQUE (source_id, coding_property_id)')]

    @classmethod
    def bulk_insert_from_cacti_xml(cls, property_node: et._Element, cp_entity):
        """
        PropertyValue.insert_from_cacti_xml(property_node, cp_entity, node_tag, transaction=None) -> int
        Inserts into the PropertyValues table rows contained within the children of property_node
        :param property_node: the CACTI userConfiguration.xml (codes or components) node containing the PropertyValues
        to be inserted
        :param cp_entity: the previously inserted CodingProperty entity to which the PropertyValues belong
        :return: The number of rows inserted
        """

        pv_tag = CactiNodes.CODE if property_node.tag == CactiNodes.CODES else \
            CactiNodes.COMPONENT if property_node.tag == CactiNodes.COMPONENTS else \
                None

        if pv_tag is None:
            raise ValueError("Invalid element type for property_node. " +
                             "Expected 'codes' or 'components', got {0}".format(property_node.tag))

        # Collect the row data from the elements
        # Because this table is self referential with pv_parent -> property_value_id,
        # inserts need to be performed in an order s.t. parents always insert before their children
        # This sort should put things in the appropriate order
        code_nodes = property_node.findall(pv_tag)
        pv_rows = [{PropertyValue.coding_property.name: cp_entity,
                    PropertyValue.pv_value.name: node.get(CactiAttributes.NAME
                                                          if pv_tag == CactiNodes.CODE
                                                          else CactiAttributes.VALUE),
                    PropertyValue.source_id.name: node.get(CactiAttributes.VALUE)
                    if pv_tag == CactiNodes.CODE
                    else None,
                    PropertyValue.pv_description.name: node.get(CactiAttributes.DESCRIPTION),
                    PropertyValue.pv_summary_mode.name: node.get(CactiAttributes.SUM_MODE)}
                   for node in code_nodes]

        return cls.bulk_insert(pv_rows)

    @classmethod
    def bulk_insert_from_ia_xml(cls, pv_nodes: list, cp_entity: CodingProperty):
        """
        pv.bulk_insert_from_ia_xml(cls, pv_nodes: list[et._Element], cp_entity: CodingProperty) -> int
        performs a bulk insertion into the PropertyValue table from pv_nodes and returns the number of rows inserted
        :param pv_nodes: the sequence of IA PropertyValue nodes from which to insert
        :param cp_entity: The previously inserted CodingProperty entity which is the parent of the PropertyValues to insert
        :return int: the number of rows inserted
        :raises peewee.PeeweeException: if insertion fails
        """

        pv_rows = [{PropertyValue.coding_property.name: cp_entity,
                    PropertyValue.pv_value.name: node.get(IaProperties.VALUE),
                    PropertyValue.pv_description.name: node.get(IaProperties.DESCRIPTION),
                    PropertyValue.source_id.name: int(node.get(IaProperties.PROP_VALUE_ID))} for node in
                   pv_nodes]

        return cls.bulk_insert(pv_rows)


class Utterance(BaseModel):
    utterance_id = AutoField()
    interview = ForeignKeyField(Interview, backref="utterances", column_name='interview_id',
                                index=True)
    utt_line = IntegerField(null=True)
    utt_enum = IntegerField(null=False)
    utt_role = TextField(null=True)
    utt_text = TextField(null=True)
    utt_word_count = IntegerField(null=True)
    utt_start_time = FloatField(null=True)
    utt_end_time = FloatField(null=True)

    class Meta:
        constraints = [SQL('CONSTRAINT utt_enum_iv_id_unique UNIQUE (utt_enum, interview_id)'),
                       SQL('CONSTRAINT source_id_iv_id_unique UNIQUE (source_id, interview_id)')]


class UtteranceCode(BaseModel):
    utterance_code_id = AutoField()
    utterance = ForeignKeyField(Utterance, index=True, null=False, backref="codes", on_update="CASCADE",
                                on_delete="CASCADE")
    property_value = ForeignKeyField(PropertyValue, index=True, null=False, backref="codes", on_update="CASCADE",
                                     on_delete="CASCADE")


class GlobalRating(BaseModel):
    global_rating_id = AutoField()
    global_value = ForeignKeyField(GlobalValue, index=True, null=False, column_name="global_value_id",
                                   on_delete="CASCADE", on_update="CASCADE")
    interview = ForeignKeyField(Interview, backref="globals", index=True, column_name="interview_id",
                                on_delete="CASCADE", on_update="CASCADE")

    class Meta:
        constraints = [SQL('CONSTRAINT gv_id_iv_id_unique UNIQUE (global_value_id, interview_id)')]


def init_database(path=":memory:"):
    db.init(path, pragmas={'journal_mode': 'wal',
                           'cache_size': -1 * 64000,  # 64MB
                           'foreign_keys': 1,
                           'ignore_check_constraints': 0})
    if path != MEMORY:
        try:
            db.connect(reuse_if_open=True)
        except:
            conn = sqlite3.connect(path)
            conn.close()
    db.connect(reuse_if_open=True)
    db.create_tables([CodingSystem, Interview, CodingProperty, GlobalProperty, PropertyValue,
                      GlobalValue, Utterance, UtteranceCode, GlobalRating])


def close_database():
    db.close()
