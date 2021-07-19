import logging
import lxml.etree as et


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


def parse_xml(path, schemaPath='internal', transform=None, parser=None):
    """
    _parse_xml_(path, schema='internal', transform=None, parser=None) -> _Element
    parses the XML at path and returns the root element of the document
    :param path: path to the XML file to be parsed
    :param schemaPath: path to schema for validation. Default 'internal'. set None for no validation
    :param transform: an elementtree._XSLT with which to perform an XSL transform. Default None
    :param parser: an elementtree.Parser object with which to parse. Default None
    :return: root element of the parsed document
    :raises lxml.etree.DocumentInvalid: If schema is provided and document fails validation
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
        schema = et.XMLSchema(et.parse(schemaPath, parser=parser))  # type: et.XMLSchema

    # Will raise an exception if validation fails
    schema.assertValid(data) if schema is not None else None

    # Apply an XSLT transform to make the data easier to use
    xformData = data if transform is None else transform(data)

    logging.info("Parsing complete")
    return xformData.getroot()


def validate_xml(dataDoc, schemaDoc):
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
