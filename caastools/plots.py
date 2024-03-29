from matplotlib import pyplot as plt
import numpy
import pandas
import typing


__all__ = ['disagreement_heatmap', 'reliability_plot', 'parsing_alignment_plot']


def _plot_parsing_axis_(results, category_names, ax, pad_first=False, enum_every=25):
    """
    Plots the parsing alignment axes
    :param results: dict[str: list]. Keys are identities of raters, values are lenghts of utterances
    :param category_names: list[int]: enumerations of utterances to be plotted
    :param ax: the pyplot.Axis object to use in plotting
    :param pad_first: Whether the first utterance in each rater's data should be trated as padding
    :param enum_every: how often to place a text displaying utterance enumeration. Default None
    :return: Axis with plots drawn
    """

    labels = list(results.keys())
    data = numpy.array(list(results.values()))
    data_cum = data.cumsum(axis=1)
    category_colors = plt.get_cmap('RdYlGn')(numpy.linspace(0.15, 0.85, data.shape[1])).tolist()
    if pad_first: category_colors[0] = [0, 0, 0, 0]

    ax.invert_yaxis()
    ax.xaxis.set_visible(False)
    ax.set_xlim(0, numpy.sum(data, axis=1).max())

    for i, (colname, color) in enumerate(zip(category_names, category_colors)):
        widths = data[:, i]
        starts = data_cum[:, i] - widths
        ax.barh(labels, widths, left=starts, height=0.5,
                label=colname, color=color, edgecolor='black')
        xcenters = starts + widths / 2

        if enum_every is not None and enum_every > 0:
            enum_every = int(enum_every)
            if i % enum_every == 0:
                for y, (x, c) in enumerate(zip(xcenters, widths)):
                    ax.text(x, y, str(colname), ha='center', va='center', color='black', fontsize='xx-small')

    return ax


def _compile_parsing_quantile(data, start_time, cutoff, rater_names, ax):

    STIME = 'start_time'
    ETIME = 'end_time'
    UL = 'utt_length'

    rater_data = []
    pad_first = False

    # First, need to locate the data in the current quantile for each rater
    for frame in data:
        idx = frame.loc[:, [STIME, ETIME]].loc[lambda x: x[STIME] >= start_time].loc[lambda x: x[STIME] < cutoff].index
        rater = frame.loc[idx, ('utt_enum', STIME, ETIME, UL)].copy()

        # Need to realign the quantile's data to the start time
        if rater.iloc[0].loc[STIME] > start_time:
            pad_first = True
            row = rater.loc[idx[0], :]
            rater.loc[idx[0] - 1] = [row[0] - 1, start_time, row[1], row[1] - start_time]
            rater.index += 1
            rater['utt_enum'] += 1
            rater.sort_index(inplace=True)

        rater_data.append(rater)

    joined = pandas.concat(rater_data, axis=1, keys=rater_names).reset_index(drop=True).fillna(0)
    return joined, pad_first


def disagreement_heatmap(dataframe, title, fig_size=(10, 10), font_size=10):
    """
    create_disagreement_heatmaps(dataframe, by_session=False) -> None
    Generates a seaborn.heatmap of disagreements between raters on the specified coding property
    :param dataframe: The pandas.DataFrame from which to draw the heatmap. Index should be subjects, columns should be
    :param title: The title for the plot
    :param fig_size: tuple of two integers that specifies the size of the plot in inches. Default (10, 10)
    :param font_size: integer that specifies the font size of text on the plot
    """

    filtered = dataframe.dropna()
    filtered = filtered.loc[filtered.iloc[:, 0] != filtered.iloc[:, 1]]
    xtab = pandas.crosstab(index=filtered.iloc[:, 0], columns=filtered.iloc[:, 1])
    fig, ax = plt.subplots()
    im = ax.imshow(xtab)

    # Make sure that all the tick labels are displayed
    ax.set_xticks(numpy.arange(len(xtab.columns)))
    ax.set_yticks(numpy.arange(len(xtab.index)))
    ax.set_xticklabels(xtab.columns)
    ax.set_yticklabels(xtab.index)
    plt.setp(ax.get_xticklabels(), rotation=90, ha="right", rotation_mode="anchor")

    # Draw the text in the heatmap
    for i in range(len(xtab.index)):
        for j in range(len(xtab.columns)):
            text = ax.text(j, i, xtab.iloc[i, j], ha="center", va="center", color="w", fontsize=font_size)

    if title is not None:
        ax.set_title(title)
    fig.set_size_inches(*fig_size)
    fig.tight_layout()
    return fig


