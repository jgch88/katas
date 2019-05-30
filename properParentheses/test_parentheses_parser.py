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

        self.assertEqual(parser.validate('()'), True)

    def test_parser_validates_nested_parentheses_correctly(self):
        parser = ParenthesesParser()
        self.assertEqual(parser.validate(')('), False)

        self.assertEqual(parser.validate('((())())()'), True) # book example
        self.assertEqual(parser.validate(')()('), False) # book example
        self.assertEqual(parser.validate('())'), False) # book example
        # ({)} should be wrong

    def test_parser_can_validate_and_provide_more_information(self):
        parser = ParenthesesParser()
        # Design: if it returns -1, the string has no error
        # otherwise, return index of first offending parentheses 0 to n-1
        self.assertEqual(parser.validation_error_position('()'), -1)

        # Either we're trying to pop a closing bracket that doesn't have a opening
        # bracket before it
        self.assertEqual(parser.validation_error_position(')()('), 0)

        # Or we have an unclosed open backet
        self.assertEqual(parser.validation_error_position('()('), 2)
        self.assertEqual(parser.validation_error_position('()(('), 3)

