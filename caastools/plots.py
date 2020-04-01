from . import constants
from matplotlib import pyplot as plt
import os
import pandas
import seaborn

__all__ = ['create_disagreement_heatmaps']


def create_disagreement_heatmaps(dataframe, column_label, out_folder, by_condition=False):
    """
    create_disagreement_heatmaps(dataframe, by_session=False) -> None
    Generates a seaborn.heatmap of disagreements between raters on the specified coding property
    :param dataframe: the pandas sequential DataFrame from which to draw disagreement data
    :param column_label: The label of the column index whose data is to be used
    :param out_folder: the path at which to save the heatmap figures
    :param by_condition: Whether to generate heatmaps by condition (MI vs BA) or not. Default False. Not currently used
    """

    # Need to get the raters involved in the reliability
    # so that heatmaps can be made for each comparison
    raters = list(set(dataframe.index.get_level_values(constants.RID).values))
    
    # Need to filter the data to provide a simplified heatmap.
    # Involves removing the NaN values and also filtering out any place
    # where raters actually agree
    raw_data = dataframe[column_label].unstack(constants.RID).dropna()

    for i, rater1 in enumerate(raters[0:-1]):
        for rater2 in raters[i + 1:]:
            
            out_path = os.path.join(out_folder, "dm_heatmap({0}_{1}vs{2}).png".format(column_label, rater1, rater2))
            filtered = raw_data.loc[raw_data[rater1] != raw_data[rater2]]

            # Once all the disagreements are isolated, can create a crosstab
            # and use the resulting frame as input to a heatmap
            xtab = pandas.crosstab(index=filtered[rater1], columns=filtered[rater2])
            hm = seaborn.heatmap(xtab, annot=True, xticklabels=True, yticklabels=True)
            hm.figure.set_size_inches(10, 10, forward=False)
            hm.figure.savefig(out_path)


def reliability_line_plot(frame: pandas.DataFrame, **kwargs):
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

    title = kwargs.get('title', "LinePlot")
    x_label = kwargs.get('xlabel', 'x-axis')
    y_label = kwargs.get('ylabel', 'y-axis')
    rater_labels = kwargs.get('rater_labels', {})
    width = kwargs.get('width', 11)
    height = kwargs.get('height', 8.5)
    y_ticks = kwargs.get('yticks')

    fig, axes = plt.subplots()
    fig.set_size_inches(width, height)
    axes.set_xlabel(x_label)
    axes.set_ylabel(y_label)
    if y_ticks is not None:
        plt.yticks(y_ticks)
    axes.set_title(title)

    for col in frame.columns:
        label = rater_labels.get(col, col)
        axes.plot(frame.index, frame[col], label=label)

    axes.legend()
    return fig
