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

        element = None
        if name == CactiNodes.USER_CONFIG:
            element = _UserConfiguration
        elif name == CactiNodes.CODE:
            element = _Code
        elif name == CactiNodes.COMPONENT:
            element = _Component
        elif name == CactiNodes.GLOBAL:
            element = _Global
        elif name == CactiNodes.SUMMARY:
            element = _Summary
        elif name == CactiNodes.VARIABLE:
            element = _SummaryVariable

        return element


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

    @property
    def var_name(self):
        return self.get('var')


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


class _Component(_CodeElementBase):
    pass


class _Global(_CodeElementBase, _HasParentElementBase):

    @property
    def data_type(self):
        return 'numeric'

    @property
    def min_rating(self):
        return int(self.get(CactiAttributes.MIN_RATING))

    @property
    def max_rating(self):
        return self.get(CactiAttributes.MAX_RATING)

    @property
    def summary_mode(self):
        return self.get(CactiAttributes.SUM_MODE)


class _Summary(_ElementBase):

    @property
    def label(self):
        return self.get(CactiAttributes.LABEL)

    @property
    def type(self):
        return self.get(CactiAttributes.TYPE)

    @property
    def method(self):
        return self.get(CactiAttributes.METHOD)

    @property
    def variables(self):
        return self.findall('variable')


class _SummaryVariable(_ElementBase):
    pass


class _UserConfiguration(_ElementBase):
    """
    _UserConfiguration is a simple wrapper around an et._Element object, with properties and methods that make
    accessing important data easier to do without any xpath expressions
    """

    '''
    Properties
    '''

    @property
    def codes(self):
        return self.find(CactiNodes.CODES)

    @property
    def components(self):
        return self.find(CactiNodes.COMPONENTS)

    @property
    def globals(self):
        return self.find(CactiNodes.GLOBALS)

    @property
    def summaries(self):
        return self.find('summaries')

    @property
    def original_path(self):
        return self.get("OriginalPath")

    @original_path.setter
    def original_path(self, value):
        self.set("OriginalPath", value)

    '''
    private methods
    '''
    def _find_(self, prop, **kwargs):

        element_dict = {CactiNodes.CODES: CactiNodes.CODE,
                        CactiNodes.COMPONENTS: CactiNodes.COMPONENT,
                        CactiNodes.GLOBALS: CactiNodes.GLOBAL}
        element = element_dict.get(prop)
        if element is None:
            raise ValueError(f"paramenter 'prop' expected ('codes', 'components', 'globals'), got {prop}]")

        predicate = ("[" + " and ".join(f"@{key}='{value}'" for key, value in kwargs.items()) + "]") \
            if len(kwargs) > 0 else ""

        xpath = f"./{prop}/{element}{predicate}"
        results = self.xpath(xpath)
        return results[0] if len(results) > 0 else None

    '''
    public methods
    '''
    def find_code(self, **kwargs):
        """
        uc.find_code(**kwargs) -> _Code | None
        Selects the first code element from the document meeting all of the specified criteria,
        or None if no matching code found
        :param kwargs: sequence of attribute-value pairs specifying search criteria.
        argument names should be attributes of the element to query,
        argument values should be value that the attribute should be equal to.
        Specifying multiple keyword arguments will only match nodes that meet ALL of the search criteria
        :return: _Code object, or None if no matches found
        """
        return self._find_(CactiNodes.CODES, **kwargs)

    def find_component(self, **kwargs):
        """
        uc.find_component(**kwargs) -> _Code | None
        Selects the first component element from the document meeting all of the specified criteria,
        or None if no matching code found
        :param kwargs: sequence of attribute-value pairs specifying search criteria.
        argument names should be attributes of the element to query,
        argument values should be value that the attribute should be equal to.
        Specifying multiple keyword arguments will only match nodes that meet ALL of the search criteria
        :return: _Code object, or None if no matches found
        """
        return self._find_(CactiNodes.COMPONENTS, **kwargs)

    def find_global(self, **kwargs):
        """
        uc.find_global(**kwargs) -> _Code | None
        Selects the first global element from the document meeting all of the specified criteria,
        or None if no matching code found
        :param kwargs: sequence of attribute-value pairs specifying search criteria.
        argument names should be attributes of the element to query,
        argument values should be value that the attribute should be equal to.
        Specifying multiple keyword arguments will only match nodes that meet ALL of the search criteria
        :return: _Code object, or None if no matches found
        """
        return self._find_(CactiNodes.GLOBALS, **kwargs)


def UserConfiguration(file) -> _UserConfiguration:
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
    data = et.parse(file, parser=parser)
    schema.assertValid(data)
    root = data.getroot()
    try:
        root.set("OriginalPath", file.name)
    except:
        pass

    return root
