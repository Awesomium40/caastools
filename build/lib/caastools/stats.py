from bisect import bisect_left
from collections import Counter
from scipy import stats
import functools
import io
import itertools
import logging
import numpy
import pandas

logging.getLogger('caastools.stats').addHandler(logging.NullHandler())

__all__ = ['cohens_kappa', 'fleiss', 'icc', 'kalpha', 'pabak']


def _progress_bar_(iteration, total, prefix='', suffix='', decimals=1, length=50, fill='█', printEnd="\r"):
    """
    prints progress bar to the console window. Use inside of a loop to get the proper effect
    :param iteration: current iteration
    :param total: total iterations
    :param prefix: string to appear to the left of the progress bar
    :param suffix: string to appear to the right of the progress bar
    :param decimals: number of decimals to show in the pct complete
    :param length: length of the progress bar
    :param fill: character to fill in completed portion of progres bar
    :param printEnd: EOL character
    :return:
    """

    percent = ("{0:." + str(decimals) + "f}").format(100 * (iteration / float(total)))
    filledLength = int(length * iteration // total)
    bar = fill * filledLength + '-' * (length - filledLength)
    print('\r%s |%s| %s%% %s' % (prefix, bar, percent, suffix), end=printEnd)
    # Print New Line on Complete
    if iteration == total:
        print()


def __alpha_out__(out, cmx, dmx, alpha, lower, upper, alpha_levels, probabilities):
    sep = "===================================================\n\n"
    try:
        out.write("Coincidence matrix:\n")
    except io.UnsupportedOperation as uo_err:
        logging.error(str(uo_err))
    except AttributeError:
        try:
            with open(out, 'w') as out:
                out.write("Coincidence matrix:\n")
                out.write(cmx.to_string() + "\n")
                out.write(sep)
                out.write("Difference Matrix:\n")
                out.write(dmx.to_string() + "\n")
                out.write(sep)
                if lower != numpy.NaN and upper != numpy.NaN:
                    out.write("alpha, 95% CI:\n")
                    out.write("{0:.3f}, {{{1:.3f}, {2:.3f}}}\n".format(alpha, lower, upper))
                    out.write(sep)
                    out.write("Probability of failing to atttain selected values of alpha:\n")
                    for i, level in enumerate(alpha_levels):
                        out.write("{0:<.2f}: {1:<.3f}\n".format(level, probabilities[i]))
        except OSError as os_error:
            logging.error("Unable to create output because 'out' was an invalid file handle")


def _alpha_boot_(data, boot, diff_func, de):
    """
    _alpha_boot_(data, boot) -> list[float]
    Performs the Hayes bootstrapping algoritm for Krippendorf's alpha
    :param data: The dataframe on which alpha was to be computed
    :param boot: The number of bootstrapped samples from which to draw
    :return: list of bootstrapped alpha estimates
    """

    boot_samples = []
    n_boot = (boot // 1000) * 1000
    er = []  # list of error terms for the unique pairs in the dataset

    if n_boot < 1000:
        logging.warning("Minimum number of bootstraps is 1000. Setting boot to 1000 samples")
        n_boot = 1000

    # For bootstrapping, need to draw number of samples equivalent to the number of unique pairs in the sample
    bs_data: pandas.DataFrame = data.dropna(axis=1, thresh=2)
    mus = bs_data.notnull()
    n_pairs = ((mus.sum() * (mus.sum() - 1)).astype("Int64") // 2).sum()

    if n_pairs < 2:
        logging.info("Unable to perform bootstrapping because fewer than 2 pairable values were found" +
                     " from which to draw samples")
    else:

        # First, compute the error term for each unique pair of values
        for col in bs_data:
            column_data = bs_data[col].dropna()
            mu = len(column_data)
            for i, v1 in enumerate(column_data[:-1]):
                for v2 in column_data[i + 1:]:
                    diff = diff_func(v1, v2)
                    e = 2 * (diff / de)
                    delta = e / (mu - 1)
                    er.append(delta)

        for i in range(n_boot):
            boot_alpha = 1
            bsd_nn = bs_data.notnull()
            # pair_count = int(((mus.sum() * (mus.sum() - 1)) // 2).sum())

            # For each pair randomly selected to be part of the sample (via a uniform distribution),
            # get its associated erorr term
            errors: numpy.ndarray = numpy.random.choice(er, size=n_pairs, replace=True)

            # according to the Hayes algorithm, alpha = 1 - (sum of all error terms for the sample drawn)
            total_error = errors.sum()
            boot_alpha -= total_error
            boot_samples.append(boot_alpha)

    return boot_samples


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


def pabak(rater1, rater2):
    """
    stats.pabak(rows, colums) -> tuple[float, float, float]
    Computes the prevalance-adjusted, bias-adjusted kappa as described in:
    Byrt, T., Bishop, J., & Carlin, J. B. (1993). Prevalence, Bias, and Kappa.
    Journal of Clinical Epidemiology, 46(5), 423-429.
    :param rater1: The data from the first observer
    :param rater2: The data from the second observer
    :return: the PABAK statistic, prevalence index, and bias index
    """
    raise NotImplementedError()


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
    counts = frame[[subject_column,
                    rater_column,
                    category_column]].pivot_table(values=rater_column, index=subject_column, columns=category_column,
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

    # pe = proportion of agreement expected by chance
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


def kalpha(data, metric='nominal', boot=None, out=None, try_new=False):
    """
    stats.k_alpha(data, metric='nominal') -> float
    Computes Krippendorf's alpha-reliability for the provided DataFrame
    Data should be structured S.T. raters are the index,
    subjects are the columns, and observations are the cell values
    :param data: pandas.DataFrame holding the observational data
    :param metric: string specifying the type of data/metric. Default 'nominal'
    Acceptable values are 'nominal', 'ordinal', 'interval', 'ratio'
    :param boot: number of samples to take for bootstrapping the CI, or None if no bootstrapping desired
    :param out: file-like object or path to file to which to write output. Default None. Output includes
    coincidence matrix, delta matrix, and if bootstrapping, 95% CI and probabilities to attain various levels of alpha.
    :return tuple[float, float, float]: alpha and the lower/upper bounds of the 95% CI
    """

    def _exp_func_(marg, num, r, c):
        if r == c:
            result = marg[r] * (marg[c] - 1) / (num - 1)
        else:
            result = marg[r] * marg[c] / (num - 1)

        return result

    def _cmx_func_(column: pandas.Series):
        c = column.dropna()
        mu = len(c)
        pairs = itertools.permutations(c, 2)
        for itm in pairs:
            yield tuple(itm)

    metrics = {'nominal': lambda x, y: int(x != y),
               'ordinal': lambda row, lower, upper:
               (sum(row.loc[lower: upper]) -
                ((row.loc[lower] + row.loc[upper]) / 2)) ** 2,
               'interval': lambda x, y: (x - y) ** 2,
               'ratio': lambda x, y: ((x - y) / (x + y)) ** 2}

    alpha_levels = [0.5, 0.6, 0.67, 0.7, 0.8, 0.9]
    er = []

    diff_func = metrics.get(metric)
    if diff_func is None:
        raise ValueError(
            "Parameter metric expected one of ('nominal', 'ordinal', 'interval', 'ratio'), got {0}".format(metric))

    idx = sorted(set(filter(lambda x: pandas.notna(x), data.values.ravel())))
    if len(idx) == 0:
        alpha, lower, upper = (numpy.NaN, numpy.NaN, numpy.NaN)
    else:
        cmx = pandas.DataFrame(0, index=idx, columns=idx)
        # expect = cmx.copy()

        # compute the coincidence matrix
        counts = sum((Counter(_cmx_func_(data[col])) for col in data.columns), Counter())
        for key, value in counts.items():
            cmx.loc[key] = value

        marginals = cmx.sum()
        n = marginals.sum()

        # Functions for computing the difference and expected coincidence matrices
        diff_func = functools.partial(diff_func, marginals) if metric == 'ordinal' else diff_func
        exp_func = functools.partial(_exp_func_, marginals, n)

        # compute the matrix of expected coincidences
        expect = pandas.DataFrame(numpy.array([[exp_func(row, col) for col in idx] for row in idx]),
                                  columns=idx, index=idx)

        # Compute the difference matrix
        dmx = pandas.DataFrame(
            data=numpy.array([[diff_func(*((c, r) if c < r else (r, c))) for c in idx] for r in idx]),
            index=idx, columns=idx)

        # compute the matrix of observed disagreement
        dobs = cmx * dmx

        # compute the matrix of expected disagreement
        dexp = dmx * expect

        # compute alpha
        do = dobs.sum().sum()
        de = dexp.sum().sum()
        alpha = 1 - (do / de)

        # Perform the bootstrapping via the Hayes algorithm
        if boot is None:
            lower, upper = (numpy.NaN, numpy.NaN)
        else:
            n_boot = (boot // 1000) * 1000
            if n_boot < 1000: n_boot = 1000

            boot_samples = _alpha_boot_(data, boot, diff_func, de)

            if len(boot_samples) > 0:
                # Determine the probability of failing to attain specific values of alpha
                boot_samples.sort()
                probabilities = [bisect_left(boot_samples, l) / n_boot for l in alpha_levels]
                lower, upper = numpy.quantile(boot_samples, q=(.025, .975))
            else:
                upper, lower = (numpy.NaN, numpy.NaN)
                probabilities = [numpy.NaN for i in range(len(alpha_levels))]

        if out is not None:
            __alpha_out__(out, cmx, dmx, alpha, lower, upper, alpha_levels, probabilities)

    return alpha, lower, upper
