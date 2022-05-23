from .utils import sanitize_for_spss
from caastools.database import get_connection
from pandas import DataFrame, notna
from pandas.api.types import is_string_dtype, is_object_dtype
from savReaderWriter.savWriter import SavWriter
import logging
import pandas
import pandas.api.types as ptypes


logging.getLogger('caastools.dataset').addHandler(logging.NullHandler())
__all__ = ['sequential', 'session_level', 'create_sl_variable_labels', 'save_as_spss']


def quantile_level(quantiles=10, included_interviews=None, client_as_numeric=True, include_reliability=False):
    """
    Constructs a quantile-level dataset

    :param quantiles: Integer specifying number of quantiles into which data is to be divided. Default 10
    :param included_interviews: Sequence of strings specifying interview names to be included in the dataset,
    None to include all interviews. Default None
    :param client_as_numeric: Whether to cast client_id to a numeric type. Default True
    :param include_reliability: Whether to include (False) or exclude (False, default) interviews of type 'reliability'
    :return: DataFrame
    """
    con = get_connection()

    included_types = ['general'] if not include_reliability else ['general', 'reliability']
    args = included_types
    placeholder = '?'

    if included_interviews is not None:
        iv_filter = f"AND rviq.interview_name IN ({','.join(placeholder * len(included_interviews))})"
        args.extend(included_interviews)
    else:
        iv_filter = ''

    client_column = 'CAST(iv.client_id AS INTEGER)' if client_as_numeric else 'iv.client_id'

    query = f"""
    WITH quantile_lens(interview_id, start_time, end_time, quantile_len) AS (
        SELECT utterance.interview_id, MIN(utterance.start_time), MAX(utterance.end_time), 
            (MAX(utterance.end_time) - MIN(Utterance.start_time)) / {quantiles}
        FROM UTTERANCE
        GROUP BY utterance.interview_id
    ),
    utt_quantiles(interview_id, utterance_id, quantile) AS (
        SELECT u.interview_id, u.utterance_id, CAST ((u.start_time - ql.start_time) / ql.quantile_len + 1 AS INTEGER)
        FROM utterance u
        LEFT OUTER JOIN quantile_lens ql ON u.interview_id = ql.interview_id
    ),
    quantile_counts(interview_id, quantile, property_value_id, cnt) AS (
        SELECT u.interview_id, q.quantile, uc.property_value_id, COUNT(uc.utterance_code_id)
        FROM utterance_code uc
        INNER JOIN utterance u ON uc.utterance_id = u.utterance_id
        LEFT OUTER JOIN utt_quantiles q ON uc.utterance_id = q.utterance_id
        GROUP BY u.interview_id, q.quantile, uc.property_value_id
    ),
    rivq(interview_id, interview_type, property_value_id, interview_name, 
           client_id, rater_id, session_number, quantile, property) AS (
        SELECT iv.interview_id, iv.interview_type, pv.property_value_id, iv.interview_name, {client_column}, 
            iv.rater_id, iv.session_number, {quantiles} AS "quantile", pv.variable_name
        FROM interview iv
        INNER JOIN coding_system cs ON iv.coding_system_id = cs.coding_system_id
        INNER JOIN coding_property cp ON cs.coding_system_id = cp.coding_system_id
        INNER JOIN property_value pv ON cp.coding_property_id = pv.coding_property_id
        UNION ALL
        SELECT rivq.interview_id, rivq.interview_type, rivq.property_value_id, rivq.interview_name, rivq.client_id, 
                rivq.rater_id, rivq.session_number, rivq.quantile - 1 AS "quantile", rivq.property
        FROM rivq
        WHERE quantile > 1
    )
    SELECT rivq.interview_id, rivq.interview_type, rivq.property_value_id, rivq.interview_name, rivq.client_id, 
            rivq.rater_id, rivq.session_number, rivq.quantile, rivq.property AS "var_name", 
            CASE WHEN quantile_counts.cnt IS NULL THEN 0 ELSE quantile_counts.cnt END AS "var_count"
    FROM rivq
    LEFT OUTER JOIN quantile_counts ON rivq.property_value_id = quantile_counts.property_value_id
        AND rivq.interview_id = quantile_counts.interview_id
        AND rivq.quantile = quantile_counts.quantile
    WHERE rivq.interview_type IN ({','.join(placeholder * len(included_types))}) {iv_filter}
    ORDER BY rivq.client_id, rivq.session_number, rivq.rater_id, rivq.property, rivq.quantile 
    """

    # Global ratings don't have values by quantile,
    # so that query will need to be handled separately and incorporated after the fact
    global_query = f"""
    SELECT gr.interview_id, gp.variable_name, gp.data_type, gv.value
    FROM global_rating gr
    INNER JOIN global_value gv ON gr.global_value_id = gv.global_value_id
    INNER JOIN global_property gp ON gv.global_property_id = gp.global_property_id
    INNER JOIN interview iv ON gr.interview_id = iv.interview_id
    WHERE iv.interview_type IN ({','.join(placeholder * len(included_types))}) {iv_filter}
    ORDER BY iv.client_id, iv.session_number, iv.rater_id, gp.variable_name
    """

    q_csr = con.execute(query, args)
    g_csr = con.execute(global_query, args)

    df = pandas.DataFrame.from_records(q_csr, columns=[itm[0].lower() for itm in q_csr.description])
    gdf = pandas.DataFrame.from_records(g_csr, columns=[itm[0].lower() for itm in g_csr.description])

    # Reshape the count data to be a cross-section
    counts = (
        df
        .loc[:, ['interview_id', 'var_name', 'quantile', 'var_count']]
        .set_index(['interview_id', 'var_name', 'quantile'])
        .unstack(['var_name', 'quantile'])
    )

    counts.columns = [f"{c[1]}_Q{c[2]}" for c in counts.columns]

    meta = (
        df
        .loc[:, ['interview_id', 'interview_name', 'interview_type', 'client_id', 'rater_id', 'session_number']]
        .drop_duplicates()
        .set_index('interview_id')
    )

    # Reshape the global ratings and cast to the appropriate type for each global
    gr = gdf.pivot(index='interview_id', columns='variable_name', values='value')
    global_types = {
        row['variable_name']: float if row['data_type'] == 'numeric' else str
        for idx, row in gdf.iterrows()
    }
    for column, col_type in global_types.items():
        gr[column] = gr[column].astype(col_type)

    # join together all of the data
    data = meta.join(counts).join(gr).reset_index(drop=True)

    return data


