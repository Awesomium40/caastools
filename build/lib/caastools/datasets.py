import pandas

from caastools.database.connection import _con as con
from .database import CodingSystem, CodingProperty, GlobalProperty, GlobalRating, GlobalValue, Interview, \
    PropertyValue, Utterance, UtteranceCode
from .utils import sanitize_for_spss
from pandas import DataFrame, Index, MultiIndex, notna
from pandas.api.types import is_string_dtype, is_object_dtype
from peewee import Case, Cast, fn, JOIN, Value
from savReaderWriter.savWriter import SavWriter
from numpy import NaN
import logging
import pandas.api.types as ptypes


logging.getLogger('caastools.dataset').addHandler(logging.NullHandler())
__all__ = ['sequential', 'session_level', 'create_sl_variable_labels', 'save_as_spss']


def _global_query_(included_interviews=None, client_as_numeric=True, include_reliability=False):
    """
    Constructs the globals query for session-level datasets
    :param included_interviews: iterable of str specifying names of interviews to include
    :param included_globals:
    :param client_as_numeric: Whether to cast client_id as a numeric type. Default True
    :param exclude_reliability: Whether to exclude (True, default) or include (False) interviews of type 'reliability'
    :return: ModelSelect, Cte - The full query for global ratings and the CTE associated object
    """
    placeholder = '?'
    client_column_str = "CAST(Interview.client_id AS INTEGER)" if client_as_numeric else 'Interview.client_id'
    args = []

    # May want only certain interviews included or certain properties included,
    # so construct some predicates for where clauses, if necessary
    types = ['general'] if not include_reliability else ['general', 'reliability']
    type_predicate = f" WHERE interview.interview_type IN ({','.join(placeholder* len(types))}) "
    args.extend(types)

    # if specified to include certain interviews, add predicate
    interview_predicate = (f" AND interview.interview_name IN ({','.join(placeholder * len(included_interviews))}) "
                           if included_interviews is not None else '')
    args.extend([] if included_interviews is None else included_interviews)

    full_predicate = f"{type_predicate}{interview_predicate}"
    interview_select = """

    """

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
        SELECT uc.interview_id, q.quantile, uc.property_value_id, COUNT(uc.utterance_code_id)
        FROM utterance_code uc
        LEFT OUTER JOIN utt_quantiles q ON uc.utterance_id = q.utterance_id
        GROUP BY q.interview_id, q.quantile, uc.property_value_id
    ),
    RECURSIVE rivq(interview_id, interview_type, property_value_id, interview_name, 
           client_id, rater_id, session_number, quantile, property) AS (
        SELECT iv.interview_id, iv.interview_type, pv.property_value_id, iv.interview_name, {client_column}, 
            iv.rater_id, iv.session_number, {quantiles} AS "quantile", cp.display_name || '_' || pv.value
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
    ORDER BY rviq.client_id, rivq.session_number, rivq.rater_id, rivq.property, rivq.quantile 
    """

    # In order to build the quantile-level dataset, each utterance needs to be placed into its quantile
    # Frist step in that operation is to determine the length of a quantile by interview
    decile_lens = Utterance.select(Utterance.interview_id, fn.MIN(Utterance.utt_start_time),
                                   fn.MAX(Utterance.utt_end_time),
                                   (fn.MAX(Utterance.utt_end_time) - fn.MIN(Utterance.utt_start_time)) / quantiles) \
        .group_by(Utterance.interview_id) \
        .cte('decile_lens', columns=['interview_id', 'start_time', 'end_time', 'length'])

    # Once the length of a quantile is known, the next step is to compute a CTE
    # in which each utterance has its quantile number assigned
    utt_deciles = Utterance.select(
        Utterance.interview_id, Utterance.utterance_id,
        Cast((Utterance.utt_start_time - decile_lens.c.start_time) / decile_lens.c.length + 1, "INT")
    ).join(decile_lens, JOIN.LEFT_OUTER, on=(Utterance.interview_id == decile_lens.c.interview_id)) \
     .cte('utt_deciles', columns=['interview_id', 'utterance_id', 'quantile'])

    # Once an utterance has a quantile number assigned, the last step in getting the counts
    # is to select codes and group by interview, quantile, and property_value
    decile_counts = UtteranceCode.select(utt_deciles.c.interview_id, utt_deciles.c.quantile,
                                         UtteranceCode.property_value_id,
                                         fn.COUNT(UtteranceCode.utterance_code_id)) \
        .join(utt_deciles, JOIN.LEFT_OUTER, on=(UtteranceCode.utterance_id == utt_deciles.c.utterance_id)) \
        .group_by(utt_deciles.c.interview_id, utt_deciles.c.quantile, UtteranceCode.property_value_id) \
        .cte('decile_counts', columns=['interview_id', 'quantile', 'property_value_id', 'cnt'])

    case = Case(None, ((decile_counts.c.cnt.is_null(), 0),), (decile_counts.c.cnt))

    client_column = Cast(Interview.client_id, "INT").alias('client_id') if client_as_numeric else Interview.client_id
    var_column = CodingProperty.cp_display_name.concat("_").concat(PropertyValue.pv_value).alias('property')

    # In order to construct the quantile-level dataset, we first need a recursive CTE
    # that defines every code for every quantile and interview
    # This will require a recursive CTE
    # Start with the base case
    quantile = Value(quantiles).alias('quantile')
    base_case = (Interview.select(Interview.interview_id, Interview.interview_type,
                                  PropertyValue.property_value_id, Interview.interview_name, client_column,
                                  Interview.rater_id, Interview.session_number, quantile, var_column)
                 .join(CodingSystem)
                 .join(CodingProperty)
                 .join(PropertyValue)).cte('base', recursive=True)

    # Now, define the recursive terms
    rquantile = (base_case.c.quantile - 1).alias('quantile')
    rterm = base_case.select(base_case.c.interview_id, base_case.c.interview_type, base_case.c.property_value_id,
                             base_case.c.interview_name, base_case.c.client_id, base_case.c.rater_id,
                             base_case.c.session_number, rquantile, base_case.c.property).where(rquantile > 1)

    # The full expression is the union all of the base case with the recursive term
    qt = base_case.union_all(rterm)
    outer_query = qt.select_from(qt.c.interview_id, qt.c.property_value_id, qt.c.interview_name, qt.c.interview_type,
                                 qt.c.client_id, qt.c.rater_id, qt.c.session_number, qt.c.quantile, qt.c.property,
                                 case.alias('var_count'))

    # Join the recursive CTE for interview/quantiles to the actual count data
    full_query = (
        outer_query.join(
            decile_counts, JOIN.LEFT_OUTER,
            on=((qt.c.property_value_id == decile_counts.c.property_value_id) &
                (qt.c.interview_id == decile_counts.c.interview_id) &
                (qt.c.quantile == decile_counts.c.quantile)))
        )

    # Filter the included data as specified, for type and name
    predicate = qt.c.interview_type.in_(included_types)
    if included_interviews is not None:
        predicate = predicate & qt.c.interview_name.in_(included_interviews)
    full_query = full_query.where(predicate)

    # Include the required table expressions to create the full query
    full_query = full_query.with_cte(decile_counts, utt_deciles, decile_lens, qt)
    full_query = full_query.order_by(qt.c.client_id, qt.c.session_number, qt.c.rater_id, qt.c.property,
                                     qt.c.quantile)

    # WIth the full query constructed, can build the dataframe from the returned rows
    df = DataFrame.from_records(full_query.tuples().execute(),
                                columns=['interview_id', 'property_value_id', 'interview_name', 'interview_type',
                                         'client_id', 'rater_id', 'session_number', 'quantile', 'var_name',
                                         'var_value'])

    # Compute a column for quantile x code
    df['decile_var_name'] = df['var_name'] + "_q" + df['quantile'].astype(str).apply(lambda x: x.zfill(2))

    # Reshape the dataframe and index on client_id
    df = df.loc[:, ['interview_name', 'client_id', 'rater_id', 'session_number', 'decile_var_name', 'var_value']] \
        .set_index(['interview_name', 'client_id', 'rater_id', 'session_number', 'decile_var_name']) \
        .unstack('decile_var_name').loc[:, 'var_value'].reset_index().set_index('client_id')

    # To add the globals data, first get the appropriate query
    # Then put into dataframe
    # then, reshape and reindex like the count data
    global_query, global_cte = _global_query_(
        included_interviews=included_interviews, include_reliability=include_reliability
    )
    global_query = global_query.with_cte(global_cte)
    gdf = (
        DataFrame.from_records(
            global_query.tuples().execute(),
            columns=['interview_name', 'client_id', 'rater_id', 'session_number', 'var_name', 'var_value']
        )
        .loc[:, ['client_id', 'var_name', 'var_value']].set_index(['client_id', 'var_name'])
        .unstack('var_name').loc[:, 'var_value'])

    df = df.join(gdf).sort_index()

    return df


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

    query = (
        f"""
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
            interview.interview_name, 
            interview.interview_type, 
            interview.rater_id, 
            {client_column}, 
            interview.session_number, 
            utterance.line_number, 
            utterance.utt_number, 
            utterance.speaker_role, 
            coding_property.display_name,
            coding_property.data_type, 
            property_value.value, 
            utterance.utt_text, 
            utterance.start_time,
            utterance.end_time
        FROM utterance 
        INNER JOIN interview ON utterance.interview_id = unterview.interview_id
        LEFT OUTER JOIN utterance_code ON utterance.utterance_id = utterance_code.utterance_id
        INNER JOIN property_value ON utterance_code.property_value_id = property_value.property_value_id
        INNER JOIN coding_property ON property_value.coding_property_id = coding_property.coding_property_id
        WHERE {type_predicate} {iv_predicate} {property_predicate}
        ORDER BY interview.client_id, interview.session_number, utterance.utt_number
        """
    )
    cursor = con.execute(query, args)
    df = pandas.DataFrame.from_records(
        con.execute(query, args), columns=['interview_name', 'interview_type', 'rater_id', 'client_id',
                                           'session_number', 'line_number', 'utt_number', 'role', ])


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
    global_cte(interview_id, name, value, global_property_id) AS (
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
        property_value.variable_name AS "property", 
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
        {client_column}
        interview.rater_id, 
        Interview.session_number, 
        global_cte.name, 
        global_cte.value
    FROM interview
    INNER JOIN coding_system ON interview.coding_system_id = coding_system.coding_system_id 
    INNER JOIN global_property ON global_property.coding_system_id = coding_system.coding_system_id
    LEFT OUTER JOIN global_cte ON interview.interview_id = global_cte.interview_id AND
        global_property.global_property_id = global_cte.global_property_id
    WHERE interview.interview_type IN ({','.join(placeholder * len(included_types))}) {iv_predicate} {gp_predicate}
    """

    # pull the query results into a dataframe, then reshape it
    # Some DBMS lack the pivot function so reshaping the DataFrame itself rather than the query is necessary
    df = DataFrame.from_records(con.execute(query, args),
                                columns=['interview_name', 'interview_type', 'client_id', 'rater_id', 'session_number',
                                         'var_name', 'var_value'])

    df = (
        df.set_index(['interview_name', 'interview_type', 'client_id', 'rater_id', 'session_number', 'var_name'])
        .unstack('var_name').loc[:, 'var_value'].reset_index().sort_index()
    )

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

    query = """
    SELECT coding_property.variable_name, coding_property.description
    FROM coding_property
    WHERE coding_property.coding_system_id = ?
    """
    labels = {row[0]: row[1] for row in con.execute(query, coding_system_id)}

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
    gp_query = (GlobalProperty.select(GlobalProperty.gp_name, GlobalProperty.gp_description)
                .where(GlobalProperty.coding_system == coding_system_id))

    pv_query = (PropertyValue.select(CodingProperty.cp_name.concat("_").concat(PropertyValue.pv_value))
                .join(CodingProperty)
                .join(CodingSystem)
                .where(CodingProperty.coding_system == coding_system_id)
                .union_all(gp_query)
                .order_by(CodingProperty.coding_property_id, PropertyValue.pv_value))

    sl_labels = {sanitize_for_spss(row[0], find=find, repl=replace): row[1] for row in pv_query.tuples().execute()}

    return sl_labels


def save_as_spss(data_frame: DataFrame, out_path: str, labels: dict = None, find=None, repl=None) -> None:
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
    is_multi_index = isinstance(cols, MultiIndex)
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
        if is_string_dtype(data_frame[col]) or is_object_dtype(data_frame[col]):
            lens = list(filter(lambda x: notna(x) and x is not None, set(data_frame[col].str.len())))
            var_types[var_name] = int(max(lens)) * 2 if len(lens) > 0 else 255

        else:
            var_types[var_name] = 0
            var_formats[var_name] = "F10.2" if ptypes.is_float_dtype(data_frame[col].dtype) else \
                "ADATE8" if ptypes.is_datetime64_any_dtype(data_frame[col]) else \
                    "F12.0"

    # Sometimes savReaderWriter has trouble writing a whole dataframe in at once,
    # Writing row by row seems to work without issue
    with SavWriter(out_path, var_names, var_types, formats=var_formats, varLabels=var_labels, ioUtf8=True) as writer:
        for row in data_frame.index:
            writer.writerow(data_frame.loc[row, :].values)
