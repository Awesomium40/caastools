from caastools.constants import CONVERT_XFORM, IaNodes, IaAttributes, IV_XFORM
from typing import List
import logging
import lxml.etree as et
import os


logging.getLogger('caastools.parsing.ia.data').addHandler(logging.NullHandler())


class _InterviewLookup(et.CustomElementClassLookup):

    def lookup(self, type, doc, namespace, name):
        cls = _NewDataSet if name == 'NewDataSet' else \
            _Interviews if name == IaNodes.INTERVIEWS else \
            _Globals if name == IaNodes.GLOBALS else \
            _Utterances if name == IaNodes.UTTERANCES else \
            _UtteranceProperties if name == IaNodes.UTT_PROPERTIES else None
        return cls


class _Interviews(et.ElementBase):

    @property
    def interview_name(self):
        return self.find(IaNodes.ID).text

    @interview_name.setter
    def interview_name(self, value):
        self.find(IaNodes.ID).text = value

    @property
    def rater(self):
        return self.find(IaNodes.MODIFIED_BY).text


class _Globals(et.ElementBase):

    @property
    def original_value(self):
        return self.find(IaAttributes.ORIGINAL_VALUE).text

    @property
    def property_id(self):
        return int(self.find(IaAttributes.PROPERTY_ID).text)

    @property
    def property_value_id(self):
        return int(self.find(IaAttributes.PROP_VALUE_ID).text)

    @property
    def property_name(self):
        return self.find(IaAttributes.PROPERTY_NAME).text

    @property
    def property_value(self):
        return self.find(IaAttributes.PROPERTY_VALUE).text


class _Utterances(et.ElementBase):

    @property
    def demarcation_set_id(self):
        return int(self.find(IaNodes.DEMARC_SET_ID).text)

    @property
    def line_number(self):
        return int(self.find(IaNodes.LINE_NO).text)

    @property
    def speaker_role(self):
        return self.find(IaNodes.SPEAKER_ROLE).text

    @property
    def start_time(self):
        return float(self.find(IaNodes.START_TIME).text)

    @property
    def utterance_id(self):
        return int(self.find(IaAttributes.UTTERANCE_ID).text)

    @property
    def utterance_number(self):
        return int(self.find(IaNodes.UTT_NUM).text)

    @property
    def utterance_text(self):
        return self.find(IaNodes.TEXT).text

    @property
    def word_count(self):
        return int(self.find(IaNodes.WORD_COUNT).text)


class _UtteranceProperties(et.ElementBase):

    @property
    def coding_set_id(self) -> int:
        return int(self.find(IaAttributes.CODING_SET_ID).text)

    @property
    def property_id(self) -> int:
        return int(self.find(IaAttributes.PROPERTY_ID).text)

    @property
    def property_name(self) -> str:
        return self.find(IaAttributes.PROPERTY_NAME).text

    @property
    def property_value(self) -> int:
        return self.find(IaAttributes.PROPERTY_VALUE).text

    @property
    def property_value_description(self) -> str:
        return self.find(IaNodes.PROP_VALUE_DESC).text

    @property
    def property_value_id(self) -> int:
        return int(self.find(IaAttributes.PROP_VALUE_ID).text)

    @property
    def utterance_id(self) -> int:
        return int(self.find(IaAttributes.UTTERANCE_ID).text)

    @property
    def utterance_property_id(self) -> int:
        return int(self.find(IaAttributes.UTT_PROP_ID).text)


class _NewDataSet(et.ElementBase):

    @property
    def coding_set_id(self):
        return int(self.find("./CodingSets/CodingSystemID").text)

    @property
    def global_ratings(self) -> List[_Globals]:
        return self.findall(IaNodes.GLOBALS)

    @property
    def interview_info(self) -> _Interviews:
        return self.find(IaNodes.INTERVIEWS)

    @property
    def utterances(self) -> List[_Utterances]:
        return self.findall(IaNodes.UTTERANCES)

    @property
    def utterance_properties(self):
        return self.findall(IaNodes.UTT_PROPERTIES)


def _renumber_(nodes, tag, scalar):
    """
    _renumber_(nodes, tag, start_value) -> None
    For the collection of Elements 'nodes', each having child element 'tag', renumbers the text of 'tag' in place
    such that scalar is added to it
    :param nodes: collection of nodes to be renumbered
    :param tag: tag of the child element of each node to renumber
    :param scalar: the value to be added to each <tag> element's value
    :return: None
    """

    for node in nodes:
        child = node.find(tag)
        child.text = str(int(child.text) + scalar)


def _set_all_text_(root, tag, value):
    """
    _set_all_text_(root, tag, value) -> None
    Finds all <tag> descendants of root and sets their text to value
    :param root: the root whose descendants are to be located
    :param tag: the tag of the elements to be located and changed
    :param value: the value to set element text to
    :return: None
    """

    for element in root.xpath(f"//{tag}"):
        element.text = value