def sequential(
        included_interviews=None,
        included_properties=None,
        client_as_numeric=True,
        exclude_reliability=True,
        quantiles=1
) -> pandas.DataFrame:
    """
    datasets.sequential(included_interviews, included_properties) -> pandas.DataFrame
    Builds a sequential dataset with including those interviews specified in included_interviews and the
    properties specified in included_properties
    :param included_interviews: list-like of interview_name of interviews to include
    :param client_as_numeric: Whether client_id should be a numeric variable (default True)
    :param exclude_reliability: Whether to exclude (True, default) or include (False) interviews of type 'reliability'
    :param included_properties: list-like of coding_property.name specifying properties to include in the dataset
    :param quantiles: Number of quantiles per interview. Default 1
    :return: pandas.DataFrame
    """

    iv_predicate = ''
    property_predicate = ''
    placeholder = '?'
    args = []

    con = get_connection()

    included_types = ['general'] if exclude_reliability else ['general', 'reliability']
    type_predicate = f"interview.interview_type IN ({','.join(placeholder * len(included_types))})"

    if included_interviews is not None:
        iv_predicate = f"AND interview.interview_name IN ({','.join(placeholder * len(included_interviews))})"
        args.extend(included_interviews)

    if included_properties is not None:
        property_predicate = f"AND coding_property.name IN ({','.join(placeholder * len(included_properties))})"
        args.extend(included_properties)

    args.extend(included_types)

    # Cast the client ID to numeric if desired
    client_column = 'CAST(interview.client_id AS INTEGER) AS "client_id"' if client_as_numeric else 'interview.client_id'

    query = f"""
    WITH interview_lens(interview_id, start_time, end_time, length) AS (
        SELECT utterance.interview_id, MIN(utterance.start_time), MAX(utterance.end_time), 
        (MAX(utterance.end_time) - MIN(utterance.start_time) + 0.5) / {quantiles} AS "length"
        FROM utterance
        GROUP BY utterance.interview_id
    ),
    utt_quantiles(interview_id, utterance_id, quantile) AS (
    SELECT utterance.interview_id, utterance.utterance_id, 
    CAST((utterance.start_time - interview_lens.start_time) / interview_lens.length + 1 AS INTEGER) AS "quantile"
    FROM utterance
    LEFT OUTER JOIN interview_lens ON utterance.interview_id = interview_lens.interview_id
    )
    SELECT 
        utterance.utterance_id,
        interview.interview_name, 
        interview.interview_type, 
        interview.rater_id, 
        {client_column}, 
        interview.session_number, 
        interview.language,
        interview.condition,
        utterance.line_number, 
        utterance.utt_number, 
        utterance.speaker_role, 
        coding_property.variable_name,
        coding_property.data_type, 
        property_value.value, 
        utterance.utt_text, 
        utterance.start_time,
        utterance.end_time,
        uq.quantile
    FROM utterance 
    INNER JOIN interview ON utterance.interview_id = interview.interview_id
    LEFT OUTER JOIN utterance_code ON utterance.utterance_id = utterance_code.utterance_id
    INNER JOIN property_value ON utterance_code.property_value_id = property_value.property_value_id
    INNER JOIN coding_property ON property_value.coding_property_id = coding_property.coding_property_id
    INNER JOIN utt_quantiles uq ON utterance.utterance_id = uq.utterance_id AND utterance.interview_id = uq.interview_id
    WHERE {type_predicate} {iv_predicate} {property_predicate}
    ORDER BY interview.client_id, interview.session_number, utterance.utt_number
    """

    cursor = con.execute(query, args)
    df = pandas.DataFrame.from_records(
        con.execute(query, args),
        columns=[itm[0].lower() for itm in cursor.description]
    )

    # Get the data types so that columns can be converted as necessary
    dtypes = {
        row['variable_name']: float if row['data_type'] == 'numeric' else str
        for idx, row in df.loc[:, ['variable_name', 'data_type']].drop_duplicates().iterrows()
    }

    # reshape the data as necessary and recombine
    meta = (
        df
        .loc[:, ['utterance_id', 'interview_name', 'interview_type', 'rater_id', 'client_id', 'session_number',
                 'language', 'condition', 'line_number', 'utt_number', 'speaker_role', 'utt_text', 'start_time',
                   'end_time', 'quantile']]
        .drop_duplicates()
        .set_index('utterance_id')
    )

    codes = df.pivot(index='utterance_id', columns='variable_name', values='value')

    # Set the data dtypes on applicable columns
    for name, dtype in dtypes.items():
        codes[name] = codes[name].astype(dtype)

    data = meta.join(codes)

    return data


