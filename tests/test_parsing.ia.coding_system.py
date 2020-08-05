from caastools.constants import IaNodes, IaAttributes
from caastools.parsing.ia import parse_coding_system, reconstruct_ia
import lxml.etree as et
import os
import unittest


class TestIaParsing(unittest.TestCase):

    @classmethod
    def setUpClass(cls):
        script_dir = os.path.dirname(os.path.realpath(__file__))
        data_folder = os.path.join(script_dir, "test_data", 'ia')
        cls._ia_files = [os.path.join(data_folder, f) for f in ('UC379 (1 of 2).xml', 'UC379 (2 of 2).xml')]
        cls._interview_name = 'UC379'

        cls._transform = et.XSLT(et.parse(os.path.join(script_dir, "..", "caastools", "parsing", "ia",
                                                       "interview_transform.xslt")))
        cls._cs_transform = et.XSLT(et.parse(os.path.join(script_dir, "..", "caastools", "parsing", "ia",
                                                          "cs_transform.xslt")))

    @classmethod
    def tearDownClass(cls):
        pass

    def test_parse_coding_system(self):

        cs = parse_coding_system(r'.\test_data\ia\UCHAT3.4_CodingSystem.xml')
        cs.find()


    def test_reconstruct_interview(self):

        interview = reconstruct_ia(self._interview_name, self._ia_files)
        root = interview.getroot()
        utt_nodes = root.findall(IaNodes.UTTERANCES)
        up_nodes = root.findall(IaNodes.UTT_PROPERTIES)
        global_nodes = root.findall(IaNodes.GLOBALS)

        # The name of the interview should be 'UC379'
        self.assertEqual(root.find("Interviews/ID").text, self._interview_name)

        # Should be 4 Utterances elements
        self.assertEqual(len(utt_nodes), 4)

        # Should be 2 GLobals elements
        self.assertEqual(len(global_nodes), 2)

        # Finally, should be a total of 8 UtteranceProperties nodes
        self.assertEqual(len(up_nodes), 8)


suite = unittest.TestLoader().loadTestsFromTestCase(TestIaParsing)
unittest.TextTestRunner(verbosity=2).run(suite)