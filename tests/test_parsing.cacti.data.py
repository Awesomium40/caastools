import caastools.parsing.cacti as cacti
import io
import unittest

VALID_CASAA = """Audio File:	G:\CAMI2_015_BL_06_EN.wav
0	0:00:27	0:00:45	4800000	8030000	5340	ST
1	0:00:45	0:00:53	8030000	9406000	5120	EC
2	0:00:53	0:00:54	9406000	9598000	17000	FN
3	0:00:54	0:01:07	9598000	11822000	5120	EC
4	0:01:07	0:01:21	11822000	14412000	5340	ST
5	0:01:21	0:01:22	14412000	14636000	5120	EC
6	0:01:22	0:01:24	14636000	14988000	17000	FN
7	0:01:24	0:01:34	14988000	16729600	5340	ST
8	0:01:34	0:01:44	16729600	18489600	5120	EC
9	0:01:44	0:01:52	18489600	19911200	5340	ST
10	0:01:52	0:01:57	19911200	20789200	1121	QUO-STD
11	0:01:57	0:02:07	20789200	22421200	11122	RD-2
12	0:02:07	0:02:09	22421200	22869200	11122	RD-2
13	0:02:09	0:02:18	22869200	24451200	11122	RD-2
14	0:02:18	0:02:19	24451200	24627200	2121	RES-STD
15	0:02:19	0:02:21	24627200	24915200	11122	RD-2
16	0:02:21	0:03:00	24915200	31921200	17000	FN
17	0:03:00	0:03:06	31921200	32879200	15122	OD-2
18	0:03:06	0:03:07	32879200	33087200	5310	FA
19	0:03:07	0:03:38	33087200	38573200	17000	FN
20	0:03:38	0:03:42	38573200	39165200	11122	RD-2
21	0:03:42	0:03:49	39165200	40522800	2221	REC-STD
22	0:03:49	0:03:54	40522800	41288800	17000	FN
23	0:03:54	0:04:06	41288800	43526800	2121	RES-STD
"""

VALID_CASAA_MISSING_CODES = """Audio File:	G:\CAMI2_015_BL_06_EN.wav
0	0:00:27	0:00:45	4800000	8030000	5340	ST
1	0:00:45	0:00:53	8030000	9406000         
2	0:00:53	0:00:54	9406000	9598000	17000	FN
3	0:00:54	0:01:07	9598000	11822000	5120	EC
4	0:01:07	0:01:21	11822000	14412000	5340	ST
5	0:01:21	0:01:22	14412000	14636000	5120	EC
"""

VALID_GLOBAL = """Global Ratings

Audio File:	G:\CAMI2_120_BL_02_EN.wav
All MISC Globals:	3
Therapist MISC Globals:	3
Spirit:	3
Collaboration:	4
Autonomy:	3
Evocation:	4
Acceptance:	5
Empathy:	4
Direction:	3
Client MISC Globals:	3
ClientSelfExplore:	4
LeeSelfExplore:	3
LeeCognitiveExplore:	4
LeeEmoExplore:	4
LeeNLExplore:	4
LeePRM_VM:	1
"""

VALID_GLOBAL_WITH_NOTES = """Global Ratings

Audio File:	G:\CAMI2_120_BL_02_EN.wav
All MISC Globals:	3
Therapist MISC Globals:	3
Spirit:	3
Collaboration:	4
Autonomy:	3
Evocation:	4
Acceptance:	5
Empathy:	4
Direction:	3
Client MISC Globals:	3
ClientSelfExplore:	4
LeeSelfExplore:	3
LeeCognitiveExplore:	4
LeeEmoExplore:	4
LeeNLExplore:	4
LeePRM_VM:	1

Notes:
Some notes entered here
"""

INVALID_GLOBAL_MISSING_DATA = """Global Ratings

Audio File:	G:\CAMI2_120_BL_02_EN.wav
All MISC Globals:	3
Therapist MISC Globals:
Spirit:	3
Collaboration:	4
"""

INVALID_GLOBAL_BAD_DATA = """Global Ratings

Audio File:	G:\CAMI2_120_BL_02_EN.wav
All MISC Globals:	3
Therapist MISC Globals:	toasty
Spirit:	3
Collaboration:	4
"""

