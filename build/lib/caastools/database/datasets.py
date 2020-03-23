from .database import models as m
import numpy
import pandas

__all__ = ['build_sequential_dataframe']


def build_sequential_dataframe(interviews):
    """
    build_dataframe(interviews) -> pandas.DataFrame
    Builds a pandas DataFrame from the interviews specified
    :param interviews: sequence of interviews to be included in the output
    :param system_names: sequence of CodingSystem names
    :return: pandas.DataFrame
    """

    # This will yield all the utterance-level data for the interviews specified
    utterance_data = _get_utterance_data_(interviews)
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
    df = df.join(pivot).drop(labels=['interview_name', 'utt_enum'], axis=1)
    for col in numeric_cols:
        df[col] = pandas.to_numeric(df[col])

    return df


def build_session_level_dataframe(interviews):

    utterance_data = _get_utterance_data_(interviews)
    columns = [itm[0] for itm in utterance_data.cursor.description]
    df = pandas.DataFrame.from_records(data=utterance_data, columns=columns)
    agg = df[['interview_name', 'cp_name', 'pv_value']]
    agg = agg.assign(property_value=agg['cp_name'] + "_" + agg['pv_value'])
    agg = agg.pivot_table(index='interview_name', columns='property_value', values='pv_value',
                          aggfunc=pandas.Series.count)

    global_data = _get_global_data_(interviews)
    columns = [itm[0] for itm in global_data.cursor.description]

    global_df = pandas.DataFrame.from_records(data=global_data, columns=columns)
    types = global_df[['gp_name', 'gp_data_type']].reset_index(drop=True)

    # Some columns will need to be converted to a numeric type, based on the cp_data_type field values
    # retrieve the names of columns that need to be converted
    mask = (types['gp_data_type'] == 'numeric')
    numeric_cols = set(types.loc[mask, 'gp_name'])

    pivot = global_df.pivot(index='interview_name', columns='gp_name', values='gv_value')

    data = agg.join(pivot).fillna(0)
    for col in numeric_cols:
        data[col] = pandas.to_numeric(data[col])

    return data


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
                                  m.Interview.client_id, m.Interview.therapist_id, m.Interview.language_id,
                                  m.Interview.treatment_condition_id, m.Utterance.utt_enum,
                                  m.CodingProperty.cp_name, m.CodingProperty.cp_data_type,
                                  m.PropertyValue.pv_value) \
                            .join(m.Utterance) \
                            .join(m.Interview) \
                            .switch(m.UtteranceCode) \
                            .join(m.PropertyValue) \
                            .join(m.CodingProperty) \
                            .join(m.CodingSystem)\
                            .where(m.Interview.interview_name.in_(interviews))\
                            .dicts().execute()
