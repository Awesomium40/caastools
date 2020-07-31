from caastools.constants import CONVERT_XFORM, CS_XFORM, IaNodes, IaAttributes, IV_XFORM
import logging
import lxml.etree as et
import os

__all__ = ['extract_data', 'extract_schema', 'reconstruct_ia']


def _parse_coding_system_(path, parser=None):
    """
    _parse_coding_system_(path) -> et.Element
    Parses the IA coding system into a series of Property and PropertyValue objects

    Parameters:
        path (str): The path to the XML file containing the IA coding system to parse

    Return:
        The <CodingSystem> root element of the parsed coding system
    """
    script_dir = os.path.dirname(__file__)
    xform = et.XSLT(et.parse(os.path.join(script_dir, CS_XFORM), parser))
    codingSystem = _parse_xml_(path, 'internal', xform, parser=parser)

    return codingSystem


def _parse_xml_(path, schemaPath='internal', transform=None, parser=None):
    """
    _parse_xml_(path, schema='internal', transform=None, parser=None) -> _Element
    parses the XML at path and returns the root element of the document
    :param path: path to the XML file to be parsed
    :param schemaPath: path to schema for validation. Default 'internal'. set None for no validation
    :param transform: an elementtree._XSLT with which to perform an XSL transform. Default None
    :param parser: an elementtree.Parser object with which to parse. Default None
    :return: root element of the parsed document
    """

    # parse the file into an etree
    logging.info("Parsing xml document at {0}".format(path))
    data = et.parse(path, parser=parser)

    # Validate the document
    if schemaPath.lower() == 'internal':
        schema = extract_schema(data)
        data = extract_data(data, parser)
    elif schemaPath is None:
        schema = None
    else:
        schema = et.parse(schemaPath, parser=parser)

    results = _validate_xml_(data, schema) if schema is not None else None

    if results is not None:
        raise results

    # Apply an XSLT transform to make the data easier to use
    xformData = data if transform is None else transform(data)

    logging.info("Parsing complete")
    return xformData.getroot()


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

    for element in root.xpath("//{0}".format(tag)):
        element.text = value


def _validate_xml_(dataDoc, schemaDoc):
    """
    Validates an XML document against the schema document and raises an exception if validation fails

    Parameters:
        dataDoc (lxml.etree.Element): The document to be validated
        schemaDoc (lxml.etree.Element): The schema document against which to validate
    """

    logging.info("Validating document via XMLSchema")
    schema = et.XMLSchema(schemaDoc)

    results = schema.assertValid(dataDoc)
    return results


def extract_data(document, parser=None):
    """
    Dataset.extract_data(document, parser=None) -> ElementTree
    Extracts the data portion of the provided XML document
    :param document: The lxml.etree.ElementTree document from which to extract
    :param parser: the lxml parser object to use in parsing. Default None
    :return lxml.etree.ElementTree: The ElementTree object
    """
    NS = {'xs': "http://www.w3.org/2001/XMLSchema"}

    # extract the Elements in the document minus the schema elements
    nodes = document.xpath('./*[not(self::xs:schema)]', namespaces=NS)
    new_data_set = et.fromstring("<NewDataSet></NewDataSet>", parser)

    for n in nodes:
        new_data_set.append(n)

    return new_data_set.getroottree()


def extract_schema(document):
    """
    Dataset._extract_schema(document) -> lxml.etree.Element
    Extracts the embedded schema from the provided XML document
    :param document: The lxml.etree._ElementTree from which to extract the internal schema
    :return lxml.etree._Element: THe root node of the internal schema
    :raise ValueError: if no internal schema found
    """
    NS = {'xs': "http://www.w3.org/2001/XMLSchema"}

    logging.info("Extracting external schema...")

    # Run an XPath to get only the Schema element embedded in the document
    schema = document.xpath('./xs:schema', namespaces=NS)
    if len(schema) == 0:
        raise ValueError("No Schema Found")

    logging.info("Extraction complete")
    return et.XMLSchema(schema[0])


def reconstruct_ia(interview_name, fragments, parser=None):
    """
    Reconstructs the interview represented by fragments into an XML document
    :param interview_name: the name of the interview
    :param fragments: collection listing the interview fragment files
    :param parser: et._Parser to parse the XML
    :return: et._ElementTree The reconstructed document
    """

    ns = {"xs": "http://www.w3.org/2001/XMLSchema",
          "msdata": "urn:schemas-microsoft-com:xml-msdata"}

    if len(fragments) < 0:
        raise ValueError("No interview files provided")

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
        version = int(root.find("./{0}/{1}".format(IaNodes.CODING_SETS,
                                                   IaAttributes.CODING_SYSTEM_ID)).text)
        element_names = [node.get('name') for node in root.findall(schema_element_path)]

        if version < 138:
            raise ValueError("Interviews scored with UCHAT versions below 3.31 are not compatible")
        if version == 138:
            document = update_transform(document)
            root = document.getroot()
        elif version != 153:
            raise ValueError("Incompatible coding system: {0}".format(root.find("./CodingSets/CodingSystemName")))

        if i == 0:
            root_element.append(root.find("{{{0}}}schema".format(ns['xs'])))
            output_dict[IaNodes.INTERVIEWS] = root.find(IaNodes.INTERVIEWS)
            output_dict[IaNodes.DEMARC_SET] = root.find(IaNodes.DEMARC_SET)
            output_dict[IaNodes.CODING_SETS] = root.find(IaNodes.CODING_SETS)
            output_dict[IaNodes.PROPERTY_NAMES] = root.find(IaNodes.PROPERTY_NAMES)
            interview_id = root.find("./{0}/{1}".format(IaNodes.INTERVIEWS,
                                                        IaAttributes.INTERVIEW_ID)).text
            dem_set_id = root.find("./{0}/{1}".format(IaNodes.DEMARC_SET, IaAttributes.DEM_SET_ID)).text
            coding_set_id = root.find("./{0}/{1}".format(IaNodes.CODING_SETS,
                                                         IaAttributes.CODING_SET_ID)).text

        ss_nodes = root.findall(IaNodes.SPEAKER_SEGMENTS)
        u_nodes = root.findall(IaNodes.UTTERANCES)
        us_nodes = root.findall(IaNodes.UTT_SEGMENTS)
        up_nodes = root.findall(IaNodes.UTT_PROPERTIES)

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
        line_start = int(ss_nodes[-1].find(IaAttributes.LINE_NO).text)
        utt_start = int(u_nodes[-1].find(IaAttributes.UTT_NUMBER).text)
        seg_start = int(us_nodes[-1].find(IaAttributes.UTT_SEGMENT_COUNT).text)

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

    return final_transform(root_element.getroottree()).getroot().getroottree()
