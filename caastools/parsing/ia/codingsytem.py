from caastools.parsing.ia.common import parse_xml
from caastools.constants import CS_XFORM
import lxml.etree as et
import os


def parse_coding_system(path, parser=None):
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
    codingSystem = parse_xml(path, 'internal', xform, parser=parser)

    return codingSystem