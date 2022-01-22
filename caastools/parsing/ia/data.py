from caastools.constants import CONVERT_XFORM, IaNodes, IaAttributes, IV_XFORM
from caastools.parsing.common import DataSet, Global, Interview, Utterance, UtteranceProperty
import logging
import lxml.etree as et
import os


__all__ = ['parse_interview']

logging.getLogger('caastools.parsing.ia.data').addHandler(logging.NullHandler())


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


def parse_interview(interview_name, fragments, **kwargs) -> DataSet:
    """
    Reconstructs the interview represented by fragments into an XML document
    :param interview_name: the name of the interview
    :param fragments: collection listing the paths to the interview fragment files
    :return: caastools.parsing.common.DataSet
    """
    translate_path = kwargs.get('translate_path', None)
    translate = et.XSLT(et.parse(translate_path)) if translate_path is not None else None

    ns = {"xs": "http://www.w3.org/2001/XMLSchema",
          "msdata": "urn:schemas-microsoft-com:xml-msdata"}

    if len(fragments) < 0:
        raise ValueError("No interview files provided")

    globals = []
    utterances = []
    utterance_properties = []
    coding_system_id = None
    interview = None

    # Construct the et.XSLT object required to perform the transformations on the data
    script_dir = os.path.dirname(os.path.realpath(__file__))
    final_transform = et.XSLT(et.parse(os.path.join(script_dir, IV_XFORM)))

    schema_element_path = "{0}schema/{0}element/{0}complexType/{0}choice/{0}element".format('{' + ns['xs'] + '}')

    # used for renumbering line/utterance info
    line_start = 0
    utt_start = 0

    for i, file in enumerate(fragments):
        document = et.parse(file)

        # if a translation was specified, parse it into XLST and use it to perform the translation
        if translate is not None:
            document = translate(document)

        # Once the initial parsing and transformation has occurred,
        # can transform into something a bit more digestible
        document = final_transform(document)
        root = document.getroot()

        # Because interviews are fragmented, some properties are different between fragments.
        # These will need to be made uniform, so extract values from the initial fragment
        if i == 0:
            coding_system_id = int(root.find("./CodingSets/CodingSystemID").text)
            coding_system_name = root.find("./CodingSets/CodingSystemName").text
            interview = Interview(interview_name, root.find("./Interviews/ModifiedBy").text)

        # Ensure that all nodes are in the proper order
        u_nodes = sorted(root.findall(IaNodes.UTTERANCES), key=lambda e: int(e.find(IaAttributes.UTT_NUMBER).text))
        up_nodes = sorted(root.findall(IaNodes.UTT_PROPERTIES), key=lambda e: int(e.find(IaAttributes.UTT_PROP_ID).text))

        # Because interviews that have been fragmented have their LineNumber, UtteranceNumber,
        # and UtteranceSegmentCount reset in each fragment, need to change these enumerations.
        if i > 0:
            _renumber_(u_nodes, 'LineNumber', line_start)
            _renumber_(u_nodes, 'UtteranceNumber', utt_start)

        # Update the counters that assist in renumbering line, utterance, etc.
        line_start = int(u_nodes[-1].find('LineNumber').text)
        utt_start = int(u_nodes[-1].find('UtteranceNumber').text)

        # Construct the dataclasses from the xml and append to the lists
        globals.extend(
            (Global(g.find('OriginalValue').text, int(g.find('PropertyID').text),
             int(g.find('PropertyValueID').text), g.find('PropertyName').text, g.find('PropertyValue').text)
             for g in root.findall('Globals'))
        )

        new_utterances = [
            Utterance(int(u.find('LineNumber').text), u.find('SpeakerRole').text,
                      float(u.find('StartTime').text), None, int(u.find('UtteranceID').text),
                      int(u.find('UtteranceNumber').text), u.find('Text').text, int(u.find('WordCount').text))
            for u in u_nodes
        ]
        utterances.extend(new_utterances)
        utterance_lookup = {u.utterance_id: u for u in new_utterances}

        utterance_properties.extend(
            (UtteranceProperty(int(u.find('PropertyID').text),
                               u.find('PropertyName').text, u.find('PropertyValue').text,
                               u.find('PropertyValueDescription').text, int(u.find('PropertyValueID').text),
                               int(u.find('UtteranceID').text), int(u.find('UtterancePropertyID').text),
                               utterance_lookup.get(int(u.find('UtteranceID').text)))
             for u in up_nodes)
        )

    # Once all the data in the various fragments has been parsed, can construct the DataSet object
    dataset = DataSet(globals, interview, utterances, utterance_properties, coding_system_id, coding_system_name)

    return dataset
