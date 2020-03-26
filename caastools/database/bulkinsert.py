from .models import *
from .models import db
from ..constants import CactiAttributes, CactiNodes, CLIENT_GLOBALS_SLICE, CodingSystemType, CS_XFORM, \
    IaNodes, IaProperties, SE_GLOBALS_SLICE, THERAPIST_GLOBALS_SLICE
from ..exceptions import *
from ..parsing import *
from peewee import JOIN
import logging
import lxml.etree as et
import os


__all__ = ['upload_coding_system', 'upload_cacti_interview', 'upload_ia_interview']

logging.getLogger('database.bulkinsert').addHandler(logging.NullHandler())


def _insert_cacti_cs_(document: et._ElementTree, path: str = None):
    """
    ds._insert_cact_cs(document) -> None
    inserts the CACTI coding system contained in document into the database
    :param document: the lxml.etree._ElementTree containing the CACTI userConfiguration data
    :param path: the path at which the file represented by document is located
    :return: CodingSystem entity that was inserted into the
    """
    tag_dict = {CactiNodes.CODES: CactiNodes.CODE,
                CactiNodes.COMPONENTS: CactiNodes.COMPONENT}

    # Retrieve all the appropriate nodes in the document so data can be extracted from them
    root = document.getroot()  # type: et._Element
    code_property_node = root.find(CactiNodes.CODES)
    component_property_node = root.find(CactiNodes.COMPONENTS)
    global_property_node = root.find(CactiNodes.GLOBALS)
    global_nodes = global_property_node.findall(CactiNodes.GLOBAL)

    # Inserts must be performed in the correct order to ensure relational integrity
    # CodingSystem first, then CodingProperty, then PropertyValue
    if path is None:
        coding_system_entity, is_new = CodingSystem.get_or_create(cs_name=root.get(CactiAttributes.NAME))
    else:
        coding_system_entity, is_new = CodingSystem.get_or_create(cs_name=root.get(CactiAttributes.NAME),
                                                                  cs_path=path)

    if is_new:
        # CS inserted, can now insert the CodingProperty entities
        code_entity = CodingProperty.create(coding_system=coding_system_entity,
                                            cp_name=code_property_node.get(CactiAttributes.CP_NAME),
                                            cp_display_name=code_property_node.get(CactiAttributes.CP_NAME),
                                            cp_description=code_property_node.get(CactiAttributes.CP_NAME),
                                            cp_data_type='string')
        component_entity = CodingProperty.create(coding_system=coding_system_entity,
                                                 cp_name=component_property_node.get(CactiAttributes.CP_NAME),
                                                 cp_display_name=component_property_node.get(CactiAttributes.CP_NAME),
                                                 cp_description=component_property_node.get(CactiAttributes.CP_NAME),
                                                 cp_data_type='numeric')

        # should be more efficient to do the bulk insert of all propertyvalue entities at once,
        # so collect them all, then do the insertion
        pv_data = []
        for node, entity in ((code_property_node, code_entity),
                             (component_property_node, component_entity)):  # type: et._Element, CodingProperty

            pv_tag = tag_dict.get(node.tag)

            if pv_tag is None:
                raise ValueError("Invalid element type for property_node. Expected 'codes' or 'components', got {0}"
                                 .format(node.tag))

            to_insert = node.iterfind(pv_tag)

            # add all the applicable PropertyValue data to the list so they can be bulk inserted later
            pv_data.extend(__cacti_pv_map_func__(itm, pv_tag, entity)
                for itm in to_insert)

        if len(pv_data) > 0:
            PropertyValue.bulk_insert(pv_data)

        # Globals need to be handled a bit differently, as they are not scored per-utterance, but per-interview
        # GlobalProperties can have a parent-child relationship,
        # so ensure that parents get inserted before children
        gp_data = [__cacti_gp_map_func__(node, coding_system_entity) for node in global_nodes]
        GlobalProperty.bulk_insert(gp_data)
        gp_dict = {itm[0]: itm[1] for itm in
                   GlobalProperty.select(GlobalProperty.source_id, GlobalProperty.global_property_id)
                                 .where(GlobalProperty.coding_system == coding_system_entity)
                                 .tuples()
                                 .execute()}

        # Now, need to insert GlobalValues corresponding to each GlobalProperty
        gv_data = []
        for node in global_nodes:
            source_id = int(node.get(CactiAttributes.VALUE))
            desc = node.get(CactiAttributes.DESCRIPTION)
            value_range = range(int(node.get(CactiAttributes.MIN_RATING)),
                                int(node.get(CactiAttributes.MAX_RATING)) + 1)

            gv_data.extend({GlobalValue.global_property.name: gp_dict[source_id],
                            GlobalValue.gv_value.name: v,
                            GlobalValue.gv_description.name: "{0} {1}".format(desc, v)}
                           for v in value_range)

        if len(gv_data) > 0:
            GlobalValue.bulk_insert(gv_data)

    return CodingSystem.select(CodingSystem, CodingProperty, PropertyValue, GlobalProperty, GlobalValue) \
        .join(CodingProperty, JOIN.LEFT_OUTER) \
        .join(PropertyValue, JOIN.LEFT_OUTER) \
        .switch(CodingSystem) \
        .join(GlobalProperty, JOIN.LEFT_OUTER) \
        .join(GlobalValue, JOIN.LEFT_OUTER) \
        .where(CodingSystem.coding_system_id == coding_system_entity.coding_system_id).get()


