from caastools.database.models import *
from caastools.database.bulkinsert import *
from caastools.constants import CodingSystemType
import io
import os
import peewee
import sqlite3
import unittest


_VALID_CACTI_ = \
"""<userConfiguration name="CAMI_CACTI">
    <codes codingPropertyName="MISC2.5">
        <code name="QU" value="1000" description="Question" role="T" mico="NA" isSummary="1" summaryMode="sum"/>
        <code name="QUO" value="1100" description="Open Question" role="T" mico="Y" isSummary="1" 
        summaryMode="sum" parent="1000"/>
    </codes>
    <codeControls panel="left" label="Therapist">
    </codeControls>
    <codeControls panel="right" label="Client">
    </codeControls>
    <globals>
        <global name="Spirit" isSummary="1" summaryMode="mean" seqUse="0" reverse="0" label="MI Spirit" 
        type="MISC" value="1110" 
        defaultRating="3" minRating="1" maxRating="5" description="MI Spirit"/>
        <global name="Collaboration" isSummary="0" seqUse="0" reverse="0" scale="Spirit" 
        label="TherapistCollaboration" description="MISC global: Collaboration" type="MISC" value="1111" 
        defaultRating="3" minRating="1"  maxRating="5" parent="1110"/>
        <global name="Autonomy" isSummary="0" seqUse="0" reverse="0" scale="Spirit" label="Therapist Autonomy" 
        type="MISC" value="1112" defaultRating="3" minRating="1" maxRating="5" 
        description="MISC global: Autonomy   Support" parent="1110"/>
        <global name="Evocation" isSummary="0" seqUse="0" reverse="0" scale="Spirit" label="Evocation" 
        description="MISC global: Evocation" type="MISC" value="1113" defaultRating="3" minRating="1" 
        maxRating="5" parent="1110"/>
    </globals>
    <globalControls panel="left">
    </globalControls>
    <globalsBorder label="Global Ratings"/>
    <components codingPropertyName="CAMI_Components">
        <component name="Component1" value="1" description="Session Intro"/>
    </components>
</userConfiguration>
"""

