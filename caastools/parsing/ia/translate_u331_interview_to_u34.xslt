<xsl:stylesheet xmlns:fn="http://www.w3.org/2005/xpath-functions"
                xmlns:func="http://exslt.org/functions" xmlns:jww="http://notARealPlace.com"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                extension-element-prefixes="func" version="1.0">
  <xsl:template match="/">
    <NewDataSet>
      <xsl:copy-of select="./NewDataSet/xs:schema"/>
      <xsl:copy-of select="./NewDataSet/Interviews"/>
      <xsl:copy-of select="./NewDataSet/SpeakerSegments"/>
      <xsl:copy-of select="./NewDataSet/DemarcationSets"/>
      <xsl:apply-templates select="./NewDataSet/CodingSets"/>
      <xsl:copy-of select="./NewDataSet/Utterances"/>
      <xsl:copy-of select="./NewDataSet/UtteranceSegments"/>
      <xsl:apply-templates select="./NewDataSet/UtteranceProperties"/>
      <xsl:apply-templates select="./NewDataSet/PropertyNames"/>
    </NewDataSet>
  </xsl:template>
  <xsl:template match="CodingSets">
    <CodingSets>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./DemarcationSetID"/>
      <xsl:copy-of select="./CoderID"/>
      <xsl:element name="CodingSystemID">
        <xsl:text>153</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./SetName"/>
      <xsl:copy-of select="./Description"/>
      <xsl:copy-of select="./DateCreated"/>
      <xsl:copy-of select="./CreatedBy"/>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:copy-of select="./CoderDisplayName"/>
      <xsl:copy-of select="./CoderLoginName"/>
      <xsl:copy-of select="./CoderIsActive"/>
      <xsl:element name="CodingSystemName">
        <xsl:text>UCHAT 3.4</xsl:text>
      </xsl:element>
      <xsl:element name="CodingSystemShortName">
        <xsl:text>U3.4</xsl:text>
      </xsl:element>
      <xsl:element name="CodingSystemDescription">
        <xsl:text>UCHATCoding System 3.4</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./CodingSystemIsActive"/>
      <xsl:copy-of select="./CodingSystemIsDefault"/>
      <xsl:copy-of select="./DisplayName"/>
      <xsl:copy-of select="./IsDefault"/>
    </CodingSets>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11143']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>426</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15334</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>MISC</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>c-</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueDescription">
        <xsl:text>commitment negative</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11143']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>426</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15334</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>MISC</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>c-</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueDescription">
        <xsl:text>commitment negative</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11143']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>426</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15334</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>MISC</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>c-</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueDescription">
        <xsl:text>commitment negative</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11143']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>426</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15084</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>MISC</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>c+</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueDescription">
        <xsl:text>commitment positive</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11143']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>426</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15084</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>MISC</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>c+</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueDescription">
        <xsl:text>commitment positive</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11143']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>426</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15084</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>MISC</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>c+</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueDescription">
        <xsl:text>commitment positive</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11150']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>426</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15340</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>MISC</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>o-</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueDescription">
        <xsl:text>other negative</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11150']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>426</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15340</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>MISC</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>o-</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueDescription">
        <xsl:text>other negative</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11150']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>426</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15340</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>MISC</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>o-</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueDescription">
        <xsl:text>other negative</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11150']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>426</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15091</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>MISC</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>o+</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueDescription">
        <xsl:text>other Positive</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11150']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>426</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15091</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>MISC</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>o+</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueDescription">
        <xsl:text>other Positive</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11150']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>426</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15091</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>MISC</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>o+</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueDescription">
        <xsl:text>other Positive</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11145']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>426</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15335</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>MISC</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>r-</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueDescription">
        <xsl:text>reason negative</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11145']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>426</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15335</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>MISC</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>r-</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueDescription">
        <xsl:text>reason negative</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11145']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>426</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15335</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>MISC</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>r-</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueDescription">
        <xsl:text>reason negative</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11145']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>426</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15086</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>MISC</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>r+</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueDescription">
        <xsl:text>reason positive</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11145']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>426</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15086</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>MISC</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>r+</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueDescription">
        <xsl:text>reason positive</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11145']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>426</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15086</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>MISC</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>r+</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueDescription">
        <xsl:text>reason positive</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11147']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>426</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15336</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>MISC</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>ra-</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueDescription">
        <xsl:text>reason - ability negative</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11147']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>426</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15336</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>MISC</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>ra-</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueDescription">
        <xsl:text>reason - ability negative</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11147']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>426</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15336</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>MISC</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>ra-</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueDescription">
        <xsl:text>reason - ability negative</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11147']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>426</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15088</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>MISC</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>ra+</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueDescription">
        <xsl:text>reason - ability positive</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11147']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>426</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15088</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>MISC</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>ra+</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueDescription">
        <xsl:text>reason - ability positive</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11147']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>426</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15088</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>MISC</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>ra+</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueDescription">
        <xsl:text>reason - ability positive</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11146']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>426</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15337</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>MISC</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>rd-</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueDescription">
        <xsl:text>reason - desire negative</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11146']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>426</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15337</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>MISC</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>rd-</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueDescription">
        <xsl:text>reason - desire negative</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11146']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>426</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15337</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>MISC</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>rd-</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueDescription">
        <xsl:text>reason - desire negative</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11146']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>426</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15087</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>MISC</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>rd+</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueDescription">
        <xsl:text>reason - desire positive</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11146']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>426</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15087</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>MISC</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>rd+</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueDescription">
        <xsl:text>reason - desire positive</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11146']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>426</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15087</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>MISC</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>rd+</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueDescription">
        <xsl:text>reason - desire positive</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11148']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>426</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15338</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>MISC</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>rn-</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueDescription">
        <xsl:text>reason - need negative</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11148']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>426</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15338</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>MISC</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>rn-</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueDescription">
        <xsl:text>reason - need negative</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11148']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>426</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15338</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>MISC</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>rn-</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueDescription">
        <xsl:text>reason - need negative</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11148']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>426</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15089</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>MISC</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>rn+</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueDescription">
        <xsl:text>reason - need positive</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11148']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>426</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15089</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>MISC</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>rn+</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueDescription">
        <xsl:text>reason - need positive</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11148']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>426</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15089</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>MISC</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>rn+</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueDescription">
        <xsl:text>reason - need positive</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11149']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>426</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15339</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>MISC</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>ts-</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueDescription">
        <xsl:text>taking steps negative</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11149']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>426</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15339</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>MISC</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>ts-</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueDescription">
        <xsl:text>taking steps negative</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11149']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>426</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15339</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>MISC</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>ts-</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueDescription">
        <xsl:text>taking steps negative</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11149']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>426</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15090</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>MISC</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>ts+</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueDescription">
        <xsl:text>taking steps positive</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11149']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>426</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15090</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>MISC</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>ts+</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueDescription">
        <xsl:text>taking steps positive</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11149']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>426</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15090</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>MISC</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>ts+</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueDescription">
        <xsl:text>taking steps positive</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11099']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>425</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15038</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>TBO</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>1</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11100']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>425</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15039</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>TBO</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11101']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>425</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15040</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>TBO</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>3</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11102']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>425</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15041</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>TBO</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>4</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11103']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>425</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15042</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>TBO</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>5</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11104']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>425</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15043</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>TBO</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>6</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11105']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>425</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15044</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>TBO</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.1</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11106']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>425</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15045</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>TBO</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.2</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11107']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>425</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15046</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>TBO</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.3</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11108']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>425</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15047</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>TBO</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.4</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11109']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>425</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15048</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>TBO</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>1.1</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11110']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>425</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15049</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>TBO</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>1.2</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11111']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>425</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15050</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>TBO</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>1.3</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11112']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>425</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15051</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>TBO</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.5</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11113']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>425</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15052</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>TBO</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>5.1</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11114']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>425</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15053</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>TBO</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>5.2</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11115']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>425</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15054</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>TBO</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>5.3</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11116']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>425</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15055</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>TBO</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>6.1</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11117']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>425</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15056</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>TBO</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>6.2</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '12886']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>425</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15057</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>TBO</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.6</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '13144']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>425</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15058</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>TBO</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>7</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11198']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15214</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>1</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '13150']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15214</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>1</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11199']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15215</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>1.1</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11206']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15216</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>1.2</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11211']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15217</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>1.3</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '13181']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15210</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>1.31</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11249']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15218</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '13151']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15218</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11250']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15219</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.1</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11251']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15220</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.11</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11363']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15209</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.12</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '13069']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15200</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.13</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '13071']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15201</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.131</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '13076']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15206</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.132</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '13077']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15207</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.133</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '13072']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15202</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.14</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '13073']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15203</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.141</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '13171']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15197</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.1411</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '13074']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15204</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.142</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '13075']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15205</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.143</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '13078']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15208</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.144</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '13172']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15198</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.145</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11253']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15221</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.2</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11254']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15222</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.21</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11255']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15223</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.211</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11256']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15224</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.212</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11258']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15225</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.22</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11259']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15226</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.221</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11260']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15227</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.222</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11261']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15228</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.3</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11262']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15229</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.31</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11263']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15230</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.311</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '13138']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15186</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.3112</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '13139']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15187</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.3113</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '13140']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15188</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.3114</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11264']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15231</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.312</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11265']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15232</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.313</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11322']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15289</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.314</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '13134']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15182</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.315</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11266']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15233</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.32</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11267']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15234</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.321</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11318']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15285</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.3211</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '13145']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15211</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.3212</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '13146']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15212</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.3213</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '13147']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15213</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.3214</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11268']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15235</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.322</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11269']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15236</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.323</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11319']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15286</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.324</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '13135']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15183</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.325</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11270']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15237</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.33</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11271']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15238</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.331</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11320']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15287</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.3311</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '13141']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15189</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.3312</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '13142']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15190</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.3313</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '13143']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15191</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.3314</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11272']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15239</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.332</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11273']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15240</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.333</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11321']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15288</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.334</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '13136']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15184</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.335</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11274']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15241</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.34</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11275']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15242</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.341</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11276']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15243</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.342</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11277']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15244</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.343</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11323']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15290</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.344</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '13137']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15185</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.345</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11278']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15245</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.4</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11279']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15246</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.41</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11280']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15247</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.411</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11281']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15248</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.412</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11282']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15249</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.42</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11283']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15250</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.421</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11284']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15251</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.422</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11285']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15252</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.43</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11286']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15253</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.431</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11287']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15254</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.432</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11288']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15255</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.433</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11289']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15256</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.434</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11290']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15257</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.5</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11291']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15258</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>3</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '13176']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15258</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>3</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11292']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15259</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>3.1</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11293']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15260</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>3.2</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11294']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15261</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>3.3</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11295']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15262</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>3.4</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11296']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15263</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>4</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '13152']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15263</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>4</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11297']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15264</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>4.1</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11298']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15265</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>4.2</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '13080']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15145</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>5</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '13153']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15145</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>5</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '13082']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15146</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>5.1</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '13083']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15147</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>5.2</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '13096']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15148</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>5.21</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '13097']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15149</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>5.211</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '13098']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15150</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>5.212</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '13099']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15151</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>5.213</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '13100']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15152</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>5.214</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '13101']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15153</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>5.215</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '13103']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15154</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>5.216</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '13104']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15155</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>5.217</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '13105']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15156</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>5.218</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '13106']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15157</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>5.219</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '13107']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15158</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>5.22</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '13108']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15159</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>5.221</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '13109']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15160</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>5.222</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '13110']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15161</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>5.223</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '13111']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15162</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>5.224</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '13121']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15170</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>5.225</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '13112']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15163</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>5.226</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '13114']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15164</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>5.23</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '13125']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15173</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>5.231</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '13115']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15165</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>5.24</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '13122']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15171</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>5.25</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '13124']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15172</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>5.251</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '13126']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15174</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>5.252</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '13127']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15175</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>5.253</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '13128']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15176</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>5.254</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '13129']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15177</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>5.255</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '13130']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15178</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>5.256</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '13131']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15179</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>5.257</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '13132']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15180</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>5.258</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '13133']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15181</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>5.259</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '13119']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15169</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>5.3</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11299']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15266</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>6</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11300']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15267</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>6.1</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11301']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15268</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>7</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11302']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15269</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>8</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11308']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15275</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>9</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '13154']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15275</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>9</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11309']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15276</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>9.1</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11310']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15277</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>9.2</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11311']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15278</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>9.3</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11312']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15279</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>9.4</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11313']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15280</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>9.5</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11314']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15281</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>9.6</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11315']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15282</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>9.7</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11316']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15283</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>9.8</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11317']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15284</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>9.9</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '13116']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15328</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>10</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '13117']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15167</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>10.1</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '13118']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15168</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>10.2</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11303']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15270</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>80</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11304']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15271</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>81</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11305']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15272</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>82</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11306']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15273</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>83</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11307']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>428</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15274</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>99</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11005']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>423</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>14945</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Speech Act</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>1.1</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11008']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>423</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>14948</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Speech Act</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>1.11</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11010']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>423</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>14950</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Speech Act</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>1.12</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11011']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>423</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>14951</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Speech Act</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>1.121</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11012']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>423</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>14952</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Speech Act</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>1.122</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '10990']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>423</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>14930</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Speech Act</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>1.2</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11013']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>423</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>14953</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Speech Act</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>1.21</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11014']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>423</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>14954</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Speech Act</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>1.22</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11015']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>423</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>14955</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Speech Act</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>1.221</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11016']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>423</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>14956</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Speech Act</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>1.222</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11080']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>423</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15020</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Speech Act</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>1.23</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '10991']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>423</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>14931</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Speech Act</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>1.3</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11017']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>423</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>14957</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Speech Act</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>1.31</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11018']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>423</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>14958</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Speech Act</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>1.32</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '10985']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>423</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>14925</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Speech Act</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11019']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>423</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>14959</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Speech Act</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.1</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11020']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>423</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>14960</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Speech Act</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.11</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11009']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>423</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>14949</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Speech Act</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.111</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11021']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>423</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>14961</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Speech Act</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.12</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11022']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>423</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>14962</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Speech Act</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.121</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11023']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>423</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>14963</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Speech Act</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.13</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11024']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>423</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>14964</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Speech Act</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.131</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11026']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>423</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>14966</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Speech Act</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.14</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11025']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>423</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>14965</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Speech Act</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.141</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '10992']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>423</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>14932</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Speech Act</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.142</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11027']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>423</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>14967</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Speech Act</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.2</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11028']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>423</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>14968</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Speech Act</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.21</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11029']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>423</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>14969</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Speech Act</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.3</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11073']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>423</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15013</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Speech Act</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.31</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11030']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>423</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>14970</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Speech Act</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.4</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11074']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>423</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15014</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Speech Act</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.401</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11031']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>423</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>14971</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Speech Act</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.41</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11032']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>423</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>14972</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Speech Act</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.42</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11033']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>423</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>14973</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Speech Act</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.43</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11075']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>423</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15015</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Speech Act</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.431</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11034']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>423</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>14974</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Speech Act</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.44</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11076']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>423</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15016</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Speech Act</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.441</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11037']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>423</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>14977</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Speech Act</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.5</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11077']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>423</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15017</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Speech Act</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.51</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '10993']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>423</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>14933</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Speech Act</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.6</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11038']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>423</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>14978</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Speech Act</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.61</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11039']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>423</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>14979</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Speech Act</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.7</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11040']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>423</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>14980</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Speech Act</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.71</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '10994']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>423</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>14934</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Speech Act</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.8</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11078']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>423</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15018</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Speech Act</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.801</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '10995']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>423</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>14935</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Speech Act</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.81</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11079']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>423</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15019</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Speech Act</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.811</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '10996']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>423</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>14936</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Speech Act</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.9</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11083']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>423</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15023</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Speech Act</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.91</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11084']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>423</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15024</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Speech Act</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.92</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11087']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>423</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15027</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Speech Act</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.921</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11081']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>423</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15021</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Speech Act</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.93</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11088']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>423</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15028</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Speech Act</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.931</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11085']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>423</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15025</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Speech Act</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.94</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11089']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>423</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15029</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Speech Act</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.941</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11082']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>423</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15022</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Speech Act</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.95</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11090']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>423</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15030</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Speech Act</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.951</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11086']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>423</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15026</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Speech Act</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.96</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11091']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>423</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15031</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Speech Act</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.961</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '10986']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>423</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>14926</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Speech Act</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>3</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11041']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>423</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>14981</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Speech Act</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>3.1</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11042']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>423</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>14982</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Speech Act</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>3.2</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11043']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>423</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>14983</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Speech Act</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>3.3</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11044']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>423</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>14984</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Speech Act</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>3.4</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11045']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>423</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>14985</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Speech Act</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>3.5</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11046']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>423</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>14986</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Speech Act</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>3.6</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11047']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>423</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>14987</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Speech Act</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>3.7</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11006']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>423</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>14946</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Speech Act</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>4</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11048']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>423</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>14988</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Speech Act</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>4.1</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11035']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>423</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>14975</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Speech Act</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>4.11</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11036']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>423</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>14976</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Speech Act</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>4.12</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '10997']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>423</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>14937</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Speech Act</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>4.13</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '10998']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>423</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>14938</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Speech Act</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>4.14</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '10999']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>423</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>14939</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Speech Act</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>4.15</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11000']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>423</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>14940</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Speech Act</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>4.16</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11001']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>423</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>14941</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Speech Act</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>4.17</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11049']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>423</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>14989</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Speech Act</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>4.2</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11002']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>423</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>14942</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Speech Act</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>4.21</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11003']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>423</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>14943</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Speech Act</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>4.22</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11004']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>423</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>14944</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Speech Act</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>4.23</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '10987']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>423</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>14927</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Speech Act</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>5</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11050']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>423</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>14990</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Speech Act</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>5.1</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11051']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>423</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>14991</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Speech Act</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>5.2</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11052']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>423</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>14992</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Speech Act</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>5.3</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11053']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>423</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>14993</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Speech Act</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>5.4</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11054']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>423</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>14994</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Speech Act</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>5.5</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11055']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>423</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>14995</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Speech Act</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>5.6</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11007']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>423</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>14947</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Speech Act</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>5.61</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11056']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>423</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>14996</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Speech Act</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>5.7</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11057']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>423</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>14997</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Speech Act</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>5.71</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '10988']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>423</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>14928</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Speech Act</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>6</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11058']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>423</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>14998</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Speech Act</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>6.1</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11059']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>423</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>14999</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Speech Act</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>6.11</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11060']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>423</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15000</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Speech Act</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>6.2</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11061']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>423</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15001</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Speech Act</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>6.21</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11062']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>423</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15002</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Speech Act</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>6.22</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11063']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>423</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15003</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Speech Act</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>6.3</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11064']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>423</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15004</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Speech Act</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>7</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11065']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>423</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15005</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Speech Act</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>8</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11071']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>423</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15011</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Speech Act</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>11</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '10989']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>423</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>14929</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Speech Act</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>80</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11066']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>423</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15006</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Speech Act</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>81</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11067']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>423</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15007</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Speech Act</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>82</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11068']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>423</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15008</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Speech Act</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>82.1</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11069']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>423</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15009</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Speech Act</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>83</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11070']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>423</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15010</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Speech Act</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>84</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11072']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>423</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15012</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Speech Act</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>99</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11151']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>427</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15092</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Treatment Components</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>1</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11152']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>427</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15093</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Treatment Components</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11166']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>427</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15107</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Treatment Components</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.1</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11167']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>427</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15108</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Treatment Components</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.2</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11168']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>427</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15109</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Treatment Components</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.3</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11153']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>427</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15094</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Treatment Components</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>3</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11169']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>427</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15110</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Treatment Components</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>3.1</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11170']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>427</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15111</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Treatment Components</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>3.2</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11171']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>427</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15112</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Treatment Components</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>3.3</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11172']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>427</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15113</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Treatment Components</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>3.4</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11173']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>427</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15114</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Treatment Components</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>3.5</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11184']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>427</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15125</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Treatment Components</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>3.51</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11185']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>427</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15126</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Treatment Components</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>3.52</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11186']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>427</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15127</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Treatment Components</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>3.53</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11187']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>427</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15128</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Treatment Components</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>3.54</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11188']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>427</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15129</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Treatment Components</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>3.55</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11189']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>427</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15130</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Treatment Components</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>3.56</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '13079']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>427</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15144</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Treatment Components</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>3.561</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11190']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>427</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15131</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Treatment Components</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>3.57</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11191']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>427</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15132</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Treatment Components</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>3.58</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11192']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>427</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15133</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Treatment Components</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>3.59</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11193']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>427</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15134</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Treatment Components</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>3.6</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11194']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>427</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15135</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Treatment Components</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>3.61</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11195']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>427</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15136</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Treatment Components</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>3.62</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11196']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>427</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15137</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Treatment Components</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>3.63</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '13148']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>427</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15143</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Treatment Components</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>3.64</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '13182']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>427</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15142</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Treatment Components</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>3.65</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11154']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>427</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15095</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Treatment Components</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>4</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11174']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>427</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15115</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Treatment Components</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>4.1</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11175']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>427</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15116</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Treatment Components</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>4.2</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11155']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>427</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15096</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Treatment Components</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>5</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11176']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>427</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15117</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Treatment Components</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>5.1</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11177']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>427</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15118</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Treatment Components</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>5.2</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11178']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>427</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15119</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Treatment Components</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>5.3</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11156']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>427</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15097</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Treatment Components</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>6</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11157']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>427</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15098</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Treatment Components</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>7</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11158']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>427</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15099</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Treatment Components</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>8</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11159']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>427</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15100</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Treatment Components</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>9</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11160']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>427</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15101</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Treatment Components</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>10</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11161']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>427</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15102</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Treatment Components</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>11</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11179']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>427</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15120</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Treatment Components</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>11.1</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11180']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>427</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15121</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Treatment Components</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>11.2</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11181']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>427</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15122</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Treatment Components</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>11.3</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11182']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>427</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15123</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Treatment Components</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>11.4</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11162']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>427</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15103</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Treatment Components</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>12</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11163']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>427</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15104</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Treatment Components</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>13</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11164']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>427</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15105</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Treatment Components</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>14</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11183']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>427</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15124</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Treatment Components</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>14.1</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11165']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>427</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15106</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Treatment Components</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>15</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '13177']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>427</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15138</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Treatment Components</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>16</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '13178']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>427</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15139</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Treatment Components</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>16.1</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '13179']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>427</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15140</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Treatment Components</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>17</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '13180']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>427</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15141</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Treatment Components</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>99</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11118']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>426</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15059</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>MISC</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>ack</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11122']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>426</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15063</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>MISC</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>adp</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11123']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>426</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15064</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>MISC</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>adw</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11124']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>426</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15065</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>MISC</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>af</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11125']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>426</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15066</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>MISC</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>co</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11120']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>426</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15061</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>MISC</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>cont</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '15341']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>426</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15332</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>MISC</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>CT_NOS</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11126']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>426</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15067</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>MISC</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>di</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11127']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>426</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15068</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>MISC</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>ec</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11128']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>426</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15069</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>MISC</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>fa</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11129']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>426</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15070</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>MISC</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>fi</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11144']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>426</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15085</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>MISC</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>fn</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11130']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>426</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15071</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>MISC</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>gi</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11119']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>426</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15060</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>MISC</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>int</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '15343']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>426</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15347</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>MISC</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>MICO</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '15344']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>426</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15348</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>MISC</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>MIIN</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11138']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>426</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15079</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>MISC</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>nrc</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11137']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>426</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15078</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>MISC</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>nrs</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '15345']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>426</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15350</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>MISC</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>NS</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '15346']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>426</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15349</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>MISC</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>OTHER</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11131']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>426</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15072</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>MISC</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>quc</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11132']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>426</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15073</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>MISC</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>quo</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11133']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>426</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15074</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>MISC</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>rcp</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11134']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>426</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15075</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>MISC</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>rcw</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11136']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>426</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15077</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>MISC</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>rec</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11135']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>426</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15076</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>MISC</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>res</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11139']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>426</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15080</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>MISC</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>rf</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11141']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>426</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15082</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>MISC</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>st</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '15342']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>426</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15333</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>MISC</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>ST_NOS</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11140']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>426</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15081</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>MISC</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>su</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11121']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>426</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15062</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>MISC</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>unf</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '15351']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>426</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15085</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>MISC</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>fn</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11142']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>426</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15083</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>MISC</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>wa</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11092']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>424</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15035</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Strength Rating</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>1</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11094']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>424</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15036</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Strength Rating</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11095']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>424</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15037</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Strength Rating</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>3</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11096']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>424</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15035</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Strength Rating</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>1</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11097']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>424</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15036</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Strength Rating</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11098']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>424</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15037</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Strength Rating</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>3</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11324']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>429</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15291</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Globals</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>1.1</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11325']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>429</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15292</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Globals</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>1.2</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11326']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>429</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15293</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Globals</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>1.3</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11327']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>429</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15294</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Globals</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>1.4</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11328']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>429</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15295</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Globals</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>1.5</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11329']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>429</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15296</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Globals</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.1</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11335']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>429</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15302</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Globals</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.2</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11336']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>429</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15303</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Globals</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.3</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11337']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>429</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15304</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Globals</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.4</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11338']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>429</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15305</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Globals</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>2.5</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11330']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>429</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15297</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Globals</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>3.1</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11339']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>429</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15306</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Globals</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>3.2</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11340']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>429</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15307</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Globals</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>3.3</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11341']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>429</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15308</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Globals</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>3.4</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11342']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>429</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15309</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Globals</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>3.5</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11331']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>429</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15298</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Globals</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>4.1</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11343']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>429</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15310</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Globals</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>4.2</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11344']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>429</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15311</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Globals</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>4.3</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11345']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>429</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15312</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Globals</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>4.4</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11346']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>429</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15313</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Globals</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>4.5</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11332']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>429</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15299</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Globals</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>5.1</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11347']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>429</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15314</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Globals</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>5.2</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11348']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>429</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15315</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Globals</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>5.3</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11349']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>429</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15316</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Globals</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>5.4</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11350']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>429</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15317</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Globals</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>5.5</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11333']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>429</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15300</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Globals</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>6.1</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11351']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>429</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15318</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Globals</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>6.2</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11352']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>429</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15319</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Globals</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>6.3</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11353']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>429</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15320</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Globals</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>6.4</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11354']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>429</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15321</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Globals</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>6.5</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11334']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>429</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15301</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Globals</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>7.1</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11355']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>429</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15322</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Globals</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>7.2</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11356']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>429</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15323</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Globals</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>7.3</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11357']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>429</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15324</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Globals</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>7.4</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '11358']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>429</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15325</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Globals</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>7.5</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '14922']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>429</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15326</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Globals</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>8</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="UtteranceProperties[PropertyValueID = '14924']">
    <UtteranceProperties>
      <xsl:copy-of select="./UtterancePropertyID"/>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:copy-of select="./UtteranceID"/>
      <xsl:element name="PropertyID">
        <xsl:text>429</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValueID">
        <xsl:text>15327</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./LastModified"/>
      <xsl:copy-of select="./ModifiedBy"/>
      <xsl:element name="PropertyName">
        <xsl:text>Globals</xsl:text>
      </xsl:element>
      <xsl:element name="PropertyValue">
        <xsl:text>8.1</xsl:text>
      </xsl:element>
      <xsl:copy-of select="./PropertyValueDescription"/>
      <xsl:copy-of select="./AutoFillScope"/>
    </UtteranceProperties>
  </xsl:template>
  <xsl:template match="PropertyNames[PropertyName='TBO']">
    <PropertyNames>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:element name="PropertyName">
        <xsl:text>TBO</xsl:text>
      </xsl:element>
    </PropertyNames>
  </xsl:template>
  <xsl:template match="PropertyNames[PropertyName='Topic Codes']">
    <PropertyNames>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:element name="PropertyName">
        <xsl:text>Topic Codes</xsl:text>
      </xsl:element>
    </PropertyNames>
  </xsl:template>
  <xsl:template match="PropertyNames[PropertyName='Speech Act']">
    <PropertyNames>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:element name="PropertyName">
        <xsl:text>Speech Act</xsl:text>
      </xsl:element>
    </PropertyNames>
  </xsl:template>
  <xsl:template match="PropertyNames[PropertyName='Treatment Components']">
    <PropertyNames>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:element name="PropertyName">
        <xsl:text>Treatment Components</xsl:text>
      </xsl:element>
    </PropertyNames>
  </xsl:template>
  <xsl:template match="PropertyNames[PropertyName='MISC']">
    <PropertyNames>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:element name="PropertyName">
        <xsl:text>MISC</xsl:text>
      </xsl:element>
    </PropertyNames>
  </xsl:template>
  <xsl:template match="PropertyNames[PropertyName='Valence']">
    <PropertyNames>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:element name="PropertyName">
        <xsl:text>Strength Rating</xsl:text>
      </xsl:element>
    </PropertyNames>
  </xsl:template>
  <xsl:template match="PropertyNames[PropertyName='Globals']">
    <PropertyNames>
      <xsl:copy-of select="./CodingSetID"/>
      <xsl:element name="PropertyName">
        <xsl:text>Globals</xsl:text>
      </xsl:element>
    </PropertyNames>
  </xsl:template>
</xsl:stylesheet>