def _insert_ia_cs_(doc: et._ElementTree, path: str = None):
    """
    CodingSystem._insert_ia_cs_(document: et._ElementTree, path: str) -> CodingSystem
    inserts the IA coding system contained in document into the database and returns the created entity
    :param doc: the lxml.etree._ElementTree document containing the IA coding system
    :param path: the path from which the file was originally opened
    :return: caastools.common.database.CodingSystem created by the operation
    """

    script_dir = os.path.dirname(os.path.realpath(__file__))
    version = int(doc.getroot().find(IaNodes.CODING_SYSTEM)
                  .find(IaProperties.CODING_SYSTEM_ID).text)
    if version < 153:
        raise ValueError("Unable to insert coding system because version {0}".format(version) +
                         " is not compatible. Coding system must be UCHAT version 153 (3.4) or later")

    transform = et.XSLT(et.parse(os.path.join(script_dir, '..', 'parsing', CS_XFORM)))
    document = transform(doc)
    root = document.getroot()

    property_nodes = root.findall(IaNodes.PROPERTY)
    global_nodes = root.findall(IaNodes.GLOBAL_PROPERTY)
    system_name = root.get(IaProperties.SYSTEM_NAME)

    # Need to insert the CodingSystem entity first to ensure ref integrity
    if path is None:
        coding_system_entity, is_new = CodingSystem.get_or_create(cs_name=system_name,
                                                                  source_id=int(root.get(IaProperties.CODING_SYSTEM_ID)))
    else:
        coding_system_entity, is_new = CodingSystem.get_or_create(cs_name=system_name, cs_path=path,
                                                                  source_id=int(root.get(IaProperties.CODING_SYSTEM_ID)))

    rows_inserted = 1

    if is_new:
        # Once the CS entity is inserted, can begin to insert property nodes and their associated values
        # Create a list of dictionaries for bulk insertion
        pv_data = []
        for node in property_nodes:
            cp_entity = CodingProperty.create(coding_system=coding_system_entity,
                                              cp_name=node.get(IaProperties.PROPERTY_NAME),
                                              cp_display_name=node.get(IaProperties.DISPLAY_NAME),
                                              cp_abbreviation=node.get(IaProperties.ABBREVIATION),
                                              cp_sort_order=node.get(IaProperties.SORT_ORDER),
                                              cp_data_type=node.get(IaProperties.PROPERTY_TYPE),
                                              cp_decimal_digits=node.get(IaProperties.DECIMAL_DIGITS),
                                              cp_zero_pad=node.get(IaProperties.ZERO_PAD),
                                              cp_description=node.get(IaProperties.DESCRIPTION),
                                              source_id=node.get(IaProperties.PROPERTY_ID))
            rows_inserted += 1

            # After the CodingProperty is inserted, can insert the associated PropertyValue entities
            pv_nodes = node.iterfind("./PropertyValue[@PropertyID = '{0}']".format(cp_entity.source_id))
            pv_data.extend(__ia_pv_map_func__(node, cp_entity) for node in pv_nodes)

        if len(pv_data) > 0:
            PropertyValue.bulk_insert(pv_data)

        # Now Global entities can be inserted
        gv_data = []
        for node in global_nodes:
            gp_entity = GlobalProperty.create(coding_system=coding_system_entity,
                                              gp_name=node.get(IaProperties.PROPERTY_NAME),
                                              gp_description=node.get(IaProperties.DESCRIPTION),
                                              source_id=node.get(IaProperties.PROPERTY_ID))

            rows_inserted += 1

            gv_data.extend(__ia_gv_map_func__(gvn, gp_entity) for gvn in node.iterfind(IaNodes.PROPERTY_VALUE))

        if len(gv_data) > 0:
            rows_inserted += GlobalValue.bulk_insert(gv_data)

    return CodingSystem.select(CodingSystem, CodingProperty, PropertyValue, GlobalProperty, GlobalValue) \
                       .join(CodingProperty, JOIN.LEFT_OUTER) \
                       .join(PropertyValue, JOIN.LEFT_OUTER) \
                       .switch(CodingSystem) \
                       .join(GlobalProperty, JOIN.LEFT_OUTER) \
                       .join(GlobalValue, JOIN.LEFT_OUTER) \
                       .where(CodingSystem.coding_system_id == coding_system_entity.coding_system_id).get()