def InterviewData(interview_name, fragments):
    """
    Reconstructs the interview represented by fragments into an XML document
    :param interview_name: the name of the interview
    :param fragments: collection listing the paths to the interview fragment files
    :param parser: et._Parser to parse the XML
    :return: et._ElementTree The reconstructed document
    """

    ns = {"xs": "http://www.w3.org/2001/XMLSchema",
          "msdata": "urn:schemas-microsoft-com:xml-msdata"}

    if len(fragments) < 0:
        raise ValueError("No interview files provided")

    parser = et.XMLParser()
    parser.set_element_class_lookup(_InterviewLookup())

    speaker_segment_nodes = []
    utt_nodes = []
    utt_seg_nodes = []
    utterance_prop_nodes = []
    output_dict = {IaNodes.SPEAKER_SEGMENTS: speaker_segment_nodes,
                   IaNodes.UTT_SEGMENTS: utt_seg_nodes,
                   IaNodes.UTTERANCES: utt_nodes,
                   IaNodes.UTT_PROPERTIES: utterance_prop_nodes}

    # Construct the et.XSLT object required to perform the transformations on the data
    script_dir = os.path.dirname(os.path.realpath(__file__))
    update_transform = et.XSLT(et.parse(os.path.join(script_dir, CONVERT_XFORM), parser))
    final_transform = et.XSLT(et.parse(os.path.join(script_dir, IV_XFORM), parser))

    schema_element_path = "{0}schema/{0}element/{0}complexType/{0}choice/{0}element".format('{' + ns['xs'] + '}')

    # Reconstruct the interview from XML data
    # This will be the root of the reconstructed document
    root_element = et.fromstring("<NewDataSet></NewDataSet>", parser=parser)  # type: et._Element

    # used for renumbering line/utterance info
    line_start = 0
    utt_start = 0
    seg_start = 0
    for i, file in enumerate(fragments):
        document = et.parse(file, parser=parser)
        root = document.getroot()
        version = int(root.find(f"./{IaNodes.CODING_SETS}/{IaAttributes.CODING_SYSTEM_ID}").text)
        element_names = [node.get('name') for node in root.findall(schema_element_path)]

        if version < 138:
            raise ValueError("Interviews scored with UCHAT versions below 3.31 are not compatible")
        if version == 138:
            document = update_transform(document)
            root = document.getroot()

        # Interview needs to be rebuilt from the ground up
        # Elements are list-like, so simply copy nodes from the fragments to the new, reconstructed interview
        if i == 0:
            root_element.append(root.find(f"{{{ns['xs']}}}schema"))
            output_dict[IaNodes.INTERVIEWS] = root.find(IaNodes.INTERVIEWS)
            output_dict[IaNodes.DEMARC_SET] = root.find(IaNodes.DEMARC_SET)
            output_dict[IaNodes.CODING_SETS] = root.find(IaNodes.CODING_SETS)
            output_dict[IaNodes.PROPERTY_NAMES] = root.find(IaNodes.PROPERTY_NAMES)
            interview_id = root.find(f"./{IaNodes.INTERVIEWS}/{IaAttributes.INTERVIEW_ID}").text
            dem_set_id = root.find(f"./{IaNodes.DEMARC_SET}/{IaAttributes.DEM_SET_ID}").text
            coding_set_id = root.find(f"./{IaNodes.CODING_SETS}/{IaAttributes.CODING_SET_ID}").text

        # Ensure that all nodes are in the proper order
        ss_nodes = sorted(root.findall(IaNodes.SPEAKER_SEGMENTS), key=lambda e: int(e.find(IaAttributes.LINE_NO).text))
        u_nodes = sorted(root.findall(IaNodes.UTTERANCES), key=lambda e: int(e.find(IaAttributes.UTT_NUMBER).text))
        us_nodes = sorted(root.findall(IaNodes.UTT_SEGMENTS), key=lambda e: int(e.find(IaAttributes.UTT_SEGMENT_COUNT).text))
        up_nodes = sorted(root.findall(IaNodes.UTT_PROPERTIES), key=lambda e: int(e.find(IaAttributes.UTT_PROP_ID).text))

        speaker_segment_nodes.extend(ss_nodes)
        utt_nodes.extend(u_nodes)
        utt_seg_nodes.extend(us_nodes)
        utterance_prop_nodes.extend(up_nodes)

        # Because interviews that have been fragmented have their LineNumber, UtteranceNumber,
        # and UtteranceSegmentCount reset in each fragment, need to change these enumerations.
        if i > 0:
            _renumber_(ss_nodes, IaAttributes.LINE_NO, line_start)
            _renumber_(u_nodes, IaAttributes.UTT_NUMBER, utt_start)
            _renumber_(us_nodes, IaAttributes.UTT_SEGMENT_COUNT, seg_start)
            _renumber_(us_nodes, IaAttributes.LINE_NO, line_start)

        # Update the counters that assist in renumbering line, utterance, etc.
        line_start = max(int(e.find(IaAttributes.LINE_NO).text) for e in ss_nodes)
        utt_start = max(int(e.find(IaAttributes.UTT_NUMBER).text) for e in u_nodes)
        seg_start = max(int(e.find(IaAttributes.UTT_SEGMENT_COUNT).text) for e in us_nodes)

    # Ensure that all nodes are in the proper order
    speaker_segment_nodes.sort(key=lambda e: int(e.find(IaAttributes.LINE_NO).text))
    utt_nodes.sort(key=lambda e: int(e.find(IaAttributes.UTT_NUMBER).text))
    utt_seg_nodes.sort(key=lambda e: int(e.find(IaAttributes.UTT_SEGMENT_COUNT).text))
    utterance_prop_nodes.sort(key=lambda e: int(e.find(IaAttributes.UTT_PROP_ID).text))

    # Append all the elements to the new root of the reconstructed document
    for tag in element_names:
        node_set = output_dict[tag]
        func = root_element.extend if isinstance(node_set, list) else root_element.append
        func(node_set)

    # ensure that CodingSetID, DemarcationSetID, and InterviewID are all set properly
    _set_all_text_(root_element, IaAttributes.CODING_SET_ID, coding_set_id)
    _set_all_text_(root_element, IaAttributes.DEM_SET_ID, dem_set_id)
    _set_all_text_(root_element, IaAttributes.INTERVIEW_ID, interview_id)

    output_dict[IaNodes.INTERVIEWS].find(IaAttributes.ID).text = interview_name

    return final_transform(root_element.getroottree()).getroot()
