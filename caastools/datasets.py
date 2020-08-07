from .database import CodingSystem, CodingProperty, GlobalProperty, GlobalRating, GlobalValue, Interview, \
    PropertyValue,  Utterance, UtteranceCode
from peewee import Case, Cast, fn, JOIN
from .utils import sanitize_for_spss
from savReaderWriter.savWriter import SavWriter
import logging
import pandas
import pandas.api.types as ptypes
import numpy

logging.getLogger('caastools.dataset').addHandler(logging.NullHandler())
__all__ = ['sequential', 'session_level', 'create_sl_variable_labels', 'save_as_spss']


def sequential(*included_interviews, included_properties=None):
    """

    :param included_interviews: sequence of
    :param included_properties:
    :return:
    """
    included_properties = sorted(set(included_properties))
    property_ctes = []
    display_names = []
    property_query = UtteranceCode.select(UtteranceCode.utterance_id, PropertyValue.pv_value) \
        .join(PropertyValue)

    # The dataset construction needs to be atomic to avoid race conditions
    with UtteranceCode._meta.database.atomic() as transaction:

        # Having the display name will be required for giving columns useful names, so fetch them
        cp_dict = {itm[0]: itm[1] for itm in
                   CodingProperty.select(CodingProperty.coding_property_id, CodingProperty.cp_display_name)
                                 .where(CodingProperty.coding_property_id.in_(included_properties))
                                 .tuples().execute()}

        # Need a CTE for each property whose data is to be included, so construct queries and convert to CTE
        for prop_pk in included_properties:
            cp_display_name = cp_dict.get(prop_pk)
            if cp_display_name is None:
                logging.warning(f"CodingProperty with id of {prop_pk} not found. This data will not be included...")
                continue

            pq = property_query.where(PropertyValue.coding_property_id == prop_pk)
            property_ctes.append(pq.cte(f"cte_{cp_display_name}", columns=['utterance_id', cp_display_name]))
            display_names.append(cp_display_name)

        # The outer query will select the Utterances of the interview.
        # any CTE will match on the Utterannce.utterance_id field and insert the appropriate fields with codes
        # outer query needs to include the fields of the CTE as well, so start there
        basic_query = Interview.select(Interview.interview_name, Interview.client_id, Interview.session_number,
                                       Utterance.utterance_id, Utterance.utt_line, Utterance.utt_enum,
                                       Utterance.utt_role,
                                       *(getattr(cte.c, name) for name, cte in zip(display_names, property_ctes)),
                                       Utterance.utt_text).join(Utterance)

        # Once the basic query is constructed, the joins need to be added into the query
        # so that the fields of the CTE can be queried property
        for name, cte in zip(display_names, property_ctes):
            basic_query = basic_query.join(cte, JOIN.LEFT_OUTER, on=(Utterance.utterance_id == cte.c.utterance_id))

        # Final step of query prepration is to add in the CTE themselves and narrow the results
        basic_query = basic_query.with_cte(*property_ctes)

        basic_query = basic_query.where(Interview.interview_name.in_(included_interviews))\
            .order_by(Interview.client_id, Interview.session_number)

        results = basic_query.tuples().execute()
        columns = [itm[0] for itm in results.cursor.description]
        df = pandas.DataFrame(data=results, columns=columns)

    return df


