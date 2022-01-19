from caastools.database.database import db
from peewee import AutoField, BooleanField, chunked, FloatField, ForeignKeyField, IntegerField, Model, \
    ModelInsert, SQL, TextField

from typing import Iterable
import logging


logging.getLogger('database.models').addHandler(logging.NullHandler())


__all__ = ['CodingSystem', 'CodingProperty', 'PropertyValue', 'Interview', 'Utterance',
           'UtteranceCode', 'GlobalProperty', 'GlobalValue', 'GlobalRating', 'UtteranceStaging',
           'GlobalStaging', 'Translation', 'TranslationSource', 'TranslationTarget']


class BaseModel(Model):

    oc_actions = {'ignore': ModelInsert.on_conflict_ignore,
                  'replace': ModelInsert.on_conflict_replace}
    source_id = IntegerField(null=True, index=True, unique=False)

    @classmethod
    def bulk_insert(cls, data: Iterable[dict], on_conflict='replace') -> int:
        """
        BaseModel.bulk_insert(row_dict: dict) -> int
        Performs an atomic bulk insertion of the data provided in row_dicts and returns the number of rows inserted
        :param data: sequence of dictionary objects mapping field names to values to insert
        :param on_conflict: How to handle rows with a unique constraint violation ['ignore' | 'replace'] (default 'replace')
        :return int: The number of rows inserted
        :raise peewee.PeeweeException: if bulk insertion fails
        """

        action = cls.oc_actions.get(on_conflict, ModelInsert.on_conflict_replace)
        rows_inserted = 0
        with cls._meta.database.atomic() as transaction:
            for batch in chunked(data, 100):
                query = cls.insert_many(batch)
                query = action(query)
                rows_inserted += query.execute()

        return rows_inserted

    class Meta:
        database = db

    def __lt__(self, other):
        pk_name = self._meta.get_primary_keys()[0].name
        return getattr(self, pk_name) < getattr(other, pk_name)

    def __gt__(self, other):
        pk_name = self._meta.get_primary_keys()[0].name
        return getattr(self, pk_name) > getattr(other, pk_name)

    def __int__(self):
        pk_name = self._meta.get_primary_keys()[0].name
        return int(getattr(self, pk_name))


class CodingSystem(BaseModel):
    coding_system_id = AutoField()
    source_id = IntegerField(null=True, index=True, unique=True)
    cs_name = TextField(null=False, index=True, unique=True)
    cs_path = TextField(null=False, index=True, unique=True)


# Project structures usually maintain two databases because interviews need to be unique.
# Instead, switching to a single DB structure, so need to think about the ground truth of interviews
# Add a new field that specifies whether an interview is reliability or not
class Interview(BaseModel):
    source_id = IntegerField(null=True, index=True, unique=True)
    interview_id = AutoField()
    interview_name = TextField(null=False, index=True, unique=False)
    interview_type = TextField(null=False, index=True, unique=False, choices=['general', 'reliability'],
                               default='general')
    coding_system = ForeignKeyField(CodingSystem, backref="interviews", null=True, index=True, on_delete="SET NULL",
                                    on_update="CASCADE")
    session_number = IntegerField(null=False, index=True, unique=False)
    study_id = IntegerField(null=True, unique=False, index=True)
    client_id = TextField(null=False, unique=False, index=True)
    rater_id = TextField(null=False, unique=False, index=True)  # Changed to TextField for V1.2
    therapist_id = IntegerField(null=True, unique=False, index=False)
    language = TextField(null=True, unique=False, index=False, default='en')
    treatment_condition_id = IntegerField(null=True, unique=False, index=False)

    class Meta:
        constraints = [SQL('CONSTRAINT iv_name_iv_type UNIQUE(interview_name, interview_type)')]


