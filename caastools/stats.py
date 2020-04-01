from collections import Counter
from scipy import stats
import itertools
import logging
import numpy
import pandas


logging.getLogger('caastools.stats').addHandler(logging.NullHandler())


def cohens_kappa(rows, columns, weight=None):
    """
    Computes cohen's kappa for the specified series
    :param rows: The series to comprise the rows of the crosstabulation. Accepts an iterable, Series, or numpy.array
    :param columns: The series to comprise the columns of the crosstabulation. Accepts an iterable, Series, or numpy.array
    :param weight the weighting scheme to apply (None, 'linear', 'quadratic') Default None
    :return tuple[float, float]: Cohen's kappa, maximum attainable kappa
    """
    if weight not in (None, 'linear', 'quadratic'):
        raise ValueError("Invalid weight specification")

    weight_funcs = {None: lambda x, y: 0 if x == y else 1,
                    'linear': lambda x, y: abs(x - y),
                    'quadratic': lambda x, y: (x - y) ** 2}

    diff_func = weight_funcs.get(weight)
    if diff_func is None:
        raise ValueError("Invalid weight specification")

    all_values = sorted(set(filter(lambda x: pandas.notna(x), itertools.chain(rows, columns))))
    if len(all_values) == 0:
        logging.warning("Unable to compute cohen's kappa because no non-missing values were found")
        return numpy.NaN, numpy.NaN

    index = pandas.Categorical(rows, categories=all_values)
    cols = pandas.Categorical(columns, categories=all_values)

    ct = pandas.crosstab(index, cols, normalize=True, dropna=False)

    # Get the marginal totals to compute expected agreement matrix later
    col_totals = ct.sum(axis=0, skipna=True)
    row_totals = ct.sum(axis=1, skipna=True)

    # Compute the weighting matrix
    row_cats = index.categories
    col_cats = cols.categories
    row_idx = range(len(row_cats))
    col_idx = range(len(col_cats))
    wm_arry = numpy.array([[diff_func(r, c) for c in col_idx] for r in row_idx])
    wm = pandas.DataFrame(data=wm_arry, index=ct.index, columns=ct.columns)

    # Compute the weighted matrix of observations
    wobs = ct * wm

    # Compute weighted expectancy matrix
    exp_arry = numpy.array([[rt * ct for ct in col_totals] for rt in row_totals])
    exp = pandas.DataFrame(exp_arry, index=row_totals.index, columns=col_totals.index)
    wexp = exp * wm

    # Compute kappa via the weighted matrices
    kappa = 1 - (wobs.sum().sum() / wexp.sum().sum())

    # compute the maximum attainable kappa
    pe = 1 - wexp.sum().sum()
    pmax = sum([min(a, b) for a, b in zip(row_totals, col_totals)])
    kmax = (pmax - pe) / (1 - pe)

    return kappa, kmax


def fleiss(frame: pandas.DataFrame, subject_column, rater_column, category_column):
    """
    stats.fleiss(frame: pandas.DataFrame) -> float
    Computes the fleiss multirater kappa from the provided count data
    :param frame: The DataFrame object containing all the raw observations
    :param subject_column: the name of the column that designates the subject being rated
    :param rater_column: the name of the column that specifies the rater
    :param category_column: the name of the column that specifies the category assigned to subject by rater
    :return: float
    """

    # First thing for a fleiss coefficient is to extract the necessary count data
    input_data = frame[[subject_column, rater_column, category_column]].copy()
    counts = input_data.pivot_table(values=rater_column, index=subject_column, columns=category_column,
                                    aggfunc=numpy.count_nonzero, fill_value=0)

    # Get number of subjects and categories
    N, k = counts.shape
    obs_count = counts.sum().sum()

    # number of raters
    n = obs_count // N

    # pj = proportion of agreement for a given category
    pj = counts.sum() / obs_count

    # pi = proportion of agreement for a given subject
    pi = (1 / (n * (n - 1))) * ((counts ** 2).sum(axis=1) - n)

    # pobs = proportion of observed agreement
    pobs = pi.sum() / N

    # pe = proportion of agreement expected by change
    pe = (pj ** 2).sum()

    k = (pobs - pe) / (1 - pe)

    return k