def session_level(coding_system, included_interviews=None, included_properties=None, included_globals=None, client_as_numeric=True):
    """
    session_level(interview_names) -> pandas.DataFrame
    Builds a session-level DataFrame with counts for interviews named in interview_names
    :param coding_system: Coding
    :param included_interviews: iterable of Interview.interview_names to be included in the Dataset
    :param included_properties: iterable of CodingProperty.coding_property_id to be included
    :param included_globals: iterable of GlobalProperty.global_property_id to be included
    :param client_as_numeric: Whether to cast client_id as a numeric variable. Default True
    :return: pandas.DataFrame
    """

    # may want the client_id cast as numeric
    client_column = Cast(Interview.client_id, "INT").alias('client_id') if client_as_numeric else Interview.client_id
    var_column = CodingProperty.cp_display_name.concat("_").concat(PropertyValue.pv_value).alias('property')

    # May want only certain interviews included or certain properties included,
    # so construct some predicates for where clauses, if necessary
    p1 = Interview.interview_name.in_(included_interviews)
    p2 = CodingProperty.coding_property_id.in_(included_properties)
    p3 = GlobalProperty.global_property_id.in_(included_globals)

    predicate = ((p1) & (p2)) if included_interviews is not None and included_properties is not None else \
        (p1) if included_interviews is not None else \
        (p2) if included_properties is not None else \
        None

    global_predicate = ((p1) & (p3)) if included_interviews is not None and included_globals is not None else \
        (p1) if included_interviews is not None else \
        (p3) if included_globals is not None else \
        None

    # The most difficult part about building the count data is constructing the query.
    # Construct it by parts to make the job simpler

    # inner_query is the CTE that selects the existing count data. Is later joined with an outer
    inner_query = (UtteranceCode.select(Utterance.interview_id, UtteranceCode.property_value_id,
                                        fn.COUNT(UtteranceCode.property_value_id))
                   .join(Utterance)
                   .group_by(Utterance.interview_id, UtteranceCode.property_value_id))

    # In addition to counts, need to get the globals as well, so construct a query to UNION ALL with
    global_query = (GlobalRating.select(Interview.interview_name, client_column, Interview.rater_id,
                                        Interview.session_number, GlobalProperty.gp_name,
                                        Cast(GlobalValue.gv_value, "INT"))
                    .join(Interview)
                    .switch(GlobalRating)
                    .join(GlobalValue).join(GlobalProperty))

    # Append the predicate, if any was specified
    if global_predicate is not None:
        global_query = global_query.where(global_predicate)

    # The inner query needs to be used as a table expression, so that it can be joined with the outer query
    cte = inner_query.cte('cte', columns=('interview_id', 'pvid', 'cnt'))

    # We want to enter zero when the result of the join is NULL
    # (Null indicates that a count for a PropertyValue was zero
    # because there is no related record in the UtteranceCode table having the specified PropertyValue)
    case = Case(None, ((cte.c.cnt.is_null(), 0),), (cte.c.cnt))
    outer_query = (Interview
                   .select(Interview.interview_name, client_column, Interview.rater_id, Interview.session_number,
                           var_column, case.alias('var_count'))
                   .join(CodingSystem)
                   .join(CodingProperty)
                   .join(PropertyValue))

    # Perform the joins on the CTE and do the union all for the final query
    full_query = (outer_query.join(cte, JOIN.LEFT_OUTER, on=((PropertyValue.property_value_id == cte.c.pvid)
                                                             & (Interview.interview_id == cte.c.interview_id)))
                  .with_cte(cte))
    if predicate is not None:
        full_query = full_query.where(predicate)

    full_query = (full_query.union_all(global_query)
                  .order_by(client_column, Interview.session_number, Interview.rater_id, var_column))

    # pull the query results into a dataframe, then reshape it
    # Some DBMS lack the pivot function so reshaping the DataFrame itself rather than the query is necessary
    df = pandas.DataFrame.from_records(data=full_query.tuples().execute(),
                                       columns=['interview_name', 'client_id', 'rater_id', 'session_number', 'var_name',
                                                'var_value'])

    df = df.set_index(['interview_name', 'client_id', 'rater_id', 'session_number', 'var_name']).unstack(
        'var_name').loc[:, 'var_value'].reset_index()
    return df


def create_sequential_variable_labels(coding_system_id, find, replace):
    """
    datasets.create_sequential_variable_labels(coding_system_id, find, replace) -> dict
    Creates a dictionary of variable labels suitable for building an SPSS sequential dataset
    :param coding_system_id: the ID of the coding system for which to create labels
    :param find: sequence of strings to be replaced in the variable names
    :param replace: sequence of strings with which to replace corresponding entries in find. May also be a
    callable which determines the appropriate replacement values
    :return: dict
    """

    cp_query = (CodingProperty.select(CodingProperty.cp_name, CodingProperty.cp_description)
                .join(CodingSystem)
                .where(CodingSystem.coding_system_id == coding_system_id)
                .order_by(CodingProperty.coding_property_id))

    labels = {sanitize_for_spss(tpl[0], find=find, repl=replace): tpl[1] for tpl in cp_query.tuples().execute()}
    return labels


def create_sl_variable_labels(coding_system_id, find, replace):
    """
    datasets.create_variable_labels(coding_system_id) -> dict
    creates a dictionary of variable labels suitable for building an SPSS session-level dataset
    :param coding_system_id: the coding system for which to create variable labels
    :param find: sequence of strings to be replaced in the variable names
    :param replace: sequence of strings with which to replace corresponding entries in find. May also be a
    function which determines the appropriate replacement characters
    :return: dict
    """

    # In the SL dataset, each PropertyValue and each GlobalProperty become its own variable,
    # so need to query those tables for the right entities
    GpParent = GlobalProperty.alias()
    gp_query = (GlobalProperty.select(GlobalProperty, GpParent)
                .join(GpParent, JOIN.LEFT_OUTER)
                .where(GlobalProperty.coding_system == coding_system_id))

    Parent = PropertyValue.alias()  # type: PropertyValue
    pv_query = (PropertyValue.select(PropertyValue, CodingProperty, Parent)
                .join(Parent, JOIN.LEFT_OUTER)
                .switch(PropertyValue)
                .join(CodingProperty)
                .join(CodingSystem)
                .where(CodingSystem.coding_system == coding_system_id)
                .order_by(CodingProperty.coding_property_id, PropertyValue.pv_parent,
                          PropertyValue.property_value_id))

    property_values = pv_query.execute()

    global_properties = gp_query.execute()

    sl_labels = {sanitize_for_spss(f"{pv.coding_property.cp_name}_{pv.pv_value}", find=find, repl=replace):
                 pv.pv_description for pv in property_values}
    sl_labels.update({sanitize_for_spss(gp.gp_name): gp.gp_description for gp in global_properties})

    return sl_labels


def save_as_spss(data_frame: pandas.DataFrame, out_path: str, labels: dict = None, find=None, repl=None) -> None:
    """
    caastools.utils.save_as_spss(data_frame: pandas.DataFrame, out_path: str) -> None
    saves data_frame as an SPSS dataset at out_path
    :param data_frame: the pandas DataFrame to save
    :param out_path: the path at which to save the file
    :param labels: a dictionary mapping column labels in the data frame to a variable label in the SPSS dataset
    :param find: a sequence of characters within variable names to be replaced with other values. Default None
    :param repl: a sequence of characters with which to replace corresponding entries in find, or a function
    which yields their replacements. Default None
    :return: None
    :raise ValueError: if either find/repl is None and the other is not
    :raise ValueError: if find and repl are sequences of unequal length
    """

    cols = data_frame.columns  # type: pandas.Index
    is_multi_index = isinstance(cols, pandas.MultiIndex)
    var_names = []
    var_types = {}
    var_formats = {}
    var_labels = {} if labels is None else labels

    # Construct the various information that the SPSS dictionary will contain about each variable
    for col in cols:
        var_name = sanitize_for_spss(".".join(str(i) for i in col) if is_multi_index else str(col),
                                     find=find, repl=repl)
        var_names.append(var_name)

        # Need to know the data type and format of each column so that the SPSS file can be written properly
        # 0 is a numeric type, any positive integer is a string type where the number represents the number
        # of bytes the string can hold.
        if pandas.api.types.is_string_dtype(data_frame[col]):
            lens = list(filter(lambda x: pandas.notna(x) and x is not None, set(data_frame[col].str.len())))
            var_types[var_name] = int(max(lens)) * 2 if len(lens) > 0 else 255
        else:
            var_types[var_name] = 0
            var_formats[var_name] = "F10.2" if ptypes.is_float(data_frame[col].dtype) else \
                "ADATE8" if ptypes.is_datetime64_any_dtype(data_frame[col]) else \
                "F12.0"

    # Sometimes savReaderWriter has trouble writing a whole dataframe in at once,
    # Writing row by row seems to work without issue
    with SavWriter(out_path, var_names, var_types, formats=var_formats, varLabels=var_labels, ioUtf8=True) as writer:
        for row in data_frame.index:
            writer.writerow(data_frame.loc[row, :].values)


def _get_global_data_(interviews):

    return GlobalRating.select(Interview.interview_name, Interview.study_id, Interview.rater_id,
                                 Interview.client_id, Interview.therapist_id, Interview.language_id,
                                 Interview.treatment_condition_id,
                                 GlobalProperty.gp_name, GlobalProperty.gp_data_type,
                                 GlobalValue.gv_value)\
                         .join(Interview)\
                         .switch(GlobalRating)\
                         .join(GlobalValue)\
                         .join(GlobalProperty)\
                         .where(Interview.interview_name.in_(interviews)).dicts().execute()


def _get_utterance_code_data_(interviews):

    return UtteranceCode.select(Interview.interview_name, Interview.study_id, Interview.rater_id,
                                  Interview.client_id, Interview.session_number, Interview.therapist_id,
                                  Interview.language_id, Interview.treatment_condition_id, Utterance.utt_line,
                                  Utterance.utt_enum, Utterance.utt_start_time, Utterance.utt_end_time,
                                  CodingProperty.cp_name, CodingProperty.cp_data_type,
                                  PropertyValue.pv_value, Utterance.utt_text, Utterance.utt_word_count) \
                            .join(Utterance) \
                            .join(Interview) \
                            .switch(UtteranceCode) \
                            .join(PropertyValue) \
                            .join(CodingProperty) \
                            .join(CodingSystem)\
                            .where(Interview.interview_name.in_(interviews))\
                            .dicts().execute()


def _get_parsing_data_(interviews):

    return (Utterance.select(Interview.interview_name, Interview.study_id, Interview.rater_id,
                               Interview.client_id, Interview.session_number, Interview.therapist_id,
                               Interview.language_id, Interview.treatment_condition_id, Utterance.utt_line,
                               Utterance.utt_enum, Utterance.utt_start_time, Utterance.utt_end_time,
                               Utterance.utt_text, Utterance.utt_word_count)
            .join(Interview)
            .where(Interview.interview_name.in_(interviews))).dicts().execute()
