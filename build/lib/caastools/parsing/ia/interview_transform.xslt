<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:fn="http://www.w3.org/2005/xpath-functions"
xmlns:func="http://exslt.org/functions"
extension-element-prefixes="func"
xmlns:jww="http://notARealPlace.com">

<!--
Transforms an IA XML file into something a little easier to digest via SPSS and python
-->
    <xsl:template match="UtteranceProperties[PropertyName = 'Globals']">
        <Globals>
            <xsl:element name="PropertyID">
                <xsl:value-of select="./PropertyID"/>
            </xsl:element>
            <xsl:element name="PropertyValueID">
                <xsl:value-of select="./PropertyValueID"/>
            </xsl:element>
            <xsl:element name="PropertyName">
                <xsl:value-of select="substring-before(./PropertyValueDescription, ' ')"/>
            </xsl:element>
            <xsl:element name="PropertyValue">
                <xsl:value-of select="substring-after(./PropertyValue, '.')"/>
            </xsl:element>
            <xsl:element name="OriginalValue">
                <xsl:value-of select="./PropertyValue"/>
            </xsl:element>
        </Globals>
    </xsl:template>

    <xsl:template match="Utterances">
        <!--
        Declare some variables to make constructing the transform easier
        -->

        <xsl:variable name="id" select="./UtteranceID"/>
        <xsl:variable name="uttSeg" select="/NewDataSet/UtteranceSegments[UtteranceID=$id]"/>
        <xsl:variable name="start" select="$uttSeg/StartIndex"/>
        <xsl:variable name="end" select="$uttSeg/EndIndex"/>
        <xsl:variable name="length" select="$end - $start + 1"/>
        <xsl:variable name="startTime" select="substring-after($uttSeg/StartTime, 'PT')"/>
        <xsl:variable name="speakerSegID" select="$uttSeg/SpeakerSegmentID"/>
        <xsl:variable name="spkrSeg" select="/NewDataSet/SpeakerSegments[SpeakerSegmentID=$speakerSegID]"/>
        <xsl:variable name="spkrTxt" select="$spkrSeg/SpeakerText"/>
        <xsl:variable name="codes" select="/NewDataSet/UtteranceProperties[UtteranceID=$id]"/>
        <!--Some utterances have multiple comprised of multiple segments
        and this rather complicated variable construct should knit them back together-->
        <xsl:variable name="txt">
            <xsl:for-each select="$uttSeg">
                <xsl:sort select="StartIndex" data-type="number"/>
                <xsl:variable name="speakerSegmentID" select="./SpeakerSegmentID"/>
                <xsl:variable name="speakerSegment" select="/NewDataSet/SpeakerSegments[SpeakerSegmentID=$speakerSegmentID]"/>
                <xsl:variable name="segmentText" select="$speakerSegment/SpeakerText"/>
                <xsl:variable name="startIndex" select="./StartIndex"/>
                <xsl:variable name="endIndex" select="./EndIndex"/>
                <xsl:variable name="uttLength" select="$endIndex - $startIndex + 1"/>
                <xsl:choose>
                    <xsl:when test="position() = last()">
                        <xsl:value-of select="substring($segmentText, $startIndex + 1, $uttLength)"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="concat(substring($segmentText, $startIndex + 1, $uttLength), ' ')"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:for-each>
        </xsl:variable>

        <Utterances>
            <xsl:copy-of select="./UtteranceID"/>
            <xsl:copy-of select="./DemarcationSetID"/>
            <xsl:element name="LineNumber">
                <xsl:value-of select="$spkrSeg/LineNumber"/>
            </xsl:element>
            <xsl:copy-of select="./UtteranceNumber"/>
            <xsl:element name="SpeakerRole">
                <xsl:value-of select="$spkrSeg/SpeakerRole"/>
            </xsl:element>
            <xsl:element name="Text">
                <xsl:value-of select="$txt"/>
            </xsl:element>
            <xsl:copy-of select="./WordCount"/>
            <xsl:element name="StartTime">
                <xsl:value-of select="jww:get-time($startTime)"/>
            </xsl:element>
        </Utterances>
    </xsl:template>

    <xsl:template match="/">
        <NewDataSet>
            <xsl:copy-of select="./NewDataSet/Interviews"/>
            <xsl:copy-of select="./NewDataSet/DemarcationSets"/>
            <xsl:copy-of select="./NewDataSet/CodingSets"/>
            <xsl:apply-templates select="./NewDataSet/UtteranceProperties[PropertyName = 'Globals']"/>
            <xsl:apply-templates select="./NewDataSet/Utterances"/>
            <xsl:copy-of select="./NewDataSet/UtteranceProperties[not(PropertyName = 'Globals')]"/>
        </NewDataSet>
    </xsl:template>

    <!--Function to compute time in seconds from the string timestamp supplied by IA XML files-->
    <func:function name="jww:get-time">
        <xsl:param name="timeStr" select="''"/>

        <!--Start by retrieving the hours-->
        <xsl:variable name="hours">
            <xsl:choose>
                <xsl:when test="contains($timeStr, 'H')">
                    <xsl:value-of select="number(substring-before($timeStr, 'H'))"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="number(0)"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <!--Minutes-->
        <xsl:variable name="minutes">
            <xsl:choose>
                <xsl:when test="contains($timeStr, 'M')">
                    <xsl:variable name="tmp" select="substring-before($timeStr, 'M')"/>
                    <xsl:choose>
                        <xsl:when test="contains($tmp, 'H')">
                            <xsl:value-of select="number(substring-after($tmp, 'H'))"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="number($tmp)"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="number(0)"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <!--Seconds-->
        <xsl:variable name="seconds">
            <xsl:choose>
                <xsl:when test="contains($timeStr, 'S')">
                    <xsl:variable name="tmpSecs" select="substring-before($timeStr, 'S')"/>
                    <xsl:choose>
                        <xsl:when test="contains($tmpSecs, 'M')">
                            <xsl:value-of select="number(substring-after($tmpSecs, 'M'))"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="number($tmpSecs)"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="number(0)"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <!--add the results together-->
        <func:result>
            <xsl:value-of select="$hours * 3600 + $minutes * 60 + $seconds"/>
        </func:result>
    </func:function>

</xsl:stylesheet>