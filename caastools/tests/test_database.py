import unittest
from ..database import UtteranceStaging, CodingSystem, CodingProperty, Interview, init_database, close_database, \
    PropertyValue, Utterance, UtteranceCode


class TestDatabase(unittest.TestCase):


    def setUp(self) -> None:
        init_database()
        self.coding_system = CodingSystem.create(cs_name="TEST_CODING_SYSTEM", cs_path='.')
        self.interview = Interview.create(interview_name="TEST_INTERVIEW", coding_system=self.coding_system,
                                          session_number=1, client_id=1, rater_id=1)
        self.coding_property = CodingProperty.create(coding_system=self.coding_system, cp_name="MISC",
                                                    cp_display_name="MISC", cp_description="MISC2.5")
        self.property_value = PropertyValue.create(pv_value='FI', pv_description='Filler',
                                                   coding_property=self.coding_property)

    def tearDown(self) -> None:
        close_database()

    def test_utterance_staging(self):

        SAMPLE_DATA = (
            {UtteranceStaging.interview_name.name: self.interview.interview_name,
             UtteranceStaging.cs_name.name: self.coding_system.cs_name,
             UtteranceStaging.cp_name.name: self.coding_property.cp_name,
             UtteranceStaging.utt_enum.name: 0,
             UtteranceStaging.utt_start_time.name: 2.0,
             UtteranceStaging.utt_end_time.name: 3.0,
             UtteranceStaging.pv_value.name: 'FI',
             },
            {UtteranceStaging.interview_name.name: self.interview.interview_name,
             UtteranceStaging.cs_name.name: self.coding_system.cs_name,
             UtteranceStaging.cp_name.name: self.coding_property.cp_name,
             UtteranceStaging.utt_enum.name: 1,
             UtteranceStaging.utt_start_time.name: 3.0,
             UtteranceStaging.utt_end_time.name: 5.0,
             UtteranceStaging.pv_value.name: 'FI',
             },)

        EXPECTED_UTTERANCE = ({Utterance.interview_id.name: self.interview.interview_id,
                              Utterance.utt_enum.name: 0,
                              Utterance.utt_start_time.name: 2.0,
                              Utterance.utt_end_time.name: 3.0,
                              },
                              {Utterance.interview_id.name: self.interview.interview_id,
                               Utterance.utt_enum.name: 1,
                               Utterance.utt_start_time.name: 3.0,
                               Utterance.utt_end_time.name: 5.0,
                               }
                              )

        # Test that insertion into the utterance_staging table works
        rows_inserted = UtteranceStaging.bulk_insert(SAMPLE_DATA)
        self.assertEqual(rows_inserted, 2)

        # Test that rows are as expected
        inserted_rows = UtteranceStaging.select(UtteranceStaging.interview_name,
                                                UtteranceStaging.cs_name,
                                                UtteranceStaging.cp_name,
                                                UtteranceStaging.utt_enum,
                                                UtteranceStaging.utt_start_time,
                                                UtteranceStaging.utt_end_time,
                                                UtteranceStaging.pv_value).dicts().execute()

        for row, sample in zip(inserted_rows, SAMPLE_DATA):
            self.assertEqual(row, sample)

        # Test that unstaging utterances works as expected
        rows_inserted = self.unstage_utterances(self.interview.interview_name, truncate_after=False)
        self.assertEqual(rows_inserted, 2)

        inserted_rows = Utterance.select(Utterance.interview_id, Utterance.utt_enum,
                                         Utterance.utt_start_time, Utterance.utt_end_time).dicts().execute()

        for expected, actual in zip(EXPECTED_UTTERANCE, inserted_rows):
            self.assertEqual(expected, actual)

        # Test that unstaging utterance codes works as expected
        rows_inserted = self.unstage_utterance_codes(self.interview.interview_name, truncate_after=False)
        self.assertEqual(rows_inserted, 2)

        EXPECTED_UTT_CODE = ({UtteranceCode.utterance_id.name: d.utterance_id,
                              UtteranceCode.property_value_id.name: self.property_value.property_value_id}
                              for d in Utterance.select().execute())

        inserted_rows = UtteranceCode.select(UtteranceCode.utterance_id,
                                             UtteranceCode.property_value_id).dicts().execute()

        for expected, actual in zip(EXPECTED_UTT_CODE, inserted_rows):
            self.assertEqual(expected, actual)

    def unstage_utterance_codes(self, interview, truncate_after=True):
        """
        Unstages records from the UtteranceCodeStaging table, and uses them to create rows in the UtteranceCodes table
        :param interview: The interview for which UtteranceCode data should be unstaged
        :param truncate_after: Whether to truncate the table after unstaging is complete
        :return: number of rows inserted
        """

        # Once the raw data is in the staging table, we can use it to update the UtteranceCode table
        # First step is to build the expression that will for the basis of the INSERT INTO ... SELECT statement

        # The following is a CTE that will help locate PropertyValueID for a given Utterance's code
        pv_locate = PropertyValue.select(CodingSystem.cs_name, CodingProperty.cp_name, PropertyValue.pv_value,
                                         PropertyValue.property_value_id).join(CodingProperty) \
            .join(CodingSystem) \
            .cte("PropertyValueLocate", columns=['cs_name', 'cp_name', 'pv_value', 'property_value_id'])

        # The CTE Below will help locate the UtteranceID of a given Utterance's code
        utt_locate = Utterance.select(Interview.interview_name, Utterance.utt_enum, Utterance.utterance_id) \
            .join(Interview) \
            .cte("UttLocate", columns=['interview_name', 'utt_enum', 'utterance_id'])

        # This will create a join between the staging table and the above CTEs to select the utterance code data
        # for an interview
        select_query = UtteranceStaging.select(utt_locate.c.utterance_id, pv_locate.c.property_value_id) \
            .join(utt_locate, on=((UtteranceStaging.interview_name == utt_locate.c.interview_name) &
                                  (UtteranceStaging.utt_enum == utt_locate.c.utt_enum))) \
            .switch(UtteranceStaging) \
            .join(pv_locate, on=((UtteranceStaging.cp_name == pv_locate.c.cp_name) &
                                 (UtteranceStaging.cs_name == pv_locate.c.cs_name) &
                                 (UtteranceStaging.pv_value == pv_locate.c.pv_value))) \
            .where(UtteranceStaging.interview_name == interview) \
            .with_cte(utt_locate, pv_locate)

        # Now use the fully constructed query to insert rows into the UtteranceCode table
        insert_query = UtteranceCode.insert_from(select_query,
                                                 [UtteranceCode.utterance_id, UtteranceCode.property_value_id])
        rows_inserted = insert_query.execute()

        if truncate_after:
            UtteranceStaging.truncate_table()

        return rows_inserted

    def unstage_utterances(self, interview_name, truncate_after=False):
        """
        transfers data from the UtteranceStaging table to the Utterances table
        :param interview: the interview to which Utterance data belongs
        :param truncate_after: Whether to truncate the table after insertion. Default False
        :return: Number of rows inserted
        """
        rows_inserted = 0

        # Table expression will locate the necessary interview IDs
        iv_locate = Interview.select(Interview.interview_name, Interview.interview_id) \
            .cte("InterviewLocate", columns=['interview_name', 'interview_id'])

        # Join the Staging table on the table expression above to get all the data required for the insertion
        select_query = UtteranceStaging.select(iv_locate.c.interview_id, UtteranceStaging.utt_enum,
                                               UtteranceStaging.utt_start_time, UtteranceStaging.utt_end_time) \
            .join(iv_locate, on=(UtteranceStaging.interview_name == iv_locate.c.interview_name)) \
            .where(UtteranceStaging.interview_name == interview_name).distinct(True).with_cte(iv_locate)

        insert_query = Utterance.insert_from(select_query,
                                             [Utterance.interview_id, Utterance.utt_enum, Utterance.utt_start_time,
                                              Utterance.utt_end_time])

        rows_inserted = insert_query.execute()

        if truncate_after:
            UtteranceStaging.truncate_table()

        return rows_inserted


if __name__ == '__main__':
    unittest.main()