@db.atomic()
def upload_coding_system(coding_system_type, file_path=None, file_obj=None):
    """
    upload_coding_system(coding_system_type: CodingSytemType, file_path:str = None, file_obj: str = None)
    performs an atomic insertion of the entire coding system and associated CodingProperty/PropertyValues
    either located at file_path or stored in file_obj and returns the resulting entity.
    If both file_path and file_obj are specified, only the data stored in file_obj will be used
    :param coding_system_type: CodingSystemType instance specifying whether a CACTI or IA coding system is being imported
    :param file_path: The path to the XML file containing the coding system data. Optional (Default None)
    :param file_obj: an io.StringIO object containing XML of the coding system. Optional (Default None)
    :raise ValueError: if neither file_path nor file_obj are specified
    """

    if file_obj is not None:
        document = et.parse(file_obj)
    elif file_path is not None:
        document = et.parse(file_path)
    else:
        raise ValueError("Must provide an argument to either file_path or file_obj")

    CACTI_SCHEMA = 'cacti_schema.xsd'
    script_dir = os.path.dirname(os.path.realpath(__file__))
    cacti_path = os.path.join(os.path.join(script_dir, '..', 'parsing', CACTI_SCHEMA))

    # First step is to parse the xml at the path specified

    # Once the xml has been parsed, it's important to validate it to ensure that the coding system
    # actually matches the DatasetType specified when the class was initialized,
    # Otherwise all of the relationships will fail in the database
    # If we are creating an IA dataset, the schema is stored internally.
    # For CACTI datasets, the we have created a schema against which to validate
    if coding_system_type == CodingSystemType.CACTI:
        schema = et.XMLSchema(et.parse(cacti_path))
        insert_method = _insert_cacti_cs_
    elif coding_system_type == CodingSystemType.IA:
        schema = extract_schema(document)
        document = extract_data(document)
        insert_method = _insert_ia_cs_
    else:
        raise ValueError("Parameter cs_type must be instance of CodingSystemType")
    schema.assertValid(document)
    cs_entity = insert_method(document, file_path)

    # Return the inserted model instance
    return cs_entity


