from enum import Enum

IV_XFORM = "interview_transform.xslt"
CS_XFORM = "cs_transform.xslt"
CONVERT_XFORM = 'translate_u331_interview_to_u34.xslt'


class CodingSystemType(Enum):
        CACTI = 0
        IA = 1


class GlobalType(Enum):
    MISC = 0
    SELF_EXPLORE = 1


class CactiAttributes(object):
    CP_NAME = 'codingPropertyName'
    DESCRIPTION = 'description'
    MAX_RATING = 'maxRating'
    MIN_RATING = 'minRating'
    NAME = 'name'
    PARENT = 'parent'
    SUM_MODE = 'summaryMode'
    USER_CONFIG_ID = 'userConfigurationID'
    VALUE = 'value'


class CactiNodes(object):
    CODE = 'code'
    CODES = 'codes'
    GLOBAL = 'global'
    GLOBALS = 'globals'
    COMPONENT = 'component'
    COMPONENTS = 'components'
    USER_CONFIG = 'userConfiguration'


class IaAttributes(object):
    ABBREVIATION = "Abbreviation"
    CODING_SET_ID = "CodingSetID"
    CODING_SYSTEM_ID = "CodingSystemID"
    CODING_SYSTEM_NAME = "CodingSystemName"
    DECIMAL_DIGITS = "DecimalDigits"
    DESCRIPTION = "Description"
    DEM_SET_ID = "DemarcationSetID"
    DISPLAY_NAME = "DisplayName"
    ID = 'ID'
    INTERVIEW_ID = "InterviewID"
    LINE_NO = "LineNumber"
    PROPERTY_ID = "PropertyID"
    PROPERTY_NAME = "PropertyName"
    PROPERTY_TYPE = "PropertyType"
    PROPERTY_VALUE = "PropertyValue"
    PROP_VALUE_ID = "PropertyValueID"
    SORT_ORDER = "SortOrder"
    SPEAKER_ROLE = "SpeakerRole"
    START_TIME = "StartTime"
    SYSTEM_NAME = "SystemName"
    TEXT = "Text"
    UTTERANCE_ID = "UtteranceID"
    UTT_NUMBER = "UtteranceNumber"
    UTT_PROP_ID = "UtterancePropertyID"
    UTT_SEGMENT_COUNT = "UtteranceSegmentCount"
    VALUE = "Value"
    WORD_COUNT = "WordCount"
    ZERO_PAD = "ZeroPad"


class IaNodes(object):
    CODE = "Code"
    CODING_SETS = "CodingSets"
    CODING_SYSTEM = "CodingSystem"
    DEMARC_SET = "DemarcationSets"
    GLOBAL = "Global"
    GLOBAL_PROPERTY = "GlobalProperty"
    GLOBALS = "Globals"
    INTERVIEWS = "Interviews"
    INTERVIEW = "Interview"
    NEW_DATASET = "NewDataSet"
    PROPERTY = "Property"
    PROPERTY_NAMES = "PropertyNames"
    PROPERTY_VALUE = "PropertyValue"
    SPEAKER_SEGMENTS = "SpeakerSegments"
    UTT_PROPERTIES = "UtteranceProperties"
    UTT_SEGMENTS = "UtteranceSegments"
    UTTERANCE = "Utterance"
    UTTERANCES = "Utterances"


THERAPIST_GLOBALS_SLICE = slice(6, 12, 1)
CLIENT_GLOBALS_SLICE = slice(13, 14, 1)
SE_GLOBALS_SLICE = slice(15, 19, 1)