def session_level(
        included_interviews=None,
        included_properties=None,
        included_globals=None,
        client_as_numeric=True,
        exclude_reliability=True
) -> pandas.DataFrame:
    """
    session_level(interview_names) -> pandas.DataFrame
    Builds a session-level DataFrame with counts for interviews named in interview_names
    :param included_interviews: list-like of interview_name of interviews to include in dataset
    :param included_properties: list-like of name of coding properties whose data to include in dataset
    :param included_globals: iterable of GlobalProperty.global_property_id to be included
    :param client_as_numeric: Whether to cast client_id as a numeric variable. Default True
    :param exclude_reliability: Whether to exclude (True, default) or include (False) interviews of type 'reliability'
    :return: pandas.DataFrame
    """

    iv_predicate = ''
    cp_predicate = ''
    gp_predicate = ''
    args = []

    con = get_connection()

    # Used to create a predicate to exclude reliability interviews, if specified
    included_types = ['general'] if exclude_reliability else ['general', 'reliability']
    placeholder = '?'
    args.extend(included_types)

    # may want the client_id cast as numeric
    client_column = (
        'CAST (interview.client_id AS integer) AS "client_id"' if client_as_numeric else 'interview.client_id'
    )

    # Create predicate for included interviews
    if included_interviews is not None:
        iv_predicate = f"AND interview.interview_name IN ({','.join(placeholder * len(included_interviews))})"
        args.extend(included_interviews)

    # Create predicate for included properties
    if included_properties is not None:
        cp_predicate = f"AND coding_property.name IN ({','.join(placeholder * len(included_properties))})"
        args.extend(included_properties)

    # Need to include args for the UNION ALL part of the query
    args.extend(included_types)
    if included_interviews is not None:
        args.extend(included_interviews)

    # Create predicate for included globals
    if included_globals is not None:
        gp_predicate = f"AND global_property.name IN ({','.join(placeholder * len(included_globals))})"
        args.extend(included_globals)

    query = f"""
    WITH count_cte(interview_id, property_value_id, var_count) AS (
        SELECT 
            u.interview_id, 
            uc.property_value_id, 
            COUNT(uc.property_value_id)
        FROM utterance_code uc
        INNER JOIN utterance u ON uc.utterance_id = u.utterance_id
        GROUP BY u.interview_id, uc.property_value_id
    ),
    global_cte(interview_id, variable_name, value, global_property_id) AS (
    SELECT 
        global_rating.interview_id, 
        global_property.variable_name, 
        global_value.value,
        global_value.global_property_id
    FROM global_rating
    INNER JOIN global_value on global_rating.global_value_id = global_value.global_value_id
    LEFT OUTER JOIN global_property ON global_value.global_property_id = global_property.global_property_id
    )
    SELECT 
        interview.interview_name, 
        interview.interview_type, 
        {client_column}, 
        interview.rater_id, 
        interview.session_number, 
        interview.language, 
        interview.condition,
        'numeric' AS "data_type",
        pv.variable_name, 
        CASE WHEN count_cte.var_count IS NULL THEN 0 ELSE count_cte.var_count END AS "var_count"
    FROM interview
    INNER JOIN coding_system cs ON interview.coding_system_id = cs.coding_system_id
    INNER JOIN coding_property cp ON cs.coding_system_id = cp.coding_system_id
    INNER JOIN property_value pv ON cp.coding_property_id = pv.coding_property_id
    LEFT OUTER JOIN count_cte ON interview.interview_id = count_cte.interview_id 
        AND pv.property_value_id = count_cte.property_value_id
    WHERE interview.interview_type IN ({','.join(placeholder * len(included_types))}) {iv_predicate} {cp_predicate}
    UNION ALL
    SELECT 
        interview.interview_name, 
        interview.interview_type, 
        {client_column},
        interview.rater_id, 
        Interview.session_number,
        interview.language, 
        interview.condition, 
        global_property.data_type,
        global_cte.variable_name, 
        global_cte.value
    FROM interview
    INNER JOIN coding_system ON interview.coding_system_id = coding_system.coding_system_id 
    INNER JOIN global_property ON global_property.coding_system_id = coding_system.coding_system_id
    LEFT OUTER JOIN global_cte ON interview.interview_id = global_cte.interview_id AND
        global_property.global_property_id = global_cte.global_property_id
    WHERE interview.interview_type IN ({','.join(placeholder * len(included_types))}) {iv_predicate} {gp_predicate}
    """

    cursor = con.execute(query, args)
    # pull the query results into a dataframe, then reshape it
    # Some DBMS lack the pivot function so reshaping the DataFrame itself rather than the query is necessary
    df = pandas.DataFrame.from_records(cursor, columns=[itm[0].lower() for itm in cursor.description])

    var_types = {row['variable_name']: float if row['data_type'] == 'numeric' else str for idx, row in df.iterrows()}

    df = (
        df.loc[:, ['interview_name', 'interview_type', 'client_id', 'rater_id', 'session_number',
                   'language', 'condition', 'variable_name', 'var_count']]
        .set_index(['interview_name', 'interview_type', 'client_id', 'rater_id', 'session_number',
                      'language', 'condition', 'variable_name'])
        .unstack('variable_name').loc[:, 'var_count'].reset_index().sort_index()
    )

    for var, tp in var_types.items():
        df[var] = df[var].astype(tp)

    return df