@db.atomic()
def upload_cacti_interview(interview_name, study_id, rater_id, client_id, therapist_id,
                           language_id, condition_id, cacti_name, codes_name,
                           components_name, path_to_casaa, path_to_globals=None,
                           path_to_components=None, path_to_self_explore=None):
    """
    upload_cacti_interview(interview_name: str, study_id: int, rater_id: int, client_id: int,
                           therapist_id: int, language_id: int, condition_id: int, path_to_casaa: str,
                           path_to_globals: str=None, path_to_components: str=None,
                           path_to_self_explore: str=None) -> Interview
    Performs an atomic insertion of all the data collected for a CACTI interview
    :param interview_name: The name of the interview
    :param study_id: The ID of the study to which the interview belongs
    :param rater_id: The ID of the rater scoring the interview
    :param client_id: The ID of the client participating in the interview
    :param therapist_id: The ID of the therapist performing the interview
    :param language_id: The language in which the interview was conducted
    :param condition_id: the Treatment arm of the interview
    :param cacti_name: The name of the CACTI coding system used to score the interview
    :param codes_name: The name of the element in the CACTI xml containing code data
    :param components_name: THe name of elements in the CACTI xml containing component data
    :param path_to_casaa: Path to the casaa file containing utterance-level codes
    :param path_to_globals: Path to the .global file containing globals
    :param path_to_components: path to the .parse file containing components
    :param path_to_self_explore: path to the .global file containing SelfExplore globals
    :return database.Interview: The constructed Interview object
    """

    # Insertion of the various data from the interview into the tables is going to require
    # many lookups from the various tables, so let's fetch some dictionaries
    cs = CodingSystem.get(CodingSystem.cs_name == cacti_name)
    global_lst = []

    property_value_query = PropertyValue.select(PropertyValue.property_value_id,
                                                PropertyValue.pv_value,
                                                CodingProperty.cp_name) \
        .join(CodingProperty) \
        .join(CodingSystem) \
        .where(CodingSystem.cs_name == cacti_name)

    global_value_query = GlobalValue.select(GlobalValue.global_value_id, GlobalValue.gv_value, GlobalProperty.gp_name) \
        .join(GlobalProperty) \
        .join(CodingSystem) \
        #.where(CodingSystem.cs_name == cacti_name)

    # These dictionaries are necessary b/c we need to be able to look up PropertyValueID
    # and GlobalValueID for relational integrity
    # based on information stored in the CACTI text files (i.e. name of the property and value of the PropertyValue)
    pv_dict = {(row[2], row[1]): row[0] for row in property_value_query.tuples().execute()}
    gv_dict = {(row[2], row[1]): row[0] for row in global_value_query.tuples().execute()}

    interview, is_new = Interview.get_or_create(interview_name=interview_name, coding_system=cs,
                                                study_id=study_id, client_id=client_id,
                                                rater_id=rater_id, therapist_id=therapist_id,
                                                language_id=language_id, treatment_condition_id=condition_id)

    if is_new:
        # The first step is to insert the utterances into the data
        casaa_data = read_casaa(path_to_casaa)
        comp_data = read_casaa(path_to_components) if path_to_components is not None else None

        utt_rows = [{Utterance.interview.name: interview,
                     Utterance.utt_enum.name: row[0],
                     Utterance.utt_start_time.name: row[1],
                     Utterance.utt_end_time.name: row[2]} for row in casaa_data]

        # Slow to insert the rows one by one, so do a bulk insert, and query for the inserted data
        # Need a dict mapping enumeration to utterance_id in order to properly insert utterance-level data
        Utterance.bulk_insert(utt_rows)
        utt_dict = {tpl[0]: tpl[1] for tpl in Utterance.select(Utterance.utt_enum, Utterance.utterance_id)
                    .where(Utterance.interview == interview).tuples().execute()}

        # Once the utterance-level data is inserted, can then insert the UtteranceCode data
        code_data = [{UtteranceCode.utterance.name: utt_dict.get(row[0]),
                      UtteranceCode.property_value.name: pv_dict.get((codes_name, row[4])),
                      UtteranceCode.source_id.name: int(row[3])} for row in casaa_data
                     if len(row) > 3 and row[3].strip() != '']

        UtteranceCode.bulk_insert(code_data)

        # Need to do another bulk insert for the components
        if comp_data is not None:
            comp_rows = [{UtteranceCode.utterance_id.name: utt_dict.get(row[0]),
                          UtteranceCode.property_value_id.name: pv_dict[(components_name, row[3])]} for row in
                         comp_data if len(row) > 3 and row[3].strip() != '']
            UtteranceCode.bulk_insert(comp_rows)

        # Finally, can perform an insert on the globals
        if path_to_globals is not None:
            global_lst.extend(read_globals(path_to_globals, (THERAPIST_GLOBALS_SLICE, CLIENT_GLOBALS_SLICE)))

        if path_to_self_explore is not None:
            global_lst.extend(read_globals(path_to_self_explore, (SE_GLOBALS_SLICE,)))

        if len(global_lst) > 0:
            global_rows = [{GlobalRating.interview.name: interview,
                            GlobalRating.global_value.name: gv_dict[tpl]} for tpl in global_lst]

            GlobalRating.bulk_insert(global_rows)

    return interview