def parsing_alignment_plot(data: typing.Sequence[pandas.DataFrame], title="ParsingPlot", width=11, height=8.5,
                           rater_names=None, quantiles=10, label_every=25):
    """
    parsing_alignment_plot(data, title="ParsingPlot", width=11, height=8.5,
                           quantiles=10, use_word_count=False, master_trainee=True) -> Figure
    Creates a plot of parsing alignment between raters using sequential data contained in
    :param data: sequence of DataFrames from which to draw parsing data.
    Frames must contain at least 3 columns whose names correspond to the names of
    Utterance.utt_enum.name, Utterance.utt_start_time, and Utterance.utt_end_time
    Frames must have a single integer-based index
    :param title: The title of the graph
    :param width: Width of the resulting plot
    :param height: Height of the plot
    :param quantiles: The number of equal-length quantiles into which to divide the interview.
    Each quantile will be plotted separately within the figure. Default 10
    :param rater_names: sequence of strings to specify rater represented by each frame. Default None
    :param label_every: integer specifying how often utterances should be labeled with their enumeration in the plot
    :return: pyplot.Figure
    """

    UL = 'utt_length'
    data = list(data)

    STIME = 'start_time'
    ETIME = 'end_time'
    rater_names = list(rater_names) if rater_names is not None else [f"R{i + 1}" for i, f in enumerate(data)]

    quantiles = int(quantiles) if quantiles >= 1 else 1
    for frame in data:
        frame[UL] = frame[ETIME] - frame[STIME]

    max_len = max(frame[UL].sum() for frame in data)
    cutoffs = [i * (max_len / 10) for i in range(1, quantiles)]
    cutoffs.append(max_len + 1)
    cutoffs.insert(0, 0)

    plot_items = plt.subplots(quantiles, figsize=(36, 10))
    fig: plt.Figure = plot_items[0]
    axes = plot_items[1] if quantiles > 1 else (plot_items[1],)
    fig.suptitle(title)

    # Make a plot for each quantile as specified by the cutoff points
    for i, c in enumerate(cutoffs[1:]):
        ax: plt.Axes = axes[i]
        start_time = cutoffs[i]

        quantile_data, pad_first = _compile_parsing_quantile(data, start_time, c, rater_names, ax)
        category_names = quantile_data.index
        result = {col: list(quantile_data.loc[:, (col, UL)]) for col in quantile_data.columns.get_level_values(0)}
        _plot_parsing_axis_(result, category_names, ax, pad_first, enum_every=label_every)

    return fig


def reliability_plot(interview_names, y, title="Reliability Line Plot", xlabel="interview", ylabel="count",
                     rater_labels=None, width=11, height=8.5, yticks=None):
    """
    plot.reliability_plot(interview_names, *y, title, **kwargs) -> Figure
    Draws a line plot for reliability visualization
    :param interview_names: Sequence of interview names to be plotted as the x-axis
    :param y: sequence of rater data to plot as the y-axis.
    Each dataset must be a sequence of equal length to interview_names
    :param title: Title for the plot
    :param xlabel: label for the x axis
    :param ylabel: label for the y axis
    :param rater_labels: Optional labels for raters
    :param width: width (in inches) of the returned figure
    :param height: height (in inches) of the returned figure
    :param yticks: Ticks for the y-axis. Optional
    :return: matplotlib.figure.Figure
    """

    rater_labels = (f"rater_{i}" for i in range(len(y))) if rater_labels is None else \
                   (rater_labels[i] if i < len(rater_labels) else f"rater_{i}" for i in range(len(y)))

    fig, axes = plt.subplots()  # type: plt.Figure, plt.Axes

    for rater, data in zip(rater_labels, y):
        axes.plot(data, label=rater)

    plt.xlabel(xlabel)
    plt.ylabel(ylabel)
    plt.title(title)
    plt.xticks(range(len(interview_names)), labels=(str(x) for x in interview_names), rotation=90)

    if yticks is not None:
        plt.ylim(0, yticks[-1] + 1)
        plt.yticks(yticks, [str(itm) for itm in yticks])

    axes.legend()
    return fig

