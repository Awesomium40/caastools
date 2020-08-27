from caastools.parsing.ia.common import parse_xml
from caastools.constants import CS_XFORM, IaAttributes, IaNodes
import lxml.etree as et
import os


class _IaLookup(et.CustomElementClassLookup):

    def lookup(self, type, doc, namespace, name):
        """
        UchatLookup.lookup(type, doc, namespace, name) -> et.ElementBase
        Provides Lookup service for custom et.ElementBase subclasses
        :param type: the type of node to be looked up
        :param doc: the document containing the node to be looked up
        :param namespace: the namespace of the node to be looked up
        :param name: the tag name of the node to be looked up
        :return: a subclass of lxml.etree.ElementBase
        """

        return _IaConfiguration if name == IaNodes.CODING_SYSTEM else \
            _Property if name == IaNodes.PROPERTY else \
            _PropertyValue if name == IaNodes.PROPERTY_VALUE else \
            _GlobalProperty if name == IaNodes.GLOBAL_PROPERTY else None


class _HasDescriptionElementBase(et.ElementBase):

    @property
    def description(self):
        return self.get(IaAttributes.DESCRIPTION)


class _HasPropertyValueElementBase(et.ElementBase):

    @property
    def property_values(self):
        return self.findall(IaNodes.PROPERTY_VALUE)


class _IaConfiguration(et.ElementBase):

    @property
    def coding_properties(self):
        return self.findall(IaNodes.PROPERTY)

    @property
    def global_properties(self):
        return self.findall(IaNodes.GLOBAL_PROPERTY)

    @property
    def system_id(self):
        return int(self.get(IaAttributes.CODING_SYSTEM_ID))

    @property
    def system_name(self):
        return self.get(IaAttributes.SYSTEM_NAME)


class _Property(_HasDescriptionElementBase, _HasPropertyValueElementBase):

    @property
    def abbreviation(self):
        return self.get(IaAttributes.ABBREVIATION)

    @property
    def data_type(self):
        return self.get(IaAttributes.PROPERTY_TYPE)

    @property
    def decimal_digits(self):
        return self.get(IaAttributes.DECIMAL_DIGITS)

    @property
    def display_name(self):
        return self.get(IaAttributes.DISPLAY_NAME)

    @property
    def property_id(self):
        return int(self.get(IaAttributes.PROPERTY_ID))

    @property
    def property_name(self):
        return self.get(IaAttributes.PROPERTY_NAME)

    @property
    def sort_order(self):
        return int(self.get(IaAttributes.SORT_ORDER))

    @property
    def zero_pad(self):
        return self.get(IaAttributes.ZERO_PAD) == 'true'


class _GlobalProperty(_Property):

    @property
    def original_property_id(self):
        return int(self.get(IaAttributes.ORIGINAL_ID))

    @property
    def original_name(self):
        return self.get(IaAttributes.ORIGINAL_NAME)

    @property
    def original_display_name(self):
        return self.get(IaAttributes.ORIGINAL_DISPLAY_NAME)


class _PropertyValue(_HasDescriptionElementBase):

    @property
    def original_value(self):
        ov = self.get(IaAttributes.ORIGINAL_VALUE)
        return ov if ov is None else int(ov)

    @property
    def property_id(self):
        return int(self.get(IaAttributes.PROPERTY_ID))

    @property
    def property_value_id(self):
        return int(self.get(IaAttributes.PROP_VALUE_ID))

    @property
    def value(self):
        return self.get(IaAttributes.VALUE)


def IaConfiguration(file):
    """
    IaConfiguration(file) -> _IaConfiguration
    :param path: file-like object containing valid IA Coding System XML, or path thereto
    :return: _IaConfiguration object
    """
    parser = et.XMLParser()
    parser.set_element_class_lookup(_IaLookup())
    script_dir = os.path.dirname(__file__)
    xform = et.XSLT(et.parse(os.path.join(script_dir, CS_XFORM), parser))
    ia_config = parse_xml(file, 'internal', xform, parser=parser)

    return ia_config
