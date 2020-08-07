from peewee import AutoField, BooleanField, chunked, FloatField, ForeignKeyField, IntegerField, Model, \
    OperationalError, SQL, TextField
from playhouse.sqlite_ext import SqliteExtDatabase
from typing import Sequence, Iterable
import logging


logging.getLogger('database.models').addHandler(logging.NullHandler())
db = SqliteExtDatabase(None)
atomic = db.atomic

__all__ = ['atomic', 'close_database', 'CodingSystem', 'CodingProperty', 'PropertyValue', 'Interview', 'Utterance',
           'UtteranceCode', 'GlobalProperty', 'GlobalValue', 'GlobalRating', 'init_database']

MEMORY = ":memory:"


class BaseModel(Model):
    source_id = IntegerField(null=True, index=True, unique=False)

    @classmethod
    def bulk_insert(cls, data: Iterable[dict]) -> int:
        """
        BaseModel.bulk_insert(row_dict: dict) -> int
        Performs an atomic bulk insertion of the data provided in row_dicts and returns the number of rows inserted
        :param data: sequence of dictionary objects mapping field names to values to insert
        :return int: The number of rows inserted
        :raise peewee.PeeweeException: if bulk insertion fails
        """
        rows_inserted = 0
        with cls._meta.database.atomic() as transaction:
            for batch in chunked(data, 100):
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
    coding_system = ForeignKeyField(CodingSystem, backref="interviews", null=True, index=True, on_delete="SET NULL",
                                    on_update="CASCADE")
    session_number = IntegerField(null=False, index=True, unique=False)
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


class GlobalProperty(BaseModel):
    global_property_id = AutoField()
    coding_system = ForeignKeyField(CodingSystem, backref="globals", on_delete="CASCADE", on_update="CASCADE",
                                    column_name="coding_system_id", index=True, null=False)
    gp_name = TextField(null=False, unique=False)
    gp_description = TextField(null=False, unique=False)
    gp_data_type = TextField(null=False, index=False, unique=False, default="string")
    gp_parent = ForeignKeyField('self', null=True, backref='children', on_update='CASCADE', on_delete="SET NULL",
                                index=True, unique=False)
    gp_summary_mode = TextField(null=True, unique=False, index=False)

    class Meta:
        constraints = [SQL('CONSTRAINT gp_source_id_cs_id_unique UNIQUE(source_id, coding_system_id)')]

    def __repr__(self):
        return "<GlobalProperty: {0} | {1}>".format(self.global_property_id, self.gp_name)


class GlobalValue(BaseModel):
    global_value_id = AutoField()
    global_property = ForeignKeyField(GlobalProperty, backref="global_values", index=True, null=False,
                                      column_name="global_property_id", on_update="CASCADE", on_delete="CASCADE")
    gv_value = TextField(null=False, column_name="gv_value")
    gv_description = TextField(null=False, unique=False)

    class Meta:
        constraints = [SQL('CONSTRAINT gv_value_gp_id_unique UNIQUE(gv_value, global_property_id)'),
                       SQL('CONSTRAINT gv_source_id_gp_id_unique UNIQUE(source_id, global_property_id)')]

    def __repr__(self):
        return "<GlobalValue: {0} | {1}>".format(self.global_value_id, self.gv_value)


class PropertyValue(BaseModel):
    property_value_id = AutoField()
    coding_property = ForeignKeyField(CodingProperty, backref="property_values", null=False, index=True,
                                      column_name="coding_property_id", on_delete="CASCADE", on_update="CASCADE")
    pv_value = TextField(null=False, index=True, unique=False, column_name="pv_value")
    pv_description = TextField(null=False, index=False, unique=False)
    pv_summary_mode = TextField(null=True)
    pv_parent = ForeignKeyField('self', null=True, backref='children', on_update="CASCADE", on_delete="SET NULL")

    class Meta:
        constraints = [SQL('CONSTRAINT pv_value_cp_id_unique UNIQUE (coding_property_id, pv_value)'),
                       SQL('CONSTRAINT source_id_cp_id_unique UNIQUE (source_id, coding_property_id)')]

    def __repr__(self):
        return "<PropertyValue: {0} | {1}>".format(self.property_value_id, self.pv_value)


class Utterance(BaseModel):
    utterance_id = AutoField()
    interview = ForeignKeyField(Interview, backref="utterances", column_name='interview_id',
                                index=True, null=False, unique=False, on_delete="CASCADE", on_update="CASCADE")
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
                                on_delete="CASCADE", column_name='utterance_id')
    property_value = ForeignKeyField(PropertyValue, index=True, null=False, backref="codes", on_update="CASCADE",
                                     on_delete="CASCADE", column_name='property_value_id')

    class Meta:
        constraints = [SQL('CONSTRAINT utt_id_pv_iq_unique UNIQUE(utterance_id, property_value_id)')]


class GlobalRating(BaseModel):
    global_rating_id = AutoField()
    global_value = ForeignKeyField(GlobalValue, index=True, null=False, column_name="global_value_id",
                                   on_delete="CASCADE", on_update="CASCADE")
    interview = ForeignKeyField(Interview, backref="globals", index=True, column_name="interview_id",
                                on_delete="CASCADE", on_update="CASCADE")

    class Meta:
        constraints = [SQL('CONSTRAINT gv_id_iv_id_unique UNIQUE (global_value_id, interview_id)')]


def init_database(path=":memory:", use_memory_on_failure=True):
    """
    Establish the connecction to the database at path.
    :param path: path to the SQLite database
    :param use_memory_on_failure: Whether to initialize an in-memory database upon failure to connect. Default True
    :return: None
    """
    pragmas = {'journal_mode': 'wal',
               'cache_size': -1 * 64000,  # 64MB
               'foreign_keys': 1,
               'ignore_check_constraints': 0}
    db.init(path, pragmas=pragmas)
    if path != MEMORY:
        try:
            db.connect(reuse_if_open=True)
        except OperationalError as err:
            if use_memory_on_failure:
                logging.error(f"Unable to connect to the database at {path}.\nDefaulting to :memory:")
                db.init(MEMORY, pragmas=pragmas)
                db.connect(reuse_if_open=True)
            else:
                raise err

    db.create_tables([CodingSystem, Interview, CodingProperty, GlobalProperty, PropertyValue,
                      GlobalValue, Utterance, UtteranceCode, GlobalRating])


def close_database():
    db.close()
