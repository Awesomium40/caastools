from caastools.constants import IaNodes, IaAttributes
from caastools.parsing.ia import IaConfiguration, InterviewData
from caastools.parsing.ia.iaconfiguration import _IaConfiguration, _GlobalProperty, _Property, _PropertyValue
from caastools.parsing.ia.data import _Globals, _Interviews, _UtteranceProperties, _Utterances
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

        cs = IaConfiguration(r'.\test_data\ia\test_coding_system.xml')
        self.assertIsInstance(cs, _IaConfiguration)

        # CodingSystem should have 2 property elements
        properties = cs.findall(IaNodes.PROPERTY)
        self.assertEqual(len(properties), 2)

        # both properties should be instances of the _Property class
        for p in properties:
            self.assertIsInstance(p, _Property)

        # Properties should have PropertyID of 428 and 425
        for e_id, e_name, p in zip([425, 428], ["TBO", "Topic Codes"], properties):  # type: int, str, _Property
            self.assertEqual(e_id, p.property_id)
            self.assertEqual(e_name, p.property_name)

        # Property 425 should have 3 PropertyValue objects nested
        tbo = cs.find("Property[@PropertyID='425']")
        tbo_pv = list(tbo)
        self.assertEqual(len(tbo_pv), 3)

        # TBO PropertyValues should have values of '1.000', '2.000', '3.000'
        for e_value, pv in zip(['1.000', '2.000', '3.000'], tbo_pv):  # type: str, _PropertyValue
            self.assertEqual(e_value, pv.value)

    def test_reconstruct_interview(self):

        interview = InterviewData(self._interview_name, self._ia_files)
        root = interview.getroot()
        utt_nodes = root.findall(IaNodes.UTTERANCES)
        up_nodes = root.findall(IaNodes.UTT_PROPERTIES)
        global_nodes = root.findall(IaNodes.GLOBALS)

        # The name of the interview should be 'UC379'
        self.assertEqual(root.find("Interviews/ID").text, self._interview_name)

        # Should be 4 Utterances elements, all of type _Utterance
        self.assertEqual(len(utt_nodes), 4)
        for node in utt_nodes:
            self.assertIsInstance(node, _Utterances)

        # Should be 2 GLobals elements, both of type _Globals
        self.assertEqual(len(global_nodes), 2)
        for node in global_nodes:
            self.assertIsInstance(node, _Globals)

        # Finally, should be a total of 8 UtteranceProperties nodes
        self.assertEqual(len(up_nodes), 8)
        for node in up_nodes:
            self.assertIsInstance(node, _UtteranceProperties)

        # Utterances should be numbered properly and in the proper order
        for expected_id, expected_enum, node in zip([14050895, 14050896, 14051135, 14051250], range(1, 5), utt_nodes):
            self.assertEqual(expected_id, node.utterance_id)
            self.assertEqual(expected_enum, node.utterance_number)


suite = unittest.TestLoader().loadTestsFromTestCase(TestIaParsing)
unittest.TextTestRunner(verbosity=2).run(suite)
