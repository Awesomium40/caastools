from caastools import datasets
from caastools.constants import CodingSystemType
from caastools.database.models import *
from caastools.datasets import save_as_spss
import os
import unittest

MISC = 'MISC'
COMP = 'Components'
IV = 'R31531'


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


# TODO Update tests once changes are finished
class TestDatasets(unittest.TestCase):

    def setUp(self):
        init_database(":memory:")
        script_dir = os.path.dirname(__file__)
        test_folder = os.path.join(script_dir, 'test_data', 'cacti')
        ptcs = os.path.join(test_folder, 'userConfiguration.xml')

        # upload_coding_system(CodingSystemType.CACTI, file_path=ptcs)
        # interview = upload_cacti_interview('R31531', 27, 5, 'HAEL002', 1, 9, 0, "CAMI_CACTI_1.0", MISC,
        #                                   COMP, r'./test_data/cacti/R31531.casaa',
        #                                   r'./test_data/cacti/R31531.globals', r'./test_data/cacti/R31531.parse',
        #                                   r'./test_data/cacti/R31531.globals')

    def tearDown(self):
        close_database()

    def test_build_sequential_dataset(self):

        # Once an interview has been uploaded, build the dataset
        data = datasets.build_sequential_dataframe(['R31531'])
        code_values = ['QUO-N', 'FN', 'AF', 'FN', 'QUC-N', 'FN', 'QUC-N', 'FN', 'QUC-N', 'FN', 'SU']

        comp_values = [1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 3]
        for i, row in enumerate(data.iterrows()):
            self.assertEqual(row[1][MISC], code_values[i])
            self.assertEqual(row[1][COMP], comp_values[i])

    def test_build_sl_dataset(self):

        true_values = {'Collaboration': 4, 'Autonomy': 4, 'Evocation': 5, 'Acceptance': 5,
                       'Empathy': 5, 'Direction': 5, 'ClientSelfExplore': 3, 'LeeCognitiveExplore': 3,
                       'LeeEmoExplore': 2, 'LeeNLExplore': 4, 'LeePRM_VM': 0, "MISC_AF": 1, 'MISC_FN': 5,
                       'MISC_QUC-N': 3, 'MISC_QUO-N': 1, 'MISC_SU': 1, "Components_1": 5, "Components_2": 5,
                       "Components_3": 1}

        data = datasets.build_session_level_dataframe([IV])

        # Check to make sure data matches expected values
        for key, value in true_values.items():
            self.assertEqual(data.loc[IV, key], value)

    def test_save_as_spss(self):
        data = datasets.build_session_level_dataframe([IV]).reset_index(drop=False)
        save_as_spss(data, r'd:\test_out.sav', find=['+', '-'], repl=repl_func)




