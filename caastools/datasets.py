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
    args = []
    global_args = []

    included_types = ['general'] if not include_reliability else ['general', 'reliability']
    args.extend(included_types)
    global_args.extend(included_types)
    placeholder = '?'

    if included_interviews is not None:
        iv_filter = f"AND rviq.interview_name IN ({','.join(placeholder * len(included_interviews))})"
        global_args.extend(included_interviews)
        args.extend(included_interviews)

        args.extend(included_types)
        global_args.extend(included_types)

        sum_iv_filter = f"AND sum_rviq.interview_name IN ({','.join(placeholder * len(included_interviews))})"
        args.extend(included_interviews)
        global_args.extend(included_interviews)
    else:
        args.extend(included_types)
        global_args.extend(included_types)
        iv_filter = ''
        sum_iv_filter = ''

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
    summary_quantile_counts(interview_id, quantile, summary_variable_id, cnt) AS (
        SELECT 
            u.interview_id, 
            q.quantile, 
            sv.summary_variable_id, 
            COUNT(uc.utterance_code_id)
        FROM 
            utterance_code uc
        INNER JOIN utterance u ON uc.utterance_id = u.utterance_id
        INNER JOIN summary_variable_link svl ON uc.property_value_id = svl.parent_primary_key
        INNER JOIN summary_variable sv ON svl.summary_variable_id = sv.summary_variable_id
        LEFT OUTER JOIN utt_quantiles q ON uc.utterance_id = q.utterance_id
        WHERE sv.parent_table_name = 'property_value'
        GROUP BY u.interview_id, q.quantile, sv.summary_variable_id
    ),
    rivq(interview_id, interview_type, condition, property_value_id, interview_name, 
           client_id, rater_id, session_number, quantile, property) AS (
        SELECT 
            iv.interview_id, 
            iv.interview_type, 
            iv.condition, 
            pv.property_value_id, 
            iv.interview_name, 
            {client_column}, 
            iv.rater_id, 
            iv.session_number, 
            {quantiles} AS "quantile", 
            pv.variable_name
        FROM interview iv
        INNER JOIN coding_system cs ON iv.coding_system_id = cs.coding_system_id
        INNER JOIN coding_property cp ON cs.coding_system_id = cp.coding_system_id
        INNER JOIN property_value pv ON cp.coding_property_id = pv.coding_property_id
        UNION ALL
        SELECT 
            rivq.interview_id, 
            rivq.interview_type, 
            rivq.condition, 
            rivq.property_value_id, 
            rivq.interview_name, 
            rivq.client_id, 
            rivq.rater_id, 
            rivq.session_number, 
            rivq.quantile - 1 AS "quantile", 
            rivq.property
        FROM rivq
        WHERE quantile > 1
    ),
    sum_rivq(interview_id, interview_type, condition, summary_variable_id, interview_name,
                client_id, rater_id, session_number, quantile, property) AS (
        SELECT DISTINCT
            iv.interview_id, 
            iv.interview_type,
            iv.condition,
            sv.summary_variable_id, 
            iv.interview_name, 
            {client_column},
            iv.rater_id, 
            iv.session_number,
            {quantiles} as "quantile",
            sv.variable_name
        FROM
            interview iv
        INNER JOIN coding_system cs ON iv.coding_system_id = cs.coding_system_id
        INNER JOIN coding_property cp ON cs.coding_system_id = cp.coding_system_id
        INNER JOIN property_value pv ON cp.coding_property_id = pv.coding_property_id
        INNER JOIN summary_variable_link svl ON pv.property_value_id = svl.parent_primary_key
        INNER JOIN summary_variable sv ON svl.summary_variable_id = sv.summary_variable_id
        WHERE sv.parent_table_name = 'property_value'
        UNION ALL
        SELECT DISTINCT
            sum_rivq.interview_id,
            sum_rivq.interview_type, 
            sum_rivq.condition,
            sum_rivq.summary_variable_id, 
            sum_rivq.interview_name, 
            sum_rivq.client_id, 
            sum_rivq.rater_id, 
            sum_rivq.session_number, 
            sum_rivq.quantile - 1 AS "quantile", 
            sum_rivq.property
        FROM sum_rivq
        WHERE quantile > 1
    )   
    SELECT 
        rivq.interview_id, 
        rivq.interview_type, 
        rivq.condition,
        rivq.property_value_id, 
        rivq.interview_name, 
        rivq.client_id, 
        rivq.rater_id, 
        rivq.session_number, 
        rivq.quantile AS "quantile", 
        rivq.property AS "var_name", 
        CASE WHEN quantile_counts.cnt IS NULL THEN 0 ELSE quantile_counts.cnt END AS "var_count"
    FROM rivq
    LEFT OUTER JOIN quantile_counts ON rivq.property_value_id = quantile_counts.property_value_id
        AND rivq.interview_id = quantile_counts.interview_id
        AND rivq.quantile = quantile_counts.quantile
    WHERE rivq.interview_type IN ({','.join(placeholder * len(included_types))}) {iv_filter}
    UNION ALL 
    SELECT
        sum_rivq.interview_id, 
        sum_rivq.interview_type,
        sum_rivq.condition,
        sum_rivq.summary_variable_id,
        sum_rivq.interview_name,
        sum_rivq.client_id,
        sum_rivq.rater_id,
        sum_rivq.session_number,
        sum_rivq.quantile AS "quantile",
        sum_rivq.property AS "var_name",
        CASE WHEN summary_quantile_counts.cnt IS NULL THEN 0 ELSE summary_quantile_counts.cnt END AS "var_count"
    FROM 
        sum_rivq
    LEFT OUTER JOIN summary_quantile_counts ON 
        sum_rivq.summary_variable_id = summary_quantile_counts.summary_variable_id
        AND sum_rivq.interview_id = summary_quantile_counts.interview_id
        AND sum_rivq.quantile = summary_quantile_counts.quantile
    WHERE
        sum_rivq.interview_type IN ({','.join(placeholder * len(included_types))}) {sum_iv_filter}
    ORDER BY 
        client_id, 
        session_number, 
        rater_id, 
        property, 
        quantile
    """

    # Global ratings don't have values by quantile,
    # so that query will need to be handled separately and incorporated after the fact
    global_query = f"""
    WITH zero_globals(interview_id, summary_variable_id, var_count, parent_table_name, variable_name) AS (
            SELECT iv.interview_id,
                sv.summary_variable_id, 
                0 AS "var_count",
                sv.parent_table_name,
                sv.variable_name
            FROM 
                summary_variable sv
            INNER JOIN interview iv ON sv.coding_system_id = iv.coding_system_id
            WHERE 
                sv.parent_table_name = 'global_property'
    ),
    basic_global_summaries(interview_id, summary_variable_id, var_count, parent_table_name, variable_name) AS (
            SELECT
                gr.interview_id,
                sv.summary_variable_id,
                CASE
                    WHEN sv.summary_func = 'sum' then SUM(CAST(gv.value AS REAL))
                    ELSE AVG(CAST(gv.value AS REAL))
                END AS "var_count",
                sv.parent_table_name,
                sv.variable_name
            FROM global_rating gr
            INNER JOIN interview iv ON gr.interview_id = iv.interview_id
            INNER JOIN global_value gv ON gr.global_value_id = gv.global_value_id
            INNER JOIN summary_variable_link svl ON gv.global_property_id = svl.parent_primary_key
            INNER JOIN summary_variable sv ON svl.summary_variable_id = sv.summary_variable_id
                AND iv.coding_system_id = sv.coding_system_id
            WHERE sv.parent_table_name = 'global_property'
            GROUP BY iv.interview_id, sv.summary_variable_id     
    ),
    all_global_summaries(interview_id, summary_variable_id, var_count, parent_table_name, variable_name) AS (
        SELECT 
            zg.interview_id,
            zg.summary_variable_id,
            COALESCE(bgs.var_count, zg.var_count) AS "var_count",
            COALESCE(bgs.parent_table_name, zg.parent_table_name) AS "parent_table_name",
            COALESCE(bgs.variable_name, zg.variable_name) AS "variable_name"
        FROM zero_globals zg
        LEFT OUTER JOIN basic_global_summaries bgs ON zg.interview_id = bgs.interview_id
            AND zg.summary_variable_id = bgs.summary_variable_id
    )
    SELECT 
        gr.interview_id AS "interview_id", 
        gp.variable_name AS "variable_name", 
        gp.data_type AS "data_type", 
        gv.value AS "value",
        iv.client_id AS "client_id",
        iv.session_number AS "session_number",
        iv.rater_id AS "rater_id"
    FROM 
        global_rating gr
    INNER JOIN global_value gv ON gr.global_value_id = gv.global_value_id
    INNER JOIN global_property gp ON gv.global_property_id = gp.global_property_id
    INNER JOIN interview iv ON gr.interview_id = iv.interview_id
    WHERE iv.interview_type IN ({','.join(placeholder * len(included_types))}) {iv_filter}
    UNION ALL
    SELECT
        ags.interview_id AS "interview_id",
        ags.variable_name AS "variable_name",
        'numeric' AS "data_type",
        ags.var_count AS "value",
        iv.client_id AS "client_id",
        iv.session_number AS "session_number",
        iv.rater_id AS "rater_id"
    FROM
        all_global_summaries ags
    INNER JOIN interview iv ON ags.interview_id = iv.interview_id
    WHERE iv.interview_type IN ({','.join(placeholder * len(included_types))}) {iv_filter}
    ORDER BY client_id, session_number, rater_id, variable_name    
    """

    q_csr = con.execute(query, args)
    g_csr = con.execute(global_query, global_args)

    df = pandas.DataFrame.from_records(q_csr, columns=[itm[0].lower() for itm in q_csr.description])
    gdf = pandas.DataFrame.from_records(g_csr, columns=[itm[0].lower() for itm in g_csr.description])

    meta = (
        df
            .loc[:, ['interview_id', 'interview_name', 'interview_type', 'condition', 'client_id', 'rater_id', 'session_number']]
            .drop_duplicates()
            .set_index('interview_id')
    )

    # Reshape the count data to be a cross-section
    counts = (
        df
            .loc[:, ['interview_id', 'var_name', 'quantile', 'var_count']]
            .set_index(['interview_id', 'var_name', 'quantile'])
            .unstack(['var_name', 'quantile'])
    )

    counts.columns = [f"{c[1]}_Q{str(c[2]).zfill(2)}" for c in counts.columns]

    # Reshape the global ratings and cast to the appropriate type for each global
    gr = (
        gdf.loc[:, ['interview_id', 'variable_name', 'value']]
        .pivot(index='interview_id', columns='variable_name', values='value')
    )

    for idx, row in gdf.iterrows():
        tp = float if row['data_type'] == 'numeric' else str
        column = row['variable_name']
        gr[column] = gr[column].astype(tp)

    # join together all of the data
    data = meta.join(counts).join(gr).reset_index(drop=True)

    return data


def sequential(
        included_interviews=None,
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
    placeholder = '?'
    args = [quantiles]

    con = get_connection()

    included_types = ['general'] if exclude_reliability else ['general', 'reliability']
    args.extend(included_types)

    type_predicate = f"sq.interview_type IN ({','.join(placeholder * len(included_types))})"

    if included_interviews is not None:
        iv_predicate = f"AND sq.interview_name IN ({','.join(placeholder * len(included_interviews))})"
        args.extend(included_interviews)

    # Cast the client ID to numeric if desired
    client_column = 'CAST(sq.client_id AS INTEGER) AS "client_id"' if client_as_numeric else 'sq.client_id'

    query = f"""
    WITH interview_lens(interview_id, start_time, end_time, length) AS (
        SELECT utterance.interview_id, MIN(utterance.start_time), MAX(utterance.end_time), 
        (MAX(utterance.end_time) - MIN(utterance.start_time) + 0.5) / ? AS "length"
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
        sq.utterance_id,
        sq.interview_name, 
        sq.interview_type, 
        sq.rater_id, 
        {client_column}, 
        sq.session_number, 
        sq.language,
        sq.condition,
        sq.line_number, 
        sq.utt_number, 
        sq.speaker_role, 
        sq.variable_name,
        sq.data_type, 
        sq.value, 
        sq.utt_text, 
        sq.start_time,
        sq.end_time,
        uq.quantile
    FROM sequential_dataset sq
    INNER JOIN utt_quantiles uq ON sq.utterance_id = uq.utterance_id AND sq.interview_id = uq.interview_id
    WHERE {type_predicate} {iv_predicate}
    ORDER BY sq.client_id, sq.session_number, sq.utt_number
    """

    cursor = con.execute(query, args)
    df = pandas.DataFrame.from_records(cursor, columns=[itm[0].lower() for itm in cursor.description])

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
    args = []

    con = get_connection()

    # Used to create a predicate to exclude reliability interviews, if specified
    included_types = ['general'] if exclude_reliability else ['general', 'reliability']
    placeholder = '?'
    args.extend(included_types)

    # may want the client_id cast as numeric
    client_column = (
        'CAST (client_id AS INTEGER) AS "client_id"' if client_as_numeric else 'client_id'
    )

    # Create predicate for included interviews
    if included_interviews is not None:
        iv_predicate = f"AND interview_name IN ({','.join(placeholder * len(included_interviews))})"
        args.extend(included_interviews)

    query = f"""
    SELECT 
        interview_name, 
        interview_type, 
        {client_column}, 
        rater_id, 
        session_number,
        language, 
        condition, 
        data_type, 
        variable_name, 
        CASE WHEN var_count IS NULL then 0 ELSE var_count END AS "var_count"
    FROM session_dataset
    WHERE interview_type IN ({','.join(placeholder * len(included_types))}) 
        {iv_predicate}
        AND variable_name IS NOT NULL
    """

    cursor = con.execute(query, args)

    # pull the query results into a dataframe, then reshape it
    # Some DBMS lack the pivot function so reshaping the DataFrame itself rather than the query is necessary
    df = pandas.DataFrame.from_records(cursor, columns=[itm[0].lower() for itm in cursor.description])

    var_types = {row['variable_name']: float if row['data_type'] == 'numeric' else str for idx, row in df.iterrows()}

    df = (
        df.loc[:,
            [
                'interview_name', 'interview_type', 'client_id', 'rater_id', 'session_number',
                'language', 'condition', 'variable_name', 'var_count'
            ]
        ]
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
            pv.variable_name || '_Q' || SUBSTR('00' || {num_quantiles}, -2, 2) AS "qv_name", 
            pv.description, 
            pv.description || ' quantile {num_quantiles}', 
            {num_quantiles} AS "quantile"
        FROM property_value pv
        INNER JOIN coding_property cp ON pv.coding_property_id = cp.coding_property_id
        WHERE cp.coding_system_id = ?
        UNION ALL
        SELECT 
            quantile_cte.variable_name, 
            quantile_cte.variable_name || '_Q' || SUBSTR('00' || CAST(quantile_cte.quantile - 1 AS TEXT), -2, 2) AS "qv_name", 
            quantile_cte.description, 
            quantile_cte.description || ' quantile ' || CAST(quantile_cte.quantile - 1 AS TEXT) AS "qv_desc", 
            quantile_cte.quantile - 1 AS "quantile"
        FROM quantile_cte
        WHERE quantile > 1
    ),
    summary_cte(variable_name, qv_name, description, qv_desc, quantile) AS (
        SELECT
            sv.variable_name,
            sv.variable_name || '_Q' || SUBSTR('00' || {num_quantiles}, -2, 2) AS "qv_name",
            sv.variable_label,
            sv.variable_label || ' quantile {num_quantiles}', 
            {num_quantiles} AS "quantile"
        FROM summary_variable sv
        WHERE 
            sv.coding_system_id = ?
            AND sv.parent_table_name = 'property_value'
        UNION ALL 
        SELECT
            summary_cte.variable_name,
            summary_cte.variable_name || '_Q' || SUBSTR('00' || CAST(summary_cte.quantile - 1 AS TEXT), -2, 2) AS "qv_name",
            summary_cte.description,
            summary_cte.description || ' quantile ' || CAST(summary_cte.quantile - 1 AS TEXT) AS "qv_desc", 
            summary_cte.quantile - 1 AS "quantile"
        FROM summary_cte
        WHERE quantile > 1
    )
    SELECT * 
    FROM quantile_cte
    UNION ALL
    SELECT * 
    FROM summary_cte
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
    labels = {row[1]: row[3] for row in con.execute(query, [coding_system_id, coding_system_id, coding_system_id])}

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
    UNION ALL 
    SELECT variable_name, variable_label
    FROM summary_variable
    WHERE coding_system_id = ?
    """

    con = get_connection()

    labels = {row[0]: row[1] for row in con.execute(query, [coding_system_id, coding_system_id, coding_system_id])}

    return labels


def save_as_spss(
        data_frame: DataFrame,
        out_path: str,
        names: list = None,
        labels: dict = None,
        values: dict = None
) -> None:
    """
    caastools.utils.save_as_spss(data_frame: pandas.DataFrame, out_path: str) -> None
    saves data_frame as an SPSS dataset at out_path
    :param data_frame: the pandas DataFrame to save
    :param out_path: the path at which to save the file
    :param names: Optional list-like of variable names for the resulting dataset. Will use column names if omitted
    :param labels: Optional dict mapping variable names to labels
    :param values: Optional nested dict mapping variable names to value labels {'var_name': {value: 'label'}}
    :return: None
    :raise ValueError: if either find/repl is None and the other is not
    :raise ValueError: if find and repl are sequences of unequal length
    """

    cols = data_frame.columns  # type: pandas.Index
    var_names = names if names is not None else list(data_frame.columns)
    var_types = {}
    var_formats = {}
    var_labels = {} if labels is None else labels
    value_labels = {} if values is None else values

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
    with SavWriter(
            out_path, var_names, var_types, formats=var_formats, varLabels=var_labels, ioUtf8=True,
            valueLabels=value_labels,
    ) as writer:
        for row in data_frame.index:
            writer.writerow(data_frame.loc[row, :].values)