VALID_IA = \
"""
<NewDataSet>
  <xs:schema id="NewDataSet" xmlns="" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:msdata="urn:schemas-microsoft-com:xml-msdata">
    <xs:element name="NewDataSet" msdata:IsDataSet="true" msdata:UseCurrentLocale="true">
      <xs:complexType>
        <xs:choice minOccurs="0" maxOccurs="unbounded">
          <xs:element name="CodingSystem">
            <xs:complexType>
              <xs:sequence>
                <xs:element name="CodingSystemID" type="xs:int" minOccurs="0" />
                <xs:element name="SystemName" type="xs:string" minOccurs="0" />
                <xs:element name="ShortName" type="xs:string" minOccurs="0" />
                <xs:element name="Description" type="xs:string" minOccurs="0" />
                <xs:element name="SortOrder" type="xs:decimal" minOccurs="0" />
                <xs:element name="IsActive" type="xs:boolean" minOccurs="0" />
                <xs:element name="IsDefault" type="xs:boolean" minOccurs="0" />
                <xs:element name="OriginalKeyID" type="xs:int" minOccurs="0" />
                <xs:element name="DateCreated" type="xs:dateTime" minOccurs="0" />
                <xs:element name="CreatedBy" type="xs:string" minOccurs="0" />
                <xs:element name="LastModified" type="xs:dateTime" minOccurs="0" />
                <xs:element name="ModifiedBy" type="xs:string" minOccurs="0" />
              </xs:sequence>
            </xs:complexType>
          </xs:element>
          <xs:element name="Properties">
            <xs:complexType>
              <xs:sequence>
                <xs:element name="PropertyID" type="xs:int" minOccurs="0" />
                <xs:element name="CodingSystemID" type="xs:int" minOccurs="0" />
                <xs:element name="PropertyName" type="xs:string" minOccurs="0" />
                <xs:element name="DisplayName" type="xs:string" minOccurs="0" />
                <xs:element name="Abbreviation" type="xs:string" minOccurs="0" />
                <xs:element name="Description" type="xs:string" minOccurs="0" />
                <xs:element name="SortOrder" type="xs:int" minOccurs="0" />
                <xs:element name="PropertyType" type="xs:string" minOccurs="0" />
                <xs:element name="DecimalDigits" type="xs:int" minOccurs="0" />
                <xs:element name="AutoFillScopeID" type="xs:int" minOccurs="0" />
                <xs:element name="ZeroPad" type="xs:boolean" minOccurs="0" />
                <xs:element name="DisplayAlternateColors" type="xs:boolean" minOccurs="0" />
                <xs:element name="SparseDisplay" type="xs:boolean" minOccurs="0" />
                <xs:element name="OriginalKeyID" type="xs:int" minOccurs="0" />
                <xs:element name="DateCreated" type="xs:dateTime" minOccurs="0" />
                <xs:element name="CreatedBy" type="xs:string" minOccurs="0" />
                <xs:element name="LastModified" type="xs:dateTime" minOccurs="0" />
                <xs:element name="ModifiedBy" type="xs:string" minOccurs="0" />
              </xs:sequence>
            </xs:complexType>
          </xs:element>
          <xs:element name="PropertyValues">
            <xs:complexType>
              <xs:sequence>
                <xs:element name="PropertyValueID" type="xs:int" minOccurs="0" />
                <xs:element name="PropertyID" type="xs:int" minOccurs="0" />
                <xs:element name="PropertyValue" type="xs:string" minOccurs="0" />
                <xs:element name="Description" type="xs:string" minOccurs="0" />
                <xs:element name="SortOrder" type="xs:decimal" minOccurs="0" />
                <xs:element name="OriginalKeyID" type="xs:int" minOccurs="0" />
                <xs:element name="DateCreated" type="xs:dateTime" minOccurs="0" />
                <xs:element name="CreatedBy" type="xs:string" minOccurs="0" />
                <xs:element name="LastModified" type="xs:dateTime" minOccurs="0" />
                <xs:element name="ModifiedBy" type="xs:string" minOccurs="0" />
              </xs:sequence>
            </xs:complexType>
          </xs:element>
        </xs:choice>
      </xs:complexType>
    </xs:element>
  </xs:schema>
  <CodingSystem>
    <CodingSystemID>153</CodingSystemID>
    <SystemName>UCHAT 3.4</SystemName>
    <ShortName>U3.4</ShortName>
    <Description>UCHATCoding System 3.4</Description>
    <SortOrder>1</SortOrder>
    <IsActive>true</IsActive>
    <IsDefault>true</IsDefault>
    <DateCreated>2019-05-07T12:23:10.397-04:00</DateCreated>
    <CreatedBy>j1w</CreatedBy>
    <LastModified>2019-05-08T15:12:29.44-04:00</LastModified>
    <ModifiedBy>j1w</ModifiedBy>
  </CodingSystem>
  <Properties>
    <PropertyID>425</PropertyID>
    <CodingSystemID>153</CodingSystemID>
    <PropertyName>TBO</PropertyName>
    <DisplayName>TBO</DisplayName>
    <Abbreviation>TBO</Abbreviation>
    <Description>Targeted Behavior Outcome</Description>
    <SortOrder>1</SortOrder>
    <PropertyType>numeric</PropertyType>
    <DecimalDigits>3</DecimalDigits>
    <AutoFillScopeID>1</AutoFillScopeID>
    <ZeroPad>true</ZeroPad>
    <DisplayAlternateColors>true</DisplayAlternateColors>
    <SparseDisplay>true</SparseDisplay>
    <DateCreated>2019-05-07T12:23:10.397-04:00</DateCreated>
    <CreatedBy>j1w</CreatedBy>
    <LastModified>2019-05-07T12:23:10.397-04:00</LastModified>
    <ModifiedBy>j1w</ModifiedBy>
  </Properties>
  <Properties>
    <PropertyID>428</PropertyID>
    <CodingSystemID>153</CodingSystemID>
    <PropertyName>Topic Codes</PropertyName>
    <DisplayName>Topic</DisplayName>
    <Abbreviation>Top</Abbreviation>
    <Description>Topic Codes</Description>
    <SortOrder>2</SortOrder>
    <PropertyType>numeric</PropertyType>
    <DecimalDigits>4</DecimalDigits>
    <AutoFillScopeID>0</AutoFillScopeID>
    <ZeroPad>true</ZeroPad>
    <DisplayAlternateColors>true</DisplayAlternateColors>
    <SparseDisplay>true</SparseDisplay>
    <DateCreated>2019-05-07T12:23:10.397-04:00</DateCreated>
    <CreatedBy>j1w</CreatedBy>
    <LastModified>2019-05-07T12:47:54.82-04:00</LastModified>
    <ModifiedBy>j1w</ModifiedBy>
  </Properties>
  <PropertyValues>
    <PropertyValueID>15038</PropertyValueID>
    <PropertyID>425</PropertyID>
    <PropertyValue>1.000</PropertyValue>
    <Description>Alcohol use</Description>
    <SortOrder>0.0000</SortOrder>
    <DateCreated>2019-05-07T12:23:10.46-04:00</DateCreated>
    <CreatedBy>j1w</CreatedBy>
    <LastModified>2019-05-07T12:23:10.46-04:00</LastModified>
    <ModifiedBy>j1w</ModifiedBy>
  </PropertyValues>
  <PropertyValues>
    <PropertyValueID>15039</PropertyValueID>
    <PropertyID>425</PropertyID>
    <PropertyValue>2.000</PropertyValue>
    <Description>Risky sexual behaviors</Description>
    <SortOrder>0.0000</SortOrder>
    <DateCreated>2019-05-07T12:23:10.46-04:00</DateCreated>
    <CreatedBy>j1w</CreatedBy>
    <LastModified>2019-05-07T12:23:10.46-04:00</LastModified>
    <ModifiedBy>j1w</ModifiedBy>
  </PropertyValues>
   <PropertyValues>
    <PropertyValueID>15145</PropertyValueID>
    <PropertyID>428</PropertyID>
    <PropertyValue>5.0000</PropertyValue>
    <Description>HIV</Description>
    <SortOrder>0.0000</SortOrder>
    <DateCreated>2019-05-07T12:23:10.46-04:00</DateCreated>
    <CreatedBy>j1w</CreatedBy>
    <LastModified>2019-05-07T12:47:54.82-04:00</LastModified>
    <ModifiedBy>j1w</ModifiedBy>
  </PropertyValues>
</NewDataSet>
"""

