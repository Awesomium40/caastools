from caastools.database.models import *
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


suite = unittest.TestLoader().loadTestsFromTestCase(TestBulkImports)
unittest.TextTestRunner(verbosity=2).run(suite)
