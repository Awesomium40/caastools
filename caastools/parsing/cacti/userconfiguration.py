from ...constants import CactiAttributes, CactiNodes
import lxml.etree as et
import os


class _CactiLookup(et.CustomElementClassLookup):

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

        return _UserConfiguration if name == CactiNodes.USER_CONFIG else \
            _Code if name == CactiNodes.CODE else \
            _Component if name == CactiNodes.COMPONENT else \
            _Global if name == CactiNodes.GLOBAL else None


"""
Base classes for the Elements of the userConfiguration document
"""


class _ElementBase(et.ElementBase):

    @property
    def name(self):
        return self.get(CactiAttributes.NAME)


class _CodeElementBase(_ElementBase):

    @property
    def value(self):
        return self.get(CactiAttributes.VALUE)

    @property
    def description(self):
        return self.get(CactiAttributes.DESCRIPTION)


class _HasParentElementBase(_ElementBase):

    @property
    def parent_value(self):
        return self.get(CactiAttributes.PARENT)

    @property
    def summary_mode(self):
        return self.get(CactiAttributes.SUM_MODE)


"""
Sub-classes, correspond to nodes within the userConfiguration.XML document itself
"""


class _Code(_CodeElementBase, _HasParentElementBase):
    pass


class _Component(_ElementBase):
    pass


class _Global(_HasParentElementBase):

    @property
    def data_type(self):
        return 'numeric'


class _UserConfiguration(_ElementBase):

    @property
    def codes(self):
        return self.find(CactiNodes.CODES)

    @property
    def components(self):
        return self.find(CactiNodes.COMPONENTS)

    @property
    def globals(self):
        return self.iterfind(CactiNodes.GLOBALS)


def UserConfiguration(path):
    """
    UserConfiguration(path) -> parsing.cacti.userconfiguration._UserConfiguration
    Parses the userConfiguration.xml at the path specified and returns a _UserConfiguration object
    :param path: path to the userConfiguration.XML to be parsed
    :return: _UserConfiguration object
    :raise: lxml.etree.DocumentInvalid if validation against schema fails
    """
    parser = et.XMLParser()
    parser.set_element_class_lookup(_CactiLookup())
    script_dir = os.path.dirname(__file__)
    schema = et.XMLSchema(et.parse(os.path.join(script_dir, 'cacti_schema.xsd'), parser=parser))
    data = et.parse(path, parser=parser)
    schema.assertValid(data)
    return data.getroot()