INVALID_SAME_VALUE = \
"""<userConfiguration name="CAMI_CACTI">
    <codes codingPropertyName="MISC2.5">
        <code name="QU" value="1000" description="Question" role="T" mico="NA" isSummary="1" summaryMode="sum"/>
        <code name="QUO" value="1000" description="Open Question" role="T" mico="Y" isSummary="1" 
        summaryMode="sum" parent="1000"/>
    </codes>
    <codeControls panel="left" label="Therapist">
    </codeControls>
    <codeControls panel="right" label="Client">
    </codeControls>
    <globals>
        <global name="Spirit" isSummary="1" summaryMode="mean" seqUse="0" reverse="0" label="MI Spirit" 
        type="MISC" value="1110" 
        defaultRating="3" minRating="1" maxRating="5" description="MI Spirit"/>
        <global name="Collaboration" isSummary="0" seqUse="0" reverse="0" scale="Spirit" 
        label="TherapistCollaboration" description="MISC global: Collaboration" type="MISC" value="1111" 
        defaultRating="3" minRating="1"  maxRating="5" parent="1110"/>
        <global name="Autonomy" isSummary="0" seqUse="0" reverse="0" scale="Spirit" label="Therapist Autonomy" 
        type="MISC" value="1112" defaultRating="3" minRating="1" maxRating="5" 
        description="MISC global: Autonomy   Support" parent="1110"/>
        <global name="Evocation" isSummary="0" seqUse="0" reverse="0" scale="Spirit" label="Evocation" 
        description="MISC global: Evocation" type="MISC" value="1113" defaultRating="3" minRating="1" 
        maxRating="5" parent="1110"/>
    </globals>
    <globalControls panel="left">
    </globalControls>
    <globalsBorder label="Global Ratings"/>
    <components codingPropertyName="CAMI_Components">
        <component name="Component1" value="1" description="Session Intro"/>
    </components>
</userConfiguration>
"""