@db.atomic()
def upload_ia_interview(interview_name, study_id, rater_id, client_id, therapist_id,
                        condition_id, *interview_files):
    """
    upload_ia_interview(interview_name, study_id, rater_id, client_id, therapist_id,
                        language_id, condition_id, interview_folder) -> Interview
    Performs an atomic insertion of the interview data contained in interview_folder and returns the resulting entity
    :param interview_name: The name of the interview
    :param study_id: the ID of the study to which the interview belogns
    :param rater_id: the ID of the rater scoring the interviwe
    :param client_id: the ID of the client participating in the interview
    :param therapist_id: the ID of the therapist performing the interview
    :param condition_id: The treatment arm of the interview
    :param *interview_files: Sorted sequence of paths to files containing interview data.
    Note that this sequence of interview files must sorted in ascending order for fragmented interviews
    """

    document = reconstruct_ia(interview_name, interview_files, parser=None)
    cs_id = int(document.xpath("/NewDataSet/{0}/{1}".format(IaNodes.CODING_SETS,
                                                            IaProperties.CODING_SYSTEM_ID))[0].text)
    cs_name = document.xpath("/NewDataSet/{0}/{1}".format(IaNodes.CODING_SETS,
                                                          IaProperties.CODING_SYSTEM_NAME))[0].text

    rows_inserted = 0

    # Need a dictionary mapping source_id to property_value_id, which will allow insertion of UtteranceCode entities
    pv_dict = {row[0]: row[1] for row in PropertyValue.select(PropertyValue.source_id, PropertyValue.property_value_id)
        .join(CodingProperty)
        .join(CodingSystem)
        .where(CodingSystem.source_id == cs_id)
        .tuples().execute()}
    gv_dict = {row[0]: row[1] for row in GlobalValue.select(GlobalValue.source_id, GlobalValue.global_value_id)
        .join(GlobalProperty)
        .join(CodingSystem)
        .where(CodingSystem.source_id == cs_id)
        .tuples().execute()}

    root = document.getroot()  # type: et._Element

    # Need to get the coding system associated with the interview
    cs_entity = CodingSystem.get(CodingSystem.source_id == cs_id)
    if cs_entity is None:
        raise RecordNotFoundException("CodingSystem.source_id == {0}".format(cs_id))

    iv, is_new = Interview.get_or_create(interview_name=interview_name, coding_system=cs_entity, study_id=study_id,
                                         client_id=client_id, rater_id=rater_id, therapist_id=therapist_id,
                                         treatment_condition_id=condition_id)
    rows_inserted += 1

    if is_new:
        # Once the interview has been inserted, the utterances can be inserted next
        # start by gathering up all the utterance data to perform a bulk insertion
        utt_nodes = root.iterfind(IaNodes.UTTERANCES)
        utt_rows = [{Utterance.interview.name: iv,
                     Utterance.source_id.name: int(node.find(IaProperties.UTTERANCE_ID).text),
                     Utterance.utt_line: int(node.find(IaProperties.LINE_NO).text),
                     Utterance.utt_enum: int(node.find(IaProperties.UTT_NUMBER).text),
                     Utterance.utt_role: node.find(IaProperties.SPEAKER_ROLE).text,
                     Utterance.utt_text: node.find(IaProperties.TEXT).text,
                     Utterance.utt_word_count: int(node.find(IaProperties.WORD_COUNT).text),
                     Utterance.utt_start_time: float(node.find(IaProperties.START_TIME).text)}
                    for node in utt_nodes]

        rows_inserted += Utterance.bulk_insert(utt_rows)

        # Once the utterances have been inserted, need to query for them
        # in order to properly insert UtteranceProperty entities
        utt_dict = {row[0]: row[1] for row in Utterance.select(Utterance.source_id, Utterance.utterance_id)
            .where(Utterance.interview == iv).tuples().execute()}

        # With the dictionary of utterances mapping source_id to utterance_id in hand,
        # can use to insert UtteranceCode entities
        up_nodes = root.iterfind(IaNodes.UTT_PROPERTIES)
        up_rows = [{UtteranceCode.utterance.name: utt_dict[int(node.find(IaProperties.UTTERANCE_ID).text)],
                    UtteranceCode.property_value.name: pv_dict[
                        int(node.find(IaProperties.PROP_VALUE_ID).text)]}
                   for node in up_nodes]

        rows_inserted += UtteranceCode.bulk_insert(up_rows)

        # Finally, the global ratings can be inserted
        global_nodes = root.iterfind(IaNodes.GLOBALS)
        gv_rows = [{GlobalRating.global_value.name: gv_dict[int(node.find(IaProperties.PROP_VALUE_ID).text)],
                    GlobalRating.interview.name: iv}
                   for node in global_nodes]

        rows_inserted += GlobalRating.bulk_insert(gv_rows)

    return iv