def create_quantile_variable_labels(coding_system_id, num_quantiles):
    """
    Creates variable labels for quantile-level dataset
    :param coding_system_id: Id of coding system from which to derive labels
    :param num_quantiles: number of quantiles in the dataset
    :return: dict
    """
    query = f"""
    WITH quantile_cte (variable_name, qv_name, description, qv_desc, quantile) AS (
        SELECT 
            pv.variable_name, 
            pv.variable_name || '_Q{num_quantiles}', 
            pv.description, 
            pv.description || ' quantile {num_quantiles}', 
            {num_quantiles} AS "quantile"
        FROM property_value pv
        INNER JOIN coding_property cp ON pv.coding_property_id = cp.coding_property_id
        WHERE cp.coding_system_id = ?
        UNION ALL
        SELECT 
            quantile_cte.variable_name, 
            quantile_cte.variable_name || '_Q' || CAST(quantile_cte.quantile - 1 AS TEXT) AS "qv_name", 
            quantile_cte.description, 
            quantile_cte.description || ' quantile ' || CAST(quantile_cte.quantile - 1 AS TEXT) AS "qv_desc", 
            quantile_cte.quantile - 1 AS "quantile"
        FROM quantile_cte
        WHERE quantile > 1
    )
    SELECT * 
    FROM quantile_cte
    UNION ALL
    SELECT 
        NULL, 
        variable_name, 
        NULL, 
        description, 
        NULL
    FROM global_property
    WHERE global_property.coding_system_id = ?
    """

    con = get_connection()
    labels = {row[1]: row[3] for row in con.execute(query, [coding_system_id, coding_system_id])}

    return labels


