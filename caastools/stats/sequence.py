import itertools
import numpy
import pandas
import scipy


def joint_frequencies(events, pre=None, post=None, lag=1, chisq=True):
    """
    Computes the matrix of transitions from events at lag lag
    :param events: list-like of events for which to compute transition probability matrix
    :param pre: list-like of pre-cursor events
    :param post: list-like of post-events
    :param lag: distance between pre- and post-events. Default 1
    :param chisq: Whether to compute chi-square stats on the computed joint frequency table
    :return: DataFrame with joint frequencies, chi-square, p-value, degrees of freedom
    """

    # Construct the basic dataframe with events for lag 0 and lag N
    lc = f'lag{lag}'
    event_data = pandas.DataFrame(numpy.array(events), columns=['lag0'])
    event_data[lc] = event_data['lag0'].shift(-lag).dropna()

    # Filter out rows that don't conform to user specs
    pre = pandas.Series(pre).unique() if pre is not None else event_data['lag0'].unique()
    post = pandas.Series(post).unique() if post is not None else event_data['lag0'].unique()
    filtered = event_data.loc[lambda x: (x['lag0'].isin(pre)) & (x[lc].isin(post)), :].dropna()

    # Compute the transition matrix, chi square, p, and dof
    jntf = pandas.crosstab(pandas.Categorical(filtered['lag0'], categories=sorted(pre)),
                           pandas.Categorical(filtered[lc], categories=sorted(post)), dropna=False)

    return jntf


def sequence_stats(jntf):
    """
    Computes the transition probability statistics for each transition in the matrix jntf
    :param jntf: pandas.DataFrame containing joint frequencies for transitions
    :return: DataFrame containing stats, table chi square, table p-value, degrees of freedom
    """

    td_columns = ['given', 'target', 'jntf', 'expf', 'conp', 'rsdl', 'adjr', 'pval', 'odds', 'lnor']
    transition_data = {x: [] for x in td_columns}

    for given, target in itertools.product(jntf.index.values, jntf.columns.values):
        transition_data['given'].append(given)
        transition_data['target'].append(target)

        # Collapse to a 2x2 table for computing cell stats
        a = jntf.loc[given, target]
        b = jntf.loc[given, jntf.columns != target].sum()
        c = jntf.loc[jntf.index != given, target].sum()
        d = jntf.loc[jntf.index != given, jntf.columns != target].sum().sum()

        ordf = pandas.DataFrame([[a, b], [c, d]])
        if any(ordf == 0):
            ordf = ordf + 0.1

        # Cell stats
        odds_ratio, pres = scipy.stats.fisher_exact(ordf)
        lnor = numpy.log(odds_ratio)
        exp = jntf.loc[given, :].sum() * jntf.loc[:, target].sum() / jntf.sum().sum()

        # The following are used to compute the adjusted residual
        nA = jntf.loc[:, target].sum()
        nB = jntf.loc[given, :].sum()
        N = jntf.sum().sum()

        # Adjusted residual
        adjr = (a - exp) / numpy.sqrt(nA * nB * (1 - nA / N) * (1 - nB / N) / N)

        transition_data['jntf'].append(a)
        transition_data['expf'].append(exp)
        transition_data['rsdl'].append(a - exp)
        transition_data['adjr'].append(adjr)
        transition_data['odds'].append(odds_ratio)
        transition_data['lnor'].append(lnor)
        transition_data['conp'].append(a / jntf.loc[given, :].sum())
        transition_data['pval'].append(pres)

    # Create a DF with the cell stats
    td = pandas.DataFrame(transition_data, columns=td_columns).set_index(['given', 'target'])

    # Perform a correction if any zero cells exist, to duplicate that computed by GSEQ
    if any(jntf == 0):
        jntf = jntf + 0.1
    c, p, dof, expected = scipy.stats.chi2_contingency(jntf)

    return td, c, p, dof