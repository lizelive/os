import unittest

class TestParse(unittest.TestCase):
    def test_parse_bool(self):
        self.assertEqual(parse_bool("true"), True)
        self.assertEqual(parse_bool("false"), False)

    def test_parse_any(self):
        self.assertEqual(parse_any("true"), True)
        self.assertEqual(parse_any("false"), False)
        self.assertEqual(parse_any("1"), 1)
        self.assertEqual(parse_any("1.1"), 1.1)
        self.assertEqual(parse_any("hello"), "hello")

    def test_parse_argv(self):
        argv = ['/path/to/args.py', '--date', 'now', '--age', '5', '--age', '5.1', '--flag', '-f', '--funny']
        expected = {'date': 'now', 'age': [5, 5.1], 'flag': True, 'f': True, 'funny': True}
        self.assertDictEqual(parse_argv(argv), expected)
        self.assertDictEqual(parse_argv(argv[1:]), expected)


