from dataclasses import dataclass
from typing import List

__all__ = ['DataSet', 'Global', 'Interview', 'Utterance', 'UtteranceProperty']


@dataclass
class Interview:
    interview_name: str
    rater: str


@dataclass
class Global:
    original_value: str
    property_id: int
    property_value_id: int
    property_name: str
    property_value: str


@dataclass
class Utterance:
    line_number: int = None
    speaker_role: str = None
    start_time: float = None
    end_time: float = None
    utterance_id: int = None
    utterance_number: int = None
    utterance_text: str = None
    word_count: int = None


@dataclass
class UtteranceProperty:
    property_id: int
    property_name: str
    property_value: str
    property_value_description: str
    property_value_id: int
    utterance_id: int
    utterance_property_id: int
    utterance: Utterance


@dataclass
class DataSet:
    global_ratings: List[Global]
    interview_info: Interview
    utterances: List[Utterance]
    utterance_properties: List[UtteranceProperty]
    coding_set_id: int = None
