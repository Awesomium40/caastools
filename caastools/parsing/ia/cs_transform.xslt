<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:ext="http://exslt.org/common">

<!--
Transforms an IA XML file into something a little easier to digest via SPSS and python
-->
    <!--
    Template to fetch the maximum PropertyID value
    Used later in the template for the transformation of globals from 1 Property to many
    Retrieved from https://stackoverflow.com/questions/5379650/using-max-in-a-variable-in-xslt-1-0
    -->
    <xsl:template name="maximum">
        <xsl:param name="pSequence"/>
        <xsl:for-each select="$pSequence">
            <xsl:sort select="." data-type="number" order="descending"/>
            <xsl:if test="position()=1">
                <xsl:value-of select="."/>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>

    <!--Variable that should hold the max PropertyValue-->
    <xsl:variable name="ng_prop_count" select="count(/NewDataSet/Properties[not(PropertyName = 'Globals')])"/>
    <xsl:variable name="max_pv">
        <xsl:call-template name="maximum">
            <xsl:with-param name="pSequence" select="/NewDataSet/Properties/PropertyID"/>
        </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="max_pvid">
        <xsl:call-template name="maximum">
            <xsl:with-param name="pSequence" select="/NewDataSet/PropertyValues/PropertyValueID"/>
        </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="max_sort_order">
        <xsl:call-template name="maximum">
            <xsl:with-param name="pSequence" select="/NewDataSet/Properties/SortOrder"/>
        </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="valence_kw">
        <xsl:value-of select="'VALENCED:'"/>
    </xsl:variable>
    <xsl:variable name="valence_pvid" select="/NewDataSet/Properties[PropertyName = 'Valence']/PropertyID"/>
    <xsl:variable name="valences">
        <array>
            <item>+</item>
            <item>-</item>
        </array>
    </xsl:variable>
    <xsl:variable name="valence_node_set" select="ext:node-set($valences)"/>
    <xsl:variable name="version" select="number(/NewDataSet/CodingSystem/CodingSystemID)"/>

    <xsl:template match="/">
        <CodingSystem>
            <xsl:attribute name="SystemName">
                <xsl:value-of select="NewDataSet/CodingSystem/SystemName"/>
            </xsl:attribute>
            <xsl:attribute name="CodingSystemID">
                <xsl:value-of select="NewDataSet/CodingSystem/CodingSystemID"/>
            </xsl:attribute>
            <xsl:variable name="coding-system" select="NewDataSet/CodingSystem"/>
            <xsl:variable name="propertyValues" select="NewDataSet/PropertyValues"/>
            <xsl:for-each select="NewDataSet/Properties">
                <xsl:sort select="SortOrder" data-type="number"/>
                <!--
                Declare some variables to make constructing the transform easier
                -->

                <xsl:variable name="id" select="./PropertyID"/>
                <!--
                    Make the names of the 'Valence' property uniform for all versions of UCHAT coding system
                -->
                <xsl:variable name="true_prop_name" select="./PropertyName"/>
                <xsl:variable name="property_name">
                    <xsl:choose>
                        <xsl:when test="./PropertyName='Valence'">
                            <xsl:value-of select="'Strength Rating'"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="./PropertyName"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                <xsl:variable name="short_name">
                    <xsl:choose>
                        <xsl:when test="./PropertyName='Valence'">
                            <xsl:value-of select="'Strength'"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="./DisplayName"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                <xsl:variable name="abbreviation">
                    <xsl:choose>
                        <xsl:when test="./PropertyName='Valence'">
                            <xsl:value-of select="'SR'"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="./Abbreviation"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>

                <xsl:variable name="description" select="./Description"/>
                <xsl:variable name="sort_order" select="./SortOrder"/>
                <xsl:variable name="data_type" select="./PropertyType"/>
                <xsl:variable name="digits" select="./DecimalDigits"/>
                <xsl:variable name="zero_pad" select="./ZeroPad"/>
                <xsl:variable name="sort_data_type">
                    <xsl:choose>
                        <xsl:when test="$data_type = 'numeric'">
                            <xsl:value-of select="'number'"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="'text'"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                <!--actually construct the transform-->
                <xsl:choose>
                    <!--
                    Globals are stored as a single property. The following transform will break each global out
                    into its own property with the appropriate values as children
                    -->
                    <!--
                    This transform isolates the individual globals so that they can be made into their own properties
                    Works by finding the unique integer values, which correspond to the unique globals
                    -->
                    <xsl:when test="$property_name = 'Globals'">
                        <xsl:variable name="gv">
                            <Globals>
                                <xsl:for-each select="$propertyValues[PropertyID=$id]">
                                    <xsl:sort select="PropertyValue" data-type="number"/>
                                    <xsl:variable name="int_value" select="number(substring-before(./PropertyValue, '.'))"/>
                                    <global>
                                        <number><xsl:value-of select="$int_value"/></number>
                                        <name><xsl:value-of select="substring-before(./Description, ' ')"/></name>
                                        <id><xsl:value-of select="./PropertyID"/></id>
                                        <new_id><xsl:value-of select="number($max_pv) + number($int_value)"/></new_id>
                                    </global>
                                </xsl:for-each>
                            </Globals>
                        </xsl:variable>
                        <xsl:variable name="gv_node_set" select="ext:node-set($gv)"/>

                        <!--With the globals isolated from each other,
                        we can construct the Property nodes for each of them and add as children the
                        appropriate PropertyValues
                        -->
                        <xsl:for-each select="$gv_node_set/Globals/global[not(preceding-sibling::global/number/text() = ./number/text())]">
                            <xsl:variable name="int_value" select="./number"/>
                            <xsl:variable name="new_id" select="./new_id"/>
                            <GlobalProperty>
                                <xsl:attribute name="PropertyID">
                                    <xsl:value-of select="$new_id"/>
                                </xsl:attribute>
                                <xsl:attribute name="OriginalID">
                                    <xsl:value-of select="$id"/>
                                </xsl:attribute>
                                <xsl:attribute name="PropertyName">
                                    <xsl:value-of select="./name"/>
                                </xsl:attribute>
                                <xsl:attribute name="OriginalName">
                                    <xsl:value-of select="$property_name"/>
                                </xsl:attribute>
                                <xsl:attribute name="DisplayName">
                                    <xsl:value-of select="./name"/>
                                </xsl:attribute>
                                <xsl:attribute name="OriginalDisplayName">
                                    <xsl:value-of select="$short_name"/>
                                </xsl:attribute>
                                <xsl:attribute name="Abbreviation">
                                    <xsl:value-of select="substring(./name, 1, 3)"/>
                                </xsl:attribute>
                                <xsl:attribute name="SortOrder">
                                    <xsl:value-of select="number($int_value) + number($max_sort_order)"/>
                                </xsl:attribute>
                                <xsl:attribute name="PropertyType">
                                    <xsl:value-of select="$data_type"/>
                                </xsl:attribute>
                                <xsl:attribute name="DecimalDigits">
                                    <xsl:value-of select="'0'"/>
                                </xsl:attribute>
                                <xsl:attribute name="ZeroPad">
                                    <xsl:value-of select="$zero_pad"/>
                                </xsl:attribute>
                                <xsl:attribute name="Description">
                                    <xsl:value-of select="./name"/>
                                </xsl:attribute>

                                 <xsl:for-each select="$propertyValues[PropertyID=$id
                                                       and number(substring-before(PropertyValue, '.')) = $int_value]">
                                    <xsl:sort select="PropertyValue" data-type="number"/>
                                    <xsl:variable name="valueID" select="./PropertyValueID"/>
                                    <xsl:variable name="property_value" select="./PropertyValue"/>
                                    <xsl:variable name="new_value" select="substring-after($property_value, '.')"/>
                                    <xsl:variable name="property_description" select="./Description"/>
                                    <PropertyValue>
                                        <xsl:attribute name="PropertyID">
                                            <xsl:value-of select="$new_id"/>
                                        </xsl:attribute>
                                        <xsl:attribute name="PropertyValueID">
                                            <xsl:value-of select="$valueID"/>
                                        </xsl:attribute>
                                        <xsl:attribute name="OriginalValue">
                                            <xsl:value-of select="$property_value"/>
                                        </xsl:attribute>
                                        <xsl:attribute name="Value">
                                            <xsl:value-of select="$new_value"/>
                                        </xsl:attribute>
                                        <xsl:attribute name="Description">
                                            <xsl:value-of select="$property_description"/>
                                        </xsl:attribute>
                                    </PropertyValue>
                                </xsl:for-each>
                            </GlobalProperty>
                        </xsl:for-each>
                    </xsl:when>
                    <xsl:otherwise>
                        <Property>
                            <xsl:attribute name="PropertyID">
                                <xsl:value-of select="$id"/>
                            </xsl:attribute>
                            <xsl:attribute name="PropertyName">
                                <xsl:value-of select="$property_name"/>
                            </xsl:attribute>
                            <xsl:attribute name="DisplayName">
                                <xsl:value-of select="$short_name"/>
                            </xsl:attribute>
                            <xsl:attribute name="Abbreviation">
                                <xsl:value-of select="$abbreviation"/>
                            </xsl:attribute>
                            <xsl:attribute name="SortOrder">
                                <xsl:value-of select="$sort_order"/>
                            </xsl:attribute>
                            <xsl:attribute name="PropertyType">
                                <xsl:value-of select="$data_type"/>
                            </xsl:attribute>
                            <xsl:attribute name="DecimalDigits">
                                <xsl:value-of select="$digits"/>
                            </xsl:attribute>
                            <xsl:attribute name="ZeroPad">
                                <xsl:value-of select="$zero_pad"/>
                            </xsl:attribute>
                            <xsl:attribute name="Description">
                                <xsl:value-of select="$description"/>
                            </xsl:attribute>
                            <xsl:for-each select="$propertyValues[PropertyID=$id]">
                                <xsl:sort select="PropertyValue" data-type="number"/>
                                <xsl:variable name="valueID" select="./PropertyValueID"/>
                                <xsl:variable name="property_value" select="./PropertyValue"/>
                                <xsl:variable name="property_description" select="./Description"/>
                                <PropertyValue>
                                    <xsl:attribute name="PropertyID">
                                        <xsl:value-of select="$id"/>
                                    </xsl:attribute>
                                    <xsl:attribute name="PropertyValueID">
                                        <xsl:value-of select="$valueID"/>
                                    </xsl:attribute>
                                    <xsl:attribute name="Value">
                                        <xsl:value-of select="$property_value"/>
                                    </xsl:attribute>
                                    <xsl:attribute name="Description">
                                        <xsl:value-of select="concat($property_description, ': ', .)"/>
                                    </xsl:attribute>
                                </PropertyValue>
                            </xsl:for-each>
                        </Property>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:for-each>
        </CodingSystem>
    </xsl:template>
</xsl:stylesheet>