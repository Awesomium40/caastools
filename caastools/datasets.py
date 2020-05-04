from .database import models as m
from peewee import JOIN
from .utils import sanitize_for_spss
from savReaderWriter.savWriter import SavWriter
import pandas
import pandas.api.types as ptypes
import numpy

__all__ = ['build_sequential_dataframe', 'build_session_level_dataframe', 'create_sl_variable_labels', 'save_as_spss']


def build_sequential_dataframe(interview_names):
    """
    build_sequential_dataframe(interviews) -> pandas.DataFrame
    Builds a pandas DataFrame from the interviews specified
    :param interview_names: sequence of interviews to be included in the output
    :return: pandas.DataFrame
    """

    # This will yield all the utterance-level data for the interviews specified
    utterance_data = _get_utterance_data_(interview_names)
    columns = [itm[0] for itm in utterance_data.cursor.description]

    df = pandas.DataFrame.from_records(index=['interview_name', 'utt_enum'], data=utterance_data, columns=columns)

    # Straight out of the database, all the codes, regardless of property are in the same column,
    # Which is not desirable. Pull out the codes so they can be pivoted such that each CodingProperty
    # has its own column
    codes = df[['cp_name', 'pv_value']]
    types = df[['cp_name', 'cp_data_type']].reset_index(drop=True)

    # Prepare the DataFrame to receive code data - When the pivoting of codes occurs, there will be duplicate rows,
    # which need to be removed. This op will take care of that
    df = df.drop(labels=['cp_name', 'pv_value', 'cp_data_type'], axis=1)\
           .reset_index()\
           .drop_duplicates(subset=('interview_name', 'utt_enum'))\
           .set_index(['interview_name', 'utt_enum'], drop=False)

    # Some columns will need to be converted to a numeric type, based on the cp_data_type field values
    # retrieve the names of columns that need to be converted
    mask = (types['cp_data_type'] == 'numeric')
    numeric_cols = set(types.loc[mask, 'cp_name'])

    # Because the frame needs to be multi-indexed on interview_name and utterance_number, and because this
    # indexing needs to be destroyed as part of the pivot, need to create a new index to apply after the pivot happens
    idx_names = list(codes.index.names)
    codes.reset_index(inplace=True)
    idx_values = codes[idx_names].values
    tuples_index = [tuple(i) for i in idx_values]
    new_index = pandas.MultiIndex.from_tuples(sorted(set(tuples_index), key=lambda x: tuples_index.index(x)),
                                              names=idx_names)

    # this will actually perform the pivot and apply the new index
    pivot = codes.assign(tuples_index=tuples_index).pivot(index='tuples_index', columns='cp_name', values='pv_value')
    pivot.index = new_index

    # Finally, recombine the result of the pivot with the descriptive information to yield a complete dataframe
    df = df.join(pivot).drop(labels=['interview_name', 'utt_enum'], axis=1).applymap(lambda x: x if x is not None
                                                                                     else numpy.NaN)
    for col in numeric_cols:
        df[col] = pandas.to_numeric(df[col])

    return df


def build_session_level_dataframe(interview_names):
    """
    datasets.build_session_level_dataframe(interviews) -> pandas.DataFrame
    Constructs a session_level dataframe containing count/global scoring data for each interview in interviews
    :param interview_names: Sequence of interview names by which to query
    :return: pandas.DataFrame
    """

    utterance_data = _get_utterance_data_(interview_names)
    columns = [itm[0] for itm in utterance_data.cursor.description]
    df = pandas.DataFrame.from_records(data=utterance_data, columns=columns)
    agg = df[['interview_name', 'cp_name', 'pv_value']]
    descriptives = df[['interview_name', 'study_id', 'rater_id', 'client_id', 'therapist_id', 'language_id',
                       'treatment_condition_id']].drop_duplicates(subset=['interview_name'])\
        .set_index(['interview_name'])

    agg = agg.assign(property_value=agg['cp_name'] + "_" + agg['pv_value'])
    agg = agg.pivot_table(index='interview_name', columns='property_value', values='pv_value',
                          aggfunc=pandas.Series.count)

    global_data = _get_global_data_(interview_names)
    columns = [itm[0] for itm in global_data.cursor.description]

    global_df = pandas.DataFrame.from_records(data=global_data, columns=columns)
    types = global_df[['gp_name', 'gp_data_type']].reset_index(drop=True)

    # Some columns will need to be converted to a numeric type, based on the cp_data_type field values
    # retrieve the names of columns that need to be converted
    mask = (types['gp_data_type'] == 'numeric')
    numeric_cols = set(types.loc[mask, 'gp_name'])

    pivot = global_df.pivot(index='interview_name', columns='gp_name', values='gv_value').astype(numpy.int_)

    data = descriptives.join([agg, pivot]).fillna(0)
    for col in numeric_cols:
        data[col] = pandas.to_numeric(data[col], downcast='integer')

    return data


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

    cp_query = (m.CodingProperty.select(m.CodingProperty.cp_name, m.CodingProperty.cp_description)
                .join(m.CodingSystem)
                .where(m.CodingSystem.coding_system_id == coding_system_id)
                .order_by(m.CodingProperty.coding_property_id))

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
    GpParent = m.GlobalProperty.alias()
    gp_query = (m.GlobalProperty.select(m.GlobalProperty, GpParent)
                .join(GpParent, JOIN.LEFT_OUTER)
                .where(m.GlobalProperty.coding_system == coding_system_id))

    Parent = m.PropertyValue.alias()  # type: m.PropertyValue
    pv_query = (m.PropertyValue.select(m.PropertyValue, m.CodingProperty, Parent)
                .join(Parent, JOIN.LEFT_OUTER)
                .switch(m.PropertyValue)
                .join(m.CodingProperty)
                .join(m.CodingSystem)
                .where(m.CodingSystem.coding_system == coding_system_id)
                .order_by(m.CodingProperty.coding_property_id, m.PropertyValue.pv_parent,
                          m.PropertyValue.property_value_id))

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

    return m.GlobalRating.select(m.Interview.interview_name, m.Interview.study_id, m.Interview.rater_id,
                                 m.Interview.client_id, m.Interview.therapist_id, m.Interview.language_id,
                                 m.Interview.treatment_condition_id,
                                 m.GlobalProperty.gp_name, m.GlobalProperty.gp_data_type,
                                 m.GlobalValue.gv_value)\
                         .join(m.Interview)\
                         .switch(m.GlobalRating)\
                         .join(m.GlobalValue)\
                         .join(m.GlobalProperty)\
                         .where(m.Interview.interview_name.in_(interviews)).dicts().execute()


def _get_utterance_data_(interviews):

    return m.UtteranceCode.select(m.Interview.interview_name, m.Interview.study_id, m.Interview.rater_id,
                                  m.Interview.client_id, m.Interview.session_number, m.Interview.therapist_id,
                                  m.Interview.language_id, m.Interview.treatment_condition_id, m.Utterance.utt_line,
                                  m.Utterance.utt_enum, m.Utterance.utt_start_time, m.Utterance.utt_end_time,
                                  m.CodingProperty.cp_name, m.CodingProperty.cp_data_type,
                                  m.PropertyValue.pv_value, m.Utterance.utt_text) \
                            .join(m.Utterance) \
                            .join(m.Interview) \
                            .switch(m.UtteranceCode) \
                            .join(m.PropertyValue) \
                            .join(m.CodingProperty) \
                            .join(m.CodingSystem)\
                            .where(m.Interview.interview_name.in_(interviews))\
                            .dicts().execute()