def icc(frame: pandas.DataFrame, icc_type=2):
    """
    Compute Intraclass Correllation Coefficient
    Based on Bakeman, R., & Quera, V. (2011). Sequential Analysis and Observational
    Methods for the Behavioral Sciences.
    Formulas drawn from: McGraw, K. O. & Wong, S.P. (1996). Forming inferences about some intraclass
    correlation coefficients. Psychological Methods, 1(1), 30-46.

    :param frame: The pandas.DataFrame from which to compute the ICC
    :param icc_type: The type of ICC to run (only 2 and 3 currently supported). Default 2
    :return: tuple[float, float, float] The intraclass correlation coefficient, F and associated p-value
    :raises ValueError: If frame has fewer than 2 rows or columns
    """
    n, k = frame.shape

    if n < 2:
        raise ValueError("Unable to compute an ICC because fewer than 2 rows with non-missing data were found")
    if k < 2:
        raise ValueError("Unable to compute an ICC because fewer than 2 raters were found")

    icc_types = {1: lambda ms_sub, ms_err, ms_within, ms_r, df_r, k, n:
                 (ms_sub - ms_within) / (ms_sub + df_r * ms_within),
                 2: lambda ms_sub, ms_err, ms_within, ms_r, df_r, k, n:
                 (ms_sub - ms_err) / (ms_sub + df_r * ms_err + k * (ms_r - ms_err) / n),
                 3: lambda ms_sub, ms_err, ms_within, ms_r, df_r, k, n:
                 (ms_sub - ms_err) / (ms_sub + df_r * ms_err)}

    formula = icc_types.get(icc_type)
    if formula is None:
        raise ValueError("Invalid specification for icc_type. Expected (1, 2, 3)")

    # Degrees of Freedom
    df_raters = k - 1  # dfc
    df_subjects = n - 1  # dfr
    df_error = df_subjects * df_raters  # dfe
    df_within_rows = n * (k - 1)

    # Sum of squares Total
    grand_mean = frame.mean().mean()
    ss_total = ((frame - grand_mean) ** 2).sum().sum()

    # Sum of squares between raters (columns)
    ss_raters = n * ((frame.mean(0) - grand_mean) ** 2).sum()
    ms_raters = ss_raters / df_raters

    # Sum of Squares for the error term
    ss_within_cols = ss_total - ss_raters
    ss_rows = k * ((frame.mean(1) - grand_mean) ** 2).sum().sum()
    ss_error = ss_within_cols - ss_rows
    ms_error = ss_error / df_error

    # Sum of Squares between subjects (rows)
    ss_subjects = ss_within_cols - ss_error
    ms_subjects = ss_subjects / df_subjects

    # Sum of squares within subjects (rows)
    ss_within_subjects = ss_raters + ss_error
    ms_within_subjects = ss_within_subjects / df_within_rows

    coeff = formula(ms_subjects, ms_error, ms_within_subjects, ms_raters, df_raters, k, n)

    f = ms_subjects / ms_error

    return coeff, f, stats.f.sf(f, df_subjects, df_error)


def kalpha(data, metric='nominal'):
    """
    stats.kalpha(data, metric='nominal') -> float
    Computes Krippendorf's alpha-reliability for the provided DataFrame
    Data should be structured S.T. raters are the index,
    subjects are the columns, and observations are the cell values
    :param data: pandas.DataFrame holding the observational data
    :param metric: string specifying the type of data/metric. Default 'nominal'
    Acceptable values are 'nominal', 'ordinal', 'interval', 'ratio'
    """

    metrics = {'nominal': lambda x, y: int(x != y),
               'ordinal': lambda row, lower, upper:
               (sum(row.loc[lower: upper]) -
                ((row.loc[lower] + row.loc[upper]) / 2)) ** 2,
               'interval': lambda x, y: (x - y) ** 2,
               'ratio': lambda x, y: ((x - y) / (x + y)) ** 2}

    diff_func = metrics.get(metric)
    if diff_func is None:
        raise ValueError(
            "Parameter metric expected one of ('nominal', 'ordinal', 'interval', 'ratio'), got {0}".format(metric))

    # comptue the coincidence matrix
    idx = sorted(set(filter(lambda x: pandas.notna(x), data.values.ravel())))
    cmx = pandas.DataFrame(0, index=idx, columns=idx)

    for col in data.columns:
        mu = len(data[col].dropna())
        pairings = itertools.permutations(data[col].dropna(), 2)
        counts = Counter(tuple(itm) for itm in pairings)
        for key, value in counts.items():
            cmx.loc[key] += value / (mu - 1)

    marginals = cmx.sum()
    n = marginals.sum()

    # Compute the difference matrix
    dmx = pandas.DataFrame(0, index=idx, columns=idx)
    for r, c in itertools.product(idx, idx):
        lower = c if c < r else r
        upper = r if c < r else c
        dmx.loc[r, c] = diff_func(lower, upper) if metric != 'ordinal' else diff_func(marginals, lower, upper)

    # combine the coincidence and difference matrices
    alpha_matrix = cmx * dmx

    # compute alpha
    do = 0
    de = 0
    for i, r in enumerate(marginals.index[:-1]):
        for c in marginals.index[i + 1:]:
            do += alpha_matrix.loc[r, c]
            de += marginals[r] * marginals[c] * dmx.loc[r, c]

    do *= (n - 1)
    alpha = 1 - (do / de)

    return alpha