class TestBulkImports(unittest.TestCase):

    @classmethod
    def setUpClass(cls):

        cls._valid_cacti = io.StringIO(_VALID_CACTI_)
        cls._invalid_same_value = io.StringIO(INVALID_SAME_VALUE)
        cls._valid_ia = io.StringIO(VALID_IA)

    def setUp(self):
        init_database()

    def tearDown(self):
        close_database()

    @classmethod
    def tearDownClass(cls):
        cls._valid_cacti.close()
        cls._invalid_same_value.close()
        cls._valid_ia.close()

    def test_import_cacti_cs(self):

        upload_coding_system(CodingSystemType.CACTI, file_obj=self._valid_cacti, file_path="Memory")
        result_set = CodingSystem.select()

        # Should be a single coding system uploaded to the db
        self.assertEqual(len(result_set), 1)
        cs = result_set[0]

        # Coding system should have 2 properties - COmponents and MISC
        self.assertEqual(len(cs.coding_properties), 2)
        misc = list(filter(lambda x: x.cp_name == 'MISC2.5', cs.coding_properties))[0]

        self.assertEqual(len(misc.property_values), 2)

    def test_invalid_cacti_imports(self):

        # Test that the database is clean and empty
        cs = CodingSystem.select()
        self.assertEqual(len(cs), 0)

        # Attempt to load a coding system in which 2 codes have the same coding property and value
        with self.assertRaises(peewee.IntegrityError):
            cs = upload_coding_system(CodingSystemType.CACTI, file_obj=self._invalid_same_value)

        # Entire insertion process should have failed
        self.assertEqual(len(CodingSystem.select()), 0)
        self.assertEqual(len(CodingProperty.select()), 0)
        self.assertEqual(len(PropertyValue.select()), 0)

        self.assertEqual(len(GlobalProperty.select()), 0)
        self.assertEqual(len(GlobalValue.select()), 0)

    def test_import_ia_cs(self):
        cs = upload_coding_system(CodingSystemType.IA, file_obj=self._valid_ia, file_path=":memory:")

        # should be a single CodingSystem in the DB
        result_set = CodingSystem.select().execute()
        self.assertEqual(len(result_set), 1)

        # CS should have source_id of 153
        self.assertEqual(result_set[0].source_id, 153)

        # CS should have 2 associated CodingProperty instances
        self.assertEqual(len(result_set[0].coding_properties), 2)

        # should be 1 CodingProperty with source_id 425
        cp = CodingProperty.get(source_id=425)
        self.assertIsNotNone(cp)

        # cp should have 2 associated PropertyValue instances
        pvs = cp.property_values
        self.assertEqual(len(pvs), 2)

    def test_import_cacti_interview(self):

        # Before an interview is uploaded, need to upload its coding system
        script_dir = os.path.dirname(__file__)
        test_folder = os.path.join(script_dir, 'test_data', 'cacti')
        ptcs = os.path.join(test_folder, 'userConfiguration.xml')
        true_globals = {'Spirit': '3', 'Collaboration':	'4', 'Autonomy': '4', 'Evocation': '5', 'Acceptance': '5',
                        'Empathy': '5', 'Direction': '5', 'ClientSelfExplore': '3', 'LeeCognitiveExplore': '3',
                        'LeeEmoExplore': '2', 'LeeNLExplore': '4', 'LeePRM_VM': '0'}

        cs = upload_coding_system(CodingSystemType.CACTI, file_path=ptcs)
        misc_id = CodingProperty.select(CodingProperty.coding_property_id)\
            .where((CodingProperty.coding_system == cs) & (CodingProperty.cp_name == 'MISC'))\
            .get().coding_property_id
        component_id = CodingProperty.select(CodingProperty.coding_property_id)\
            .where((CodingProperty.coding_system == cs) & (CodingProperty.cp_name == 'Components'))\
            .get().coding_property_id

        # now try to upload the interview from the CACTI files
        interview = upload_cacti_interview('R31531', 27, 5, 'HAEL002', 1, 9, 0, r'./test_data/cacti/R31531.casaa',
                                           path_to_globals=r'./test_data/cacti/R31531.globals',
                                           path_to_components=r'./test_data/cacti/R31531.parse',
                                           path_to_self_explore=r'./test_data/cacti/R31531.globals',
                                           coding_system=cs, code_id=misc_id,
                                           comp_id=component_id)

        # should have been 11 UtteranceCode entities uploaded
        codes = UtteranceCode.select(Utterance, PropertyValue)\
                             .join(Utterance)\
                             .switch(UtteranceCode)\
                             .join(PropertyValue)\
                             .where(Utterance.interview == interview).execute()
        self.assertEqual(len(codes), 22)

        global_ratings = GlobalRating.select(GlobalProperty.gp_name, GlobalValue.gv_value)\
                                     .join(GlobalValue)\
                                     .join(GlobalProperty)\
                                     .where(GlobalRating.interview == interview).tuples().execute()

        quo_n = list(filter(lambda x: x.property_value.pv_value == 'QUO-N', codes))
        quc_n = list(filter(lambda x: x.property_value.pv_value == 'QUC-N', codes))
        fn = list(filter(lambda x: x.property_value.pv_value == 'FN', codes))
        su = list(filter(lambda x: x.property_value.pv_value == 'SU', codes))
        af = list(filter(lambda x: x.property_value.pv_value == 'AF', codes))

        # should be 1 QUO-N
        self.assertEqual(len(quo_n), 1)

        # should be 3 QUC-N
        self.assertEqual(len(quc_n), 3)

        self.assertEqual(len(fn), 5)

        # should be 1 SU
        self.assertEqual(len(su), 1)

        # should be 1 AF
        self.assertEqual(len(af), 1)

        # Global ratings should all match:
        for name, value in global_ratings:
            self.assertEqual(value, true_globals[name])

    def test_import_cacti_interview_parsing_only(self):

        # Before an interview is uploaded, need to upload its coding system
        script_dir = os.path.dirname(__file__)
        test_folder = os.path.join(script_dir, 'test_data', 'cacti')
        ptcs = os.path.join(test_folder, 'userConfiguration.xml')

        # now try to upload the interview from the CACTI files
        interview = upload_cacti_interview('R31531', 27, 5, 'HAEL002', 1, 9, 0, r'./test_data/cacti/R31531.casaa',
                                           path_to_globals=r'./test_data/cacti/R31531.globals',
                                           path_to_components=r'./test_data/cacti/R31531.parse',
                                           path_to_self_explore=r'./test_data/cacti/R31531.globals',
                                           coding_system=None, code_id=None,
                                           comp_id=None)

        # should have been 11 UtteranceCode entities uploaded
        utts = Utterance.select().where(Utterance.interview == interview).execute()
        self.assertEqual(len(utts), 11)

    def test_import_ia_interview(self):

        # First step is to upload the coding system by which an interview was scored, so testing can be done
        script_dir = os.path.dirname(__file__)
        test_folder = os.path.join(script_dir, 'test_data', 'ia')
        ptcs = os.path.join(test_folder, 'UCHAT3.4_CodingSystem.xml')
        iv_files = ('UC379 (1 of 2).xml', 'UC379 (2 of 2).xml')

        upload_coding_system(CodingSystemType.IA, file_path=ptcs)

        interview = upload_ia_interview('UC379', 27, 5, 'HAEL002', 1, 9, 1,
                                        *[os.path.join(test_folder, itm) for itm in iv_files])

        # Interview should have a total of 4 utterances
        self.assertEqual(len(interview.utterances), 4)

        # Interview should have a total of 8 codes assigned
        utt_codes = UtteranceCode.select().execute()
        self.assertEqual(len(utt_codes), 8)

        # interview should have a total of 2 globals
        global_ratings = GlobalRating.select().execute()
        self.assertEqual(len(global_ratings), 2)

    def test_duplicate_bulk_insert(self):

        script_dir = os.path.dirname(__file__)
        test_folder = os.path.join(script_dir, 'test_data', 'cacti')
        invalid_folder = os.path.join(test_folder, 'invalid')
        pt_invalid = os.path.join(invalid_folder, 'userConfiguration.xml')
        ptcs = os.path.join(test_folder, 'userConfiguration.xml')

        cs = upload_coding_system(CodingSystemType.CACTI, file_path=ptcs)
        iv = Interview.create(interview_name="R31531", coding_system=cs, study_id=1,
                              client_id="C255", rater_id=1, therapist_id=1, language_id=1,
                              treatment_condition_id=0, session_number=1)

        # Inserting 2 utterances for the same interview with the same enumeration should fail integrity checks
        utterance_data = {'utt_enum': 1, 'interview': iv}
        with self.assertRaises(peewee.PeeweeException):
            Utterance.bulk_insert((utterance_data for i in range(0, 2)))

        # Inserting a CACTI coding system with 2 identical codes should fail integrity checks
        iv.delete_instance()
        cs.delete_instance()
        with self.assertRaises(peewee.IntegrityError):
            upload_coding_system(CodingSystemType.CACTI, file_path=pt_invalid)

        # failure to upload the CS should have caused a failure to upload anything
        systems = list(CodingSystem.select().execute())
        properties = list(CodingProperty.select().execute())
        values = list(PropertyValue.select().execute())
        self.assertEqual(len(systems), 0)
        self.assertEqual(len(properties), 0)
        self.assertEqual(len(values), 0)


suite = unittest.TestLoader().loadTestsFromTestCase(TestBulkImports)
unittest.TextTestRunner(verbosity=2).run(suite)
