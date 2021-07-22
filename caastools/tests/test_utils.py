import unittest
from caastools import utils


class TestUtils(unittest.TestCase):

    def test_sanitize_for_spss(self):

        def repl_func(match_obj):

            def is_numeric(string):
                try:
                    float(string)
                except:
                    result = False
                else:
                    result = True
                return result

            repl_dict = {"+": "Pos", "-": "Neg"}
            sl = slice(*match_obj.span())
            matched_str = match_obj.string[sl]
            tail = match_obj.string[match_obj.span()[0] + 1:]
            return repl_dict[matched_str] if len(tail) == 0 or is_numeric(tail) else "_"

        find = ['+', '-']

        dirty = ["interview_name", "MISC_AD", "MISC_AD-", "Components_11", "MISC_RD+2",
                 "MISC_RD+Toasty", "QUO-CTD", "123interview_name"]
        clean = ["interview_name", "MISC_AD", "MISC_ADNeg", "Components_11", "MISC_RDPos2",
                 "MISC_RD_Toasty", "QUO_CTD", "interview_name"]

        for d, c in zip(dirty, clean):
            self.assertEqual(utils.sanitize_for_spss(d, find, repl_func), c)


suite = unittest.TestLoader().loadTestsFromTestCase(TestUtils)
unittest.TextTestRunner(verbosity=2).run(suite)