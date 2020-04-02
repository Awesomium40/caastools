from caastools import plots
from matplotlib import pyplot as plt
import numpy
import pandas
import unittest


class TestPlots(unittest.TestCase):

    @classmethod
    def setUpClass(cls):
        data_c = {1: [1, 1, numpy.NaN, 1],
                  2: [2, 2, 3, 2],
                  3: [3, 3, 3, 3],
                  4: [3, 3, 3, 3],
                  5: [2, 2, 2, 2],
                  6: [1, 2, 3, 4],
                  7: [4, 4, 4, 4],
                  8: [1, 1, 2, 1],
                  9: [2, 2, 2, 2],
                  10: [numpy.NaN, 5, 5, 5],
                  11: [numpy.NaN, numpy.NaN, 1, 1],
                  12: [numpy.NaN, 3, numpy.NaN, numpy.NaN]}

        cls._test_data = pandas.DataFrame(data=data_c, index=['a', 'b', 'c', 'd'], columns=range(1, 13)).transpose()
        print(cls._test_data)

    def test_line_plot(self):

        fig: plt.Figure = plots.reliability_line_plot(self._test_data, )
        fig.show()


suite = unittest.TestLoader().loadTestsFromTestCase(TestPlots)
unittest.TextTestRunner(verbosity=2).run(suite)
