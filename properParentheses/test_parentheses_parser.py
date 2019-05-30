import unittest
from parentheses_parser import ParenthesesParser

class TestParenthesesParser(unittest.TestCase):
    """
    Documents how ParenthesesParser can be used via tests
    """
    
    def test_parser_can_initialise(self):
        ParenthesesParser()

    def test_parser_can_validate_a_bracket_string(self):
        parser = ParenthesesParser()
        parser.validate('')

    def test_parser_can_validate_bracket_strings_correctly(self):
        parser = ParenthesesParser()
        self.assertEqual(parser.validate(''), True)
        # (), )(, (abc) ((abc)) ({a}: [abc])

    def test_parser_validates_balanced_parentheses_correctly(self):
        parser = ParenthesesParser()
        self.assertEqual(parser.validate('('), False)

