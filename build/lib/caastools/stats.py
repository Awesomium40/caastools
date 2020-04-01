import itertools
import logging
import numpy
import pandas
from scipy import stats


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


def kalpha(data, data_type, missing):
    pass