class CodingProperty(BaseModel):
    coding_property_id = AutoField()
    coding_system = ForeignKeyField(CodingSystem, backref="coding_properties", on_update="CASCADE",
                                    on_delete="CASCADE", null=False, index=True, unique=False,
                                    column_name="coding_system_id")
    cp_name = TextField(null=False, index=False, unique=False)
    cp_display_name = TextField(null=False, index=False, unique=False)
    cp_abbreviation = TextField(null=True, index=False, unique=False)
    cp_sort_order = IntegerField(null=False, index=False, unique=False, default=0)
    cp_data_type = TextField(null=False, index=False, unique=False, default="string", choices=['string', 'numeric'])
    cp_decimal_digits = IntegerField(null=False, default=0)
    cp_zero_pad = BooleanField(null=False, default=False)
    cp_description = TextField(null=False, index=False, unique=False)

    class Meta:
        constraints = [SQL('CONSTRAINT cp_name_cs_id_unique UNIQUE(cp_name, coding_system_id)'),
                       SQL('CONSTRAINT cp_name_cs_id_unique UNIQUE(cp_display_name, coding_system_id)'),
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


class UtteranceStaging(BaseModel):
    interview_name = TextField(null=False, index=True)
    interview_type = TextField(null=False, index=True, choices=['general', 'reliability'], default='general')
    cs_name = TextField(null=False, index=True)
    cp_name = TextField(null=False, index=True)
    utt_line = IntegerField(null=True, index=True)
    utt_enum = IntegerField(null=False, index=True)
    utt_role = TextField(null=True)
    utt_text = TextField(null=True)
    utt_word_count = IntegerField(null=True)
    utt_start_time = FloatField(null=True)
    utt_end_time = FloatField(null=True)
    pv_value = TextField(null=True, index=True)


class GlobalStaging(BaseModel):
    interview_name = TextField(null=False, index=True)
    interview_type = TextField(null=False, index=True, choices=['general', 'reliability'], default='general')
    cs_name = TextField(null=False, index=True)
    gp_name = TextField(null=False, index=True)
    gv_value = TextField(null=False, index=True)


class Translation(BaseModel):
    translation_id = AutoField()
    description = TextField(null=False, unique=True, index=True)
    source_cs = ForeignKeyField(CodingSystem, index=True, null=False, on_update='CASCADE', on_delete='CASCADE')
    target_cs = ForeignKeyField(CodingSystem, index=True, null=False, on_update='CASCADE', on_delete='CASCADE')


class TranslationTarget(BaseModel):
    translation_target_id = AutoField()
    translation = ForeignKeyField(Translation, null=False, index=True, unique=True,
                                  on_update='CASCADE', on_delete='CASCADE')
    parent_table_name = TextField(index=True, choices=['GlobalValue', 'PropertyValue'])
    parent_primary_key = IntegerField(index=True, null=False)

    class Meta:
        constraints = [
            SQL("CONSTRAINT x_table_names CHECK (LOWER(parent_table_name) IN ('globalvalue', 'propertyvalue'))"),
            SQL("CONSTRAINT x_target_unique UNIQUE (translation_id, parent_table_name, parent_primary_key)")
        ]


class TranslationSource(BaseModel):
    translation_source_id = AutoField()
    translation = ForeignKeyField(Translation, null=False, index=True, on_delete='CASCADE', on_update='CASCADE')
    parent_table_name = TextField(index=True, choices=['GlobalValue', 'PropertyValue'])
    parent_primary_key = IntegerField(index=True, null=False)
    is_root = BooleanField(index=True, null=False, default=False)

    class Meta:
        constraints = [
            SQL("CONSTRAINT x_table_names CHECK (LOWER(parent_table_name) IN ('globalvalue', 'propertyvalue'))"),
            SQL("CONSTRAINT x_source_unique UNIQUE (translation_id, parent_table_name, parent_primary_key)")
        ]


class TranslationSourceRoot(BaseModel):
    translation_source_root_id = AutoField()
    translation_source = ForeignKeyField(TranslationSource, null=False, index=True, unique=True, on_update='CASCADE',
                                         on_delete='CASCADE')

    class Meta:
        table_name = 'translation_source_root'
