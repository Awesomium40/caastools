from ..stats import irr, sequence
import itertools
import numpy
import pandas
import unittest


class SequenceTest(unittest.TestCase):

    def setUp(self) -> None:
        pass

    def tearDown(self) -> None:
        pass

    def test_transition_matrix(self):

        # Test that works as expected with a list, no filtration, at lag 1
        events = ['C', 'B', 'C', 'C', 'A', 'B', 'A', 'A', 'C', 'A', 'C', 'A', 'A', 'B', 'B', 'A', 'A', 'B', 'B', 'C']
        tm = sequence.joint_frequencies(events)

        expected = pandas.DataFrame([[3, 3, 2],
                                     [2, 2, 2],
                                     [3, 1, 1]], index=['A', 'B', 'C'], columns=['A', 'B', 'C'])

        for row, col in itertools.product(expected.index, expected.columns):
            self.assertAlmostEqual(expected.loc[row, col], tm.loc[row, col], delta=0.001)


        # Test that works as expected with a list, no filtration at lag > 1
        tm = sequence.joint_frequencies(events, lag=2)
        expected = pandas.DataFrame([[3, 4, 1],
                                     [3, 0, 2],
                                     [2, 1, 2]], index=['A', 'B', 'C'], columns=['A', 'B', 'C'])

        for row, col in itertools.product(expected.index, expected.columns):
            self.assertAlmostEqual(expected.loc[row, col], tm.loc[row, col], delta=0.001)

        # Test that works as expected with a list, filter pre-events at lag 1
        tm = sequence.joint_frequencies(events, pre=['A'])
        expected = pandas.DataFrame([[3, 3, 2]], index=['A'], columns=['A', 'B', 'C'])

        for row, col in itertools.product(expected.index, expected.columns):
            self.assertAlmostEqual(expected.loc[row, col], tm.loc[row, col], delta=0.001)

        # Test that works as expected with a list, filter post-events at lag 1
        tm = sequence.joint_frequencies(events, post=['B', 'C'])
        expected = pandas.DataFrame([[3, 2],
                                     [2, 2],
                                     [1, 1]], index=['A', 'B', 'C'], columns=['B', 'C'])

        for row, col in itertools.product(expected.index, expected.columns):
            self.assertAlmostEqual(expected.loc[row, col], tm.loc[row, col], delta=0.001)

        # Test that works as expected with a list, filter pre and post events at lag 1
        tm = sequence.joint_frequencies(events, pre=['A'], post=['B', 'C'])
        expected = pandas.DataFrame([[3, 2]], index=['A'], columns=['B', 'C'])

        for row, col in itertools.product(expected.index, expected.columns):
            self.assertAlmostEqual(expected.loc[row, col], tm.loc[row, col], delta=0.001)

    def test_transition_stats(self):

        jntf_idx = ['ELCTD', 'ELCTP', 'ELN', 'ELSTD', 'ELSTP', 'MIIN', 'MIREL', 'OTHER']
        jntf_cols = ['CTD', 'CTP', 'FN', 'STD', 'STP']

        exp_cols = ['given', 'target', 'jntf', 'expf', 'conp', 'rsdl', 'adjr', 'pval', 'odds', 'lnor']

        exp_raw = [['ELCTD', 'CTD', 2820, 747.6519, 0.72962, 2072.348, 92.53701, 0, 29.07529, 3.36989],
                   ['ELSTP', 'FN', 39, 124.0356, 0.19697, -85.03562, -12.5467, 0, 0.14395, -1.93832]]

        jntf_raw = [[2820, 65, 832, 146, 2],
                    [67, 939, 257, 24, 52],
                    [551, 232, 6795, 261, 41],
                    [86, 7, 307, 988, 9],
                    [5, 27, 39, 13, 114],
                    [32, 35, 162, 8, 5],
                    [114, 282, 1643, 46, 24],
                    [767, 339, 4350, 426, 51]]

        jntf = pandas.DataFrame(jntf_raw, index=jntf_idx, columns=jntf_cols)

        expm = pandas.DataFrame(exp_raw, columns=exp_cols).set_index(['given', 'target'])

        actm, c, p, dof = sequence.sequence_stats(jntf)

        # Test that transition statistics match expectations within 3 decimal places
        for r, c in itertools.product(expm.index.values, expm.columns.values):
            expected = expm.loc[r, c]
            actual = actm.loc[r, c]

            if isinstance(expected, (int, float, numpy.int64, numpy.float64)):
                self.assertAlmostEqual(expected, actual, 3)
            else:
                self.assertEqual(expected, actual)