def create_sequential_variable_labels(coding_system_id):
    """
    datasets.create_sequential_variable_labels(coding_system_id, find, replace) -> dict
    Creates a dictionary of variable labels suitable for building an SPSS sequential dataset
    :param coding_system_id: the ID of the coding system for which to create labels
    :return: dict
    """
    con = get_connection()

    query = """
    SELECT coding_property.variable_name, coding_property.description
    FROM coding_property
    WHERE coding_property.coding_system_id = ?
    """
    labels = {row[0]: row[1] for row in con.execute(query, coding_system_id)}

    return labels


def create_sl_variable_labels(coding_system_id):
    """
    datasets.create_variable_labels(coding_system_id) -> dict
    creates a dictionary of variable labels suitable for building an SPSS session-level dataset
    :param coding_system_id: the coding system for which to create variable labels
    :param find: sequence of strings to be replaced in the variable names
    :param replace: sequence of strings with which to replace corresponding entries in find. May also be a
    function which determines the appropriate replacement characters
    :return: dict
    """

    query = """
    SELECT pv.variable_name, pv.description
    FROM property_value pv
    INNER JOIN coding_property cp ON pv.coding_property_id = cp.coding_property_id
    WHERE cp.coding_system_id = ?
    UNION ALL 
    SELECT gp.variable_name, gp.description
    FROM global_property gp
    WHERE gp.coding_system_id = ?
    """

    con = get_connection()

    labels = {row[0]: row[1] for row in con.execute(query, [coding_system_id, coding_system_id])}

    return labels


def save_as_spss(
        data_frame: DataFrame,
        out_path: str,
        names: list = None,
        labels: dict = None
) -> None:
    """
    caastools.utils.save_as_spss(data_frame: pandas.DataFrame, out_path: str) -> None
    saves data_frame as an SPSS dataset at out_path
    :param data_frame: the pandas DataFrame to save
    :param out_path: the path at which to save the file
    :param names: Optional list-like of variable names for the resulting dataset. Will use column names if omitted
    :param labels: Optional dict mapping variable names to labels
    :return: None
    :raise ValueError: if either find/repl is None and the other is not
    :raise ValueError: if find and repl are sequences of unequal length
    """

    cols = data_frame.columns  # type: pandas.Index
    var_names = names if names is not None else list(data_frame.columns)
    var_types = {}
    var_formats = {}
    var_labels = {} if labels is None else labels

    if len(var_names) != len(data_frame.columns):
        raise ValueError("Number of variable names not equal to number of columns in data frame")

    # Construct the various information that the SPSS dictionary will contain about each variable
    for var_name, col in zip(var_names, cols):

        # Need to know the data type and format of each column so that the SPSS file can be written properly
        # 0 is a numeric type, any positive integer is a string type where the number represents the number
        # of bytes the string can hold.
        if is_string_dtype(data_frame[col]) or is_object_dtype(data_frame[col]):
            lens = list(filter(lambda x: notna(x) and x is not None, set(data_frame[col].str.len())))
            var_types[var_name] = int(max(lens)) * 2 if len(lens) > 0 else 255

        else:
            var_types[var_name] = 0
            if ptypes.is_float_dtype(data_frame[col].dtype):
                var_formats[var_name] = "F14.4"
            elif ptypes.is_datetime64_any_dtype(data_frame[col]):
                var_formats[var_name] = "ADATE8"
            else:
                var_formats[var_name] = "F12.0"

    # Sometimes savReaderWriter has trouble writing a whole dataframe in at once,
    # Writing row by row seems to work without issue
    with SavWriter(out_path, var_names, var_types, formats=var_formats, varLabels=var_labels, ioUtf8=True) as writer:
        for row in data_frame.index:
            writer.writerow(data_frame.loc[row, :].values)
