from . import constants
from matplotlib import pyplot as plt
import numpy
import os
import pandas
import seaborn

__all__ = ['disagreement_heatmap', 'reliability_line_plot']


def disagreement_heatmap(dataframe, title, fig_size=(10, 10), font_size=10):
    """
    create_disagreement_heatmaps(dataframe, by_session=False) -> None
    Generates a seaborn.heatmap of disagreements between raters on the specified coding property
    :param dataframe: The pandas.DataFrame from which to draw the heatmap. Index should be subjects, columns should be
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


def reliability_line_plot(frame: pandas.DataFrame, title="LinePlot", xlabel="x-axis", ylabel="y-axis",
                          rater_labels=None, width=11, height=8.5, xticks=None, yticks=None, **kwargs):
    """
    plots.reliability_line_plot(frame, **kwargs) --> matplotlib.Figure
    produces a reliability line plot from the specified
    :param frame: The DataFrame to provide data for the plot. Each column will become a line in the plot
    :param title: string specifying the title of the plot
    :param xlabel: keyword argument string specifying the label of the x-axis
    :param ylabel: keyword argument string specifying the title of the y-axis
    :param yticks: keyword argument sequence specifying ticks for the y-axis
    :param rater_labels: keyword argument dict mapping the column labels of frame to labels to be placed in the legend of the chart
    :param kwargs:
    :return: matplotlib.Figure
    """

    rater_labels = {} if rater_labels is None else rater_labels

    fig, axes = plt.subplots()  # type: plt.Figure, plt.Axes
    fig.set_size_inches(width, height)
    axes.set_xlabel(xlabel)
    axes.set_xticklabels(xticks if xticks is not None else frame.index.astype(str))
    axes.set_ylabel(ylabel)
    if yticks is not None:
        plt.yticks(yticks)
    axes.set_title(title)
    plt.xticks(rotation=90)

    for col in frame.columns:
        label = rater_labels.get(col, col)
        mask = numpy.isfinite(numpy.array(frame[col]).astype(numpy.float_))
        plt.plot(frame.index[mask], frame[col][mask], label=label, linestyle="-", marker="o")

    axes.legend()
    return fig
