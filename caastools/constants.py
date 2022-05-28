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
    CODE = 'code'
    LABEL = 'label'
    METHOD = 'method'


class CactiNodes(object):
    CODE = 'code'
    CODES = 'codes'
    GLOBAL = 'global'
    GLOBALS = 'globals'
    COMPONENT = 'component'
    COMPONENTS = 'components'
    USER_CONFIG = 'userConfiguration'
    SUMMARY = 'summary'
    VARIABLE = 'variable'


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
    ORIGINAL_DISPLAY_NAME = "OriginalDisplayName"
    ORIGINAL_ID = "OriginalID"
    ORIGINAL_NAME = "OriginalName"
    ORIGINAL_VALUE = "OriginalValue"
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
    DEMARC_SET_ID = "DemarcationSetID"
    GLOBAL = "Global"
    GLOBAL_PROPERTY = "GlobalProperty"
    GLOBALS = "Globals"
    ID = "ID"
    INTERVIEWS = "Interviews"
    INTERVIEW = "Interview"
    LINE_NO = "LineNumber"
    MODIFIED_BY = "ModifiedBy"
    NEW_DATASET = "NewDataSet"
    PROPERTY = "Property"
    PROPERTY_NAMES = "PropertyNames"
    PROPERTY_VALUE = "PropertyValue"
    PROP_VALUE_DESC = "PropertyValueDescription"
    SPEAKER_ROLE = "SpeakerRole"
    SPEAKER_SEGMENTS = "SpeakerSegments"
    START_TIME = "StartTime"
    TEXT = "Text"
    UTT_NUM = "UtteranceNumber"
    UTT_PROPERTIES = "UtteranceProperties"
    UTT_SEGMENTS = "UtteranceSegments"
    UTTERANCE = "Utterance"
    UTTERANCES = "Utterances"
    WORD_COUNT = "WordCount"


THERAPIST_GLOBALS_SLICE = slice(3, 9, 1)
CLIENT_GLOBALS_SLICE = slice(10, 11, 1)
SE_GLOBALS_SLICE = slice(12, 16, 1)
