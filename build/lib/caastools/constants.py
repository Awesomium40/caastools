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
    CLIENT_ID = "ClientID"
    CODING_SYSTEM_ID = "CodingSystemID"
    DATA_TYPE = "DataType"
    DECIMAL_DIGITS = "DecimalDigits"
    DESCRIPTION = "Description"
    DISPLAY_NAME = "DisplayName"
    ENUM = "Utt"
    INTERVIEW_ID = "InterviewID"
    LINE = "Line"
    ORIGINAL_DISPLAY_NAME = "OriginalDisplayName"
    ORIGINAL_ID = "OriginalID"
    ORIGINAL_NAME = "OriginalName"
    ORIGINAL_VALUE = "OriginalValue"
    PROPERTY_ID = "PropertyID"
    PROPERTY_NAME = "PropertyName"
    PROPERTY_VALUE_ID = "PropertyValueID"
    ROLE = "Role"
    RATER_ID = "RaterID"
    SESSION_NUMBER = "SessionNumber"
    SORT_ORDER = "SortOrder"
    START_TIME = "StartTime"
    SYSTEM_NAME = "SystemName"
    TEXT = "Text"
    THERAPIST_ID = "TherapistID"
    TREATMENT_CONDITION = "TxCondition"
    VALUE = "Value"
    WORD_COUNT = "Words"
    ZERO_PAD = "ZeroPad"


class IaProperties(object):
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
    
    
#SQL constants
CASCADE = "CASCADE"
ON_UPDATE = "ON UPDATE"
ON_DELETE = "ON DELETE"
REFERENCES = "REFERENCES"
SET_NULL = "SET NULL"


CODE = 'Code'
CODING_SYSTEM = "CodingSystem"
COMPONENT = 'Component'
END_TIME = "EndTime"
GLOBAL = "Global"
GLOBALS = "Globals"

LANGUAGE = "Language"

START_TIME = "StartTime"

TX_CONDITION = "TxCondition"

CS = "CodingSystem"
DESC = "Description"
DIGITS = "DecimalDigits"

DSN = "DisplayName"
DTYPE = "DataType"
GLOBAL_ID = 340
GLOBALS_SHORT = 'Globals'


IVID = "InterviewID"
LINE = "Line"
MISC_ID = 337
MISC_NAME = "MISC"
ODESC = 'OriginalDescription'
ODSN = 'OriginalDisplayName'
OID = 'OriginalID'
ONM = 'OriginalName'
ORDER = "SortOrder"
OVAL = 'OriginalValue'
PID = "PropertyID"
PNM = "PropertyName"
PROP = "Property"
PV = "PropertyValue"
PVID = "PropertyValueID"

ROLE = "ROLE"
RID = "RaterID"
SESSION = "Session"
START = "StartTime"
STRENGTH_NAME = "Strength Rating"
STRENGTH_SHORT = "Strength"
SYS_NAME = "SystemName"
TC_ID = 339

TXT = "Text"
TYPES = {'numeric': float, 'string': str}
UTT = "Utt"
U331 = "UCHAT3.31"
U34 = "UCHAT 3.4"
WORDS = "Words"
VAL = "Value"
CT_PREFIX = 'CT_NOS'
ST_PREFIX = 'ST_NOS'
OTHER_PREFIX = "OTHER"
NS_PREFIX = "NS"
MICO_PREFIX = "MICO"
MIIN_PREFIX = "MIIN"
VALENCED_PREFIX = "VALENCED"
VALENCE_NAME = "Valence"
SR_NAME = "Strength Rating"
VALENCE_ID = 335
VALENCED_MISC_CODES = ['r', 'ra', 'rd', 'rn', 'ts', 'c', 'o']
MICO_CODES = ['af', 'adp', 'ec', 'rcp', 'su', 'quo', 'res', 'rec', 'rf']
MIIN_CODES = ['adw', 'co', 'di', 'wa', 'rcw']
OTHER_CODES = ['st', 'gi', 'quc', 'fa', 'fi', 'nrs', 'nrc', ]
NS_CODES = ['ack', 'int', 'cont', 'unf']
ZPAD = "ZeroPad"
K = "Kappa"
MK = "kMax"
ICC = 'ICC'
OB = 'omnibus'
__TE_MSG__ = "Parameter {0} expected type {1}, got {2}"