def __cacti_gp_map_func__(node, cp_entity):
    return {GlobalProperty.gp_name.name: node.get(CactiAttributes.NAME),
            GlobalProperty.gp_description.name: node.get(
            CactiAttributes.DESCRIPTION),
            GlobalProperty.coding_system.name: cp_entity,
            GlobalProperty.source_id.name: node.get(CactiAttributes.VALUE),
            GlobalProperty.gp_data_type.name: 'numeric'}


def __cacti_pv_map_func__(node, pv_tag, cp_entity):
    return {PropertyValue.coding_property.name: cp_entity,
            PropertyValue.pv_value.name: node.get(CactiAttributes.NAME if pv_tag == CactiNodes.CODE
                                                  else CactiAttributes.VALUE),
            PropertyValue.source_id.name: node.get(CactiAttributes.VALUE) if pv_tag == CactiNodes.CODE
            else None,
            PropertyValue.pv_description.name: node.get(CactiAttributes.DESCRIPTION),
            PropertyValue.pv_summary_mode.name: node.get(CactiAttributes.SUM_MODE)}


def __ia_gp_map_func__(node, cp_entity):
    return {GlobalProperty.gp_name.name: node.get(IaProperties.PROPERTY_NAME),
            GlobalProperty.gp_description.name: node.get(IaProperties.DESCRIPTION),
            GlobalProperty.source_id.name: int(node.get(IaProperties.PROPERTY_ID)),
            GlobalProperty.coding_system.name: cp_entity,
            GlobalProperty.gp_data_type.name: node.get(IaProperties.PROPERTY_TYPE)}


def __ia_gv_map_func__(node, gp_entity):
    return {GlobalValue.global_property.name: gp_entity,
            GlobalValue.source_id.name: int(node.get(IaProperties.PROP_VALUE_ID)),
            GlobalValue.gv_value.name: node.get(IaProperties.VALUE),
            GlobalValue.gv_description.name: node.get(IaProperties.DESCRIPTION)}


def __ia_pv_map_func__(node, cp_entity):
    return {PropertyValue.coding_property.name: cp_entity,
            PropertyValue.pv_value.name: node.get(IaProperties.VALUE),
            PropertyValue.pv_description.name: node.get(IaProperties.DESCRIPTION),
            PropertyValue.source_id.name: int(node.get(IaProperties.PROP_VALUE_ID))}
