from constants import CLIENT_GLOBALS_SLICE, IaNodes, IaProperties, THERAPIST_GLOBALS_SLICE, SE_GLOBALS_SLICE
from parsing import reconstruct_ia, read_casaa, read_globals
import lxml.etree as et
import os
import unittest


class TestParsing(unittest.TestCase):

    @classmethod
    def setUpClass(cls):
        script_dir = os.path.dirname(os.path.realpath(__file__))
        data_folder = os.path.join(script_dir, "test_data", 'ia')
        cls._ia_files = [os.path.join(data_folder, f) for f in ('UC379 (1 of 2).xml', 'UC379 (2 of 2).xml')]
        cls._interview_name = 'UC379'
        cls._transform = et.XSLT(et.parse(os.path.join(script_dir, "..", "parsing", "interview_transform.xslt")))

    @classmethod
    def tearDownClass(cls):
        pass

    def test_reconstruct_ia(self):

        interview = reconstruct_ia(self._interview_name, self._ia_files)
        root = interview.getroot()
        ss_nodes = root.findall(IaNodes.SPEAKER_SEGMENTS)
        utt_nodes = root.findall(IaNodes.UTTERANCES)
        us_nodes = root.findall(IaNodes.UTT_SEGMENTS)
        up_nodes = root.findall(IaNodes.UTT_PROPERTIES)

        # The name of the interview should be 'UC379'
        self.assertEqual(root.find("Interviews/ID").text, self._interview_name)

        # The reconstructed interview should have a total of 3 SpeakerSegment elements
        self.assertEqual(len(ss_nodes), 3)

        # Elements should be renumbered properly
        for i, element in enumerate(sorted(ss_nodes, key=lambda x: int(x.find(IaProperties.LINE_NO).text)), 1):
            line_no = int(element.find(IaProperties.LINE_NO).text)
            self.assertEqual(line_no, i)

        # Should be 4 Utterances elements
        self.assertEqual(len(utt_nodes), 4)

        # should also be a total of 4 UtteranceSegments elements
        self.assertEqual(len(us_nodes), 4)

        # Finally, should be a total of 10 UtteranceProperties nodes
        self.assertEqual(len(up_nodes), 10)

    def test_read_globals(self):
        """

        :return:
        """

        """
        from the test data in /test_data/cacti
        Collaboration:	4
        Autonomy:	4
        Evocation:	5
        Acceptance:	5
        Empathy:	5
        Direction:	5
        ClientSelfExplore:	3
        LeeCognitiveExplore:	3
        LeeEmoExplore:	2
        LeeNLExplore:	4
        LeePRM_VM:	0
        """
        true_values = {'Collaboration': 4, 'Autonomy': 4, 'Evocation': 5, 'Acceptance': 5,
                       'Empathy': 5, 'Direction': 5, 'ClientSelfExplore': 3, 'LeeCognitiveExplore': 3,
                       'LeeEmoExplore': 2, 'LeeNLExplore': 4, 'LeePRM_VM': 0}

        global_path = r'./test_data/cacti/R31531.globals'
        global_dict = {tpl[0]: tpl[1] for tpl in read_globals(global_path,
                                                              (THERAPIST_GLOBALS_SLICE,
                                                               CLIENT_GLOBALS_SLICE,
                                                               SE_GLOBALS_SLICE))}

        for key, value in true_values.items():
            self.assertEqual(value, global_dict[key])

    def test_read_casaa(self):
        """
        :return:
        """
        true_values = ['QUO-N', 'FN', 'AF', 'FN', 'QUC-N', 'FN', 'QUC-N', 'FN', 'QUC-N', 'FN', 'SU']

        casaa_path = r'./test_data/cacti/R31531.casaa'
        data = read_casaa(casaa_path)

        for i, tpl in enumerate(data):
            self.assertEqual(tpl[-1], true_values[i])
