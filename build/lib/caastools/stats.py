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


def __crosstab__(rows, columns):

    all_values = sorted(set(filter(lambda x: pandas.notna(x), itertools.chain(rows, columns))))

    if len(all_values) == 0:
        logging.warning("Unable to compute cohen's kappa because no non-missing values were found")
        return numpy.NaN, numpy.NaN, numpy.NaN

    index = pandas.Categorical(rows, categories=all_values)
    cols = pandas.Categorical(columns, categories=all_values)

    ct = pandas.crosstab(index, cols, normalize=True, dropna=False)

    return ct, index, cols


def __k__(ct: pandas.DataFrame, row_cats, col_cats, weight=None):

    weight_funcs = {None: lambda x, y: 0 if x == y else 1,
                    'linear': lambda x, y: abs(x - y),
                    'quadratic': lambda x, y: (x - y) ** 2,
                    }

    diff_func = weight_funcs.get(weight)
    if diff_func is None:
        raise ValueError("Invalid weight specification")

    # Get the marginal totals to compute expected agreement matrix later
    col_totals = ct.sum(axis=0, skipna=True)
    row_totals = ct.sum(axis=1, skipna=True)

    # Compute the weighting matrix
    row_idx = range(len(row_cats))
    col_idx = range(len(col_cats))
    wm = pandas.DataFrame(data=numpy.array([[diff_func(r, c) for c in col_idx] for r in row_idx]),
                          index=ct.index, columns=ct.columns)

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

    percent = (iteration / float(total))
    #percent = ("{0:." + str(decimals) + "f}").format(100 * (iteration / float(total)))
    filledLength = int(length * iteration // total)
    bar = fill * filledLength + '-' * (length - filledLength)
    print(f"\r{prefix} |{bar}| {percent:.2%} {suffix} ", end=printEnd)
    #print('\r%s |%s| %s%% %s' % (prefix, bar, percent, suffix), end=printEnd)
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
                    out.write(f"{alpha:.3f}, {{{lower:.3f}, {upper:.3f}}}\n")
                    out.write(sep)
                    out.write("Probability of failing to atttain selected values of alpha:\n")
                    for i, level in enumerate(alpha_levels):
                        out.write(f"{level:<.2f}: {probabilities[i]:<.3f}\n")
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
            _progress_bar_(i + 1, n_boot, "Bootstrapping progress:")

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

    ct, index, cols = __crosstab__(rows, columns)
    if ct is not numpy.NaN:
        row_cats = index.categories
        col_cats = cols.categories
        k, kmax = __k__(ct, row_cats, col_cats, weight=weight)
    else:
        k, kmax = (numpy.NaN, numpy.NaN)

    return k, kmax


def fleiss(subjects, raters, categories):
    """
    stats.fleiss(frame: pandas.DataFrame) -> float
    Computes the fleiss multirater kappa from the provided count data
    :param subjects: pandas Series or numpy array-like containing the subject of each observation
    :param raters: pandas Series or numpy array-like containing the rater for each observation
    :param categories: pandas Series or numpy array-like containing category assigned to each observation
    :return: float
    """

    # First thing for a fleiss coefficient is to extract the necessary count data
    subject_column = 'subject'
    rater_column = 'rater'
    category_column = 'category'
    frame = pandas.DataFrame({subject_column: subjects,
                              rater_column: raters,
                              category_column: categories})

    counts = frame.pivot_table(values=rater_column, index=subject_column, columns=category_column,
                               aggfunc=numpy.count_nonzero, fill_value=0)

    # Get number of subjects and categories
    N, k = counts.shape
    obs_count = counts.sum().sum()

    # number of raters
    n = obs_count // N

    # pj = proportion of agreement for the jth category
    pj = counts.sum() / obs_count

    # pi = proportion of agreement for the ith subject
    pi = (1 / (n * (n - 1))) * ((counts ** 2).sum(axis=1) - n)

    # pobs = proportion of observed agreement
    pobs = pi.sum() / N

    # pe = proportion of agreement expected by chance
    pe = (pj ** 2).sum()

    k = (pobs - pe) / (1 - pe)

    return k


def icc(frame: pandas.DataFrame, model=2, measures='single', agreement='A'):
    """
    Compute Intraclass Correllation Coefficient
    Formulas drawn from: McGraw, K. O. & Wong, S.P. (1996). Forming inferences about some intraclass
    correlation coefficients. Psychological Methods, 1(1), 30-46.
    :param frame: The pandas.DataFrame from which to compute the ICC. Frame should be structured S.T.
    raters are represented by columns, subjects are represented by rows, and observations are cells
    :param model: ICC model to use (From McGraw & Wong): 1 (One-way random effects), 2 (two-way random effects),
    or 3 (two-way mixed effects). Default 2
    :param measures: to compute single measures ('single') or average measures ('average') icc. Default 'single'
    :param effects: compute random effects ('random') or mixed effects ('mixed') icc. Default 'mixed'
    :param agreement: compute consistency ('C') or absolute agreement ('A') icc. Default 'A'
    :return: tuple[float, float, float] The intraclass correlation coefficient, F and associated p-value
    :raises ValueError: If frame has fewer than 2 rows or columns
    """
    n, k = frame.shape

    if n < 2:
        raise ValueError("Unable to compute an ICC because fewer than 2 rows with non-missing data were found")
    if k < 2:
        raise ValueError("Unable to compute an ICC because fewer than 2 raters were found")

    """
    Degrees of Freedom (From McGraw & Wong) & their corresponding values here
    Case1: One-way random effects:
        df Between rows (n - 1): df_subjects (n - 1)
        df Within rows n(k - 1): df_within_rows n * (k - 1)

    Case2: Two-way random with/without interaction:
        df Between rows (n - 1): df_subjects (n - 1)
        df Within rows n(k - 1): df_within_rows n * (k - 1)
            Between Columns k - 1: df_raters (k - 1)
            Error (n - 1)(k - 1): df_error (n - 1) * (k - 1)

    Case 3: Two-way mixed model, with/without interaction
        df Between Rows (n - 1): df_subjects (n - 1)
        df Within Rows n(k - 1): df_within_rows: n * (k - 1)
            Between columns (k - 1): df_raters (k - 1)
            Error (n - 1)(k -1): df_error (n - 1) * (k - 1)

    Mean Squares (From McGraw & Wong) & their corresponding values here
    Case1: One-way random effects:
        ms Between rows MSr: ms_subjects
        ms Within rows MSw: ms_within_subjects

    Case2: Two-way random with/without interaction:
        ms Between rows MSr: ms_subjects
        ms Within rows MSw: ms_within_subjects 
            Between Columns MSc: ms_raters
            Error MSe: ms_error

    Case 3: Two-way mixed model, with/without interaction
        ms Between rows MSr: ms_subjects
        ms Within rows MSw: ms_within_subjects 
            Between Columns MSc: ms_raters
            Error MSe: ms_error
    """
    forms = \
    {
        1:
            {'single': lambda msr, msw, k: (msr - msw) / (msr + (k - 1) * msw),
             'average': lambda msr, msw: (msr - msw) / msw},
        2:
            {'single':
                 {'C': lambda msr, mse, k: (msr - mse) / (msr + (k - 1) * mse),
                  'A': lambda msr, mse, msc, k, n: (msr - mse) / (msr + ((k - 1) * mse) + ((k/n) * (msc - mse)))
                  },
             'average':
                 {'C': lambda msr, mse: (msr - mse) / msr,
                  'A': lambda msr, mse, msc, n: (msr - mse) / (msr + ((msc - mse) /n))
                  }
             },
        3:
            {'single':
                 {'C': lambda msr, mse, k: (msr - mse) / (msr + (k - 1) * mse),
                  'A': lambda msr, mse, msc, k, n: (msr - mse) / (msr + ((k - 1) * mse) + ((k/n) * (msc - mse)))
                  },
             'average':
                 {'C': lambda msr, mse: (msr - mse) / msr,
                  'A': lambda msr, mse, msc, n: (msr - mse) / (msr + ((msc - mse) / n))
                  }
             }
    }

    formula = forms.get(model).get(measures) if model == 1 else forms.get(model).get(measures).get(agreement)

    if formula is None:
        raise ValueError("Invalid specification for ICC.\n" +
                         "model expected (1, 2, 3)\n" +
                         "measures expected ('single', 'random')\n" +
                         "effects expected ('random', 'mixed')\n" +
                         "agreement expected ('A', 'C')")

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

    # arguments for the ICC function, determined by the model and parameters specified
    formula_args = \
        {
            1:
                {'single': (ms_subjects, ms_within_subjects, k),
                 'average': (ms_subjects, ms_within_subjects)},
            2:
                {'single':
                     {'C': (ms_subjects, ms_error, k),
                      'A': (ms_subjects, ms_error, ms_raters, k, n)
                      },
                 'average':
                     {'C':  (ms_subjects, ms_error),
                      'A': (ms_subjects, ms_error, ms_raters, n)
                      }
                 },
            3:
                {'single':
                     {'C': (ms_subjects, ms_error, k),
                      'A': (ms_subjects, ms_error, ms_raters, k, n)
                      },
                 'average':
                     {'C': (ms_subjects, ms_error),
                      'A': (ms_subjects, ms_error, ms_raters, n)
                      }
                 }
    }

    args = formula_args[model][measures] if model == 1 else formula_args[model][measures][agreement]
    coeff = formula(*args)

    f = ms_subjects / ms_error

    return coeff, f, stats.f.sf(f, df_subjects, df_error)


def kalpha(data, metric='nominal', boot=None, out=None):
    """
    stats.k_alpha(data, metric='nominal') -> float
    Computes Krippendorf's alpha-reliability for the provided DataFrame
    Data should be structured S.T. raters are the index,
    subjects are the columns, and observations are the cell values
    :param data: pandas.DataFrame holding the observational data
    :param metric: string specifying the type of data/metric. Default 'nominal'
    Acceptable values are 'nominal', 'ordinal', 'interval', 'ratio'
    :param boot: number of samples to take for bootstrapping the CI, or None if no bootstrapping desired.
    Specifying fewer than 1000 for boot causes it to be set to 1000. Values are rounded down to the nearest 1000
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
        pairs = itertools.permutations(c, 2)
        for itm in pairs:
            yield tuple(itm)

    metrics = {'nominal': lambda x, y: int(x != y),
               'ordinal': lambda row, lower, upper:
               (sum(row.loc[lower: upper]) -
                ((row.loc[lower] + row.loc[upper]) / 2)) ** 2,
               'interval': lambda x, y: (x - y) ** 2,
               'ratio': lambda x, y: ((x - y) / (x + y)) ** 2}

    alpha_levels = [0.5, 0.6, 0.67, 0.7, 0.8, 0.9]  # used in bootstrapping to determine p of getting alpha levels
    upper, lower = (numpy.NaN, numpy.NaN)  # upper & lower confidence intervals of alpha when bootstrapping
    probabilities = [numpy.NaN for i in range(len(alpha_levels))]  # p of attaining values in alpha_levels

    diff_func = metrics.get(metric)
    if diff_func is None:
        raise ValueError(f"Parameter metric expected one of ('nominal', 'ordinal', 'interval', 'ratio'), got {metric}")

    idx = sorted(set(filter(lambda x: pandas.notna(x), data.values.ravel())))
    if len(idx) == 0:
        alpha, lower, upper = (numpy.NaN, numpy.NaN, numpy.NaN)
    else:
        cmx = pandas.DataFrame(0, index=idx, columns=idx)

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
            if n_boot < 1000:
                n_boot = 1000

            boot_samples = _alpha_boot_(data, boot, diff_func, de)

            if len(boot_samples) > 0:
                # Determine the probability of failing to attain specific values of alpha
                boot_samples.sort()
                probabilities = [bisect_left(boot_samples, l) / n_boot for l in alpha_levels]
                lower, upper = numpy.quantile(boot_samples, q=(.025, .975))

        if out is not None:
            __alpha_out__(out, cmx, dmx, alpha, lower, upper, alpha_levels, probabilities)

    return alpha, lower, upper


def pabak(rater1, rater2):
    """
    stats.pabak(rows, colums) -> tuple[float, float, float]
    Computes the prevalance-adjusted, bias-adjusted kappa as described in:
    Byrt, T., Bishop, J., & Carlin, J. B. (1993). Prevalence, Bias, and Kappa.
    Journal of Clinical Epidemiology, 46(5), 423-429.
    :param rater1: The data from the first observer
    :param rater2: The data from the second observer
    :return: the PABAK statistic
    """

    ct, index, cols = __crosstab__(rater1, rater2)
    row_cats = index.categories
    col_cats = cols.categories

    # PABAK requires that values on the diagonal be replaced by their average
    # and that values off the diagonal be replaced with their average
    diag = numpy.diag(ct)
    diag_sum = diag.sum()
    grand_sum = ct.sum().sum()
    off_diag_sum = grand_sum - diag_sum
    diag_average = diag_sum / len(diag)
    off_diag_average = off_diag_sum / ((len(ct.index) * len(ct.columns)) - len(diag))

    adj_func = lambda row, col: diag_average if row == col else off_diag_average

    adjusted_xtab = pandas.DataFrame(numpy.array([[adj_func(row, col) for col in ct.columns] for row in ct.index]),
                                     columns=ct.columns, index=ct.columns)

    return __k__(adjusted_xtab, row_cats, col_cats, weight=None)