INVALID_CASAA_TOO_FEW_COLUMNS = """Audio File:	G:\CAMI2_015_BL_06_EN.wav
0	0:00:27	0:00:45
1	0:00:45	0:00:53
2	0:00:53	0:00:54
3	0:00:54	0:01:07
4	0:01:07	0:01:21
5	0:01:21	0:01:22
6	0:01:22	0:01:24
7	0:01:24	0:01:34
8	0:01:34	0:01:44
9	0:01:44	0:01:52
10	0:01:52	0:01:57
"""

INVALID_GLOBAL_NO_SCORE = """Global Ratings

Audio File:	G:\CAMI2_120_BL_02_EN.wav
All MISC Globals:	
"""


class TestCactiParsing(unittest.TestCase):

    @staticmethod
    def bit_to_time(bit_stamp):
        channels = 2
        sample_rate = 44100
        bit_rate = 2
        bps = channels * sample_rate * bit_rate

        return (int(bit_stamp) - 44) / bps

    @classmethod
    def setUpClass(cls):

        cls._valid_casaa = io.StringIO(VALID_CASAA)
        cls._valid_casaa_missing_codes = io.StringIO(VALID_CASAA_MISSING_CODES)
        cls._invalid_casaa_columns = io.StringIO(INVALID_CASAA_TOO_FEW_COLUMNS)
        cls._valid_global = io.StringIO(VALID_GLOBAL)
        cls._valid_global_with_notes = io.StringIO(VALID_GLOBAL_WITH_NOTES)
        cls._invalid_global_missing_data = io.StringIO(INVALID_GLOBAL_MISSING_DATA)
        cls._invalid_global_bad_data = io.StringIO(INVALID_GLOBAL_BAD_DATA)

    def test_read_casaa(self):

        # Test basic reading capabilities
        audio_path, data = cacti.read_casaa(self._valid_casaa, read_codes=True)
        self.assertEqual(audio_path, r'G:\CAMI2_015_BL_06_EN.wav')
        self.assertEqual(len(data), 24)
        self.assertEqual(data[10][3], 1121)

        # Test attempt to read an invalid casaa file. Should raise exception
        with self.assertRaises(IndexError):
            audio_path, data = cacti.read_casaa(self._invalid_casaa_columns, read_codes=True)

        # Test attempt to read casaa file with missing codes. Should cause a UserWarning, but also provide the data
        with self.assertWarns(UserWarning):
            audio_path, data = cacti.read_casaa(self._valid_casaa_missing_codes, read_codes=True)
        self.assertEqual(audio_path, r'G:\CAMI2_015_BL_06_EN.wav')
        self.assertEqual(data[5][4], 'EC')

        # Rows with missing codes should have information in all columns except the last two, which are None
        self.assertIsNone(data[1][3])
        self.assertIsNone(data[1][4])
        self.assertAlmostEqual(data[1][1], self.bit_to_time(8030000), 4)
        self.assertAlmostEqual(data[1][2], self.bit_to_time(9406000), 4)

    def test_read_global(self):

        # Test the basic reading capabilities
        path, data = cacti.read_globals(self._valid_global)

        self.assertEqual(path, r'G:\CAMI2_120_BL_02_EN.wav')
        self.assertEqual(len(data), 16)

        # Global files have the capability to read notes - file with notes should raise a warning, but not
        # actually read in any of the notes
        with self.assertWarns(UserWarning):
            path, data = cacti.read_globals(self._valid_global_with_notes)

        # Attempting to read a file with missing data should raise a warning,
        # but continue on, skipping the missing data
        with self.assertWarns(UserWarning):
            path, data = cacti.read_globals(self._invalid_global_missing_data)
            self.assertEqual(path, "G:\CAMI2_120_BL_02_EN.wav")
            self.assertEqual(len(data), 3)
            self.assertEqual(data[2][1], 4)
            self.assertEqual(data[2][0], 'Collaboration')

        # Although missing data is considered valid, data that is not parsable to integer is not
        # Should raise an exception and abort the parsing when attempting to parse bad data
        with self.assertRaises(ValueError):
            path, data = cacti.read_globals(self._invalid_global_bad_data)

    @classmethod
    def tearDownClass(cls):
        cls._valid_casaa.close()
        cls._invalid_casaa_columns.close()


suite = unittest.TestLoader().loadTestsFromTestCase(TestCactiParsing)
unittest.TextTestRunner(verbosity=2).run(suite)
