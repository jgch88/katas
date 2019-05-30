import unittest
from parentheses_parser import ParenthesesParser

class TestParenthesesParser(unittest.TestCase):
    """
    Documents how ParenthesesParser can be used via tests
    """
    
    def test_parser_can_initialise(self):
        ParenthesesParser()

    def test_parser_can_validate_a_bracket_string(self):
        p = ParenthesesParser()
        p.validate('')


