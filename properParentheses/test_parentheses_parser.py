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

    def test_parser_can_validate_and_provide_more_information(self):
        parser = ParenthesesParser()
        # Design: if it returns -1, the string has no error
        # otherwise, return index of first offending parentheses 0 to n-1
        self.assertEqual(parser.validation_error_position('()'), -1)

        # Either we're trying to pop a closing bracket that doesn't have a opening
        # bracket before it
        self.assertEqual(parser.validation_error_position(')()('), 0) # book example

        # Or we have an unclosed open backet, where the closing bracket should be
        self.assertEqual(parser.validation_error_position('()('), 3)
        self.assertEqual(parser.validation_error_position('()(('), 4)
        self.assertEqual(parser.validation_error_position('()(()'), 5)

        self.assertEqual(parser.validation_error_position('())'), 2) # book example
        self.assertEqual(parser.validation_error_position('((())())()'), -1) # book example

    def test_parser_can_include_non_bracket_characters(self):
        parser = ParenthesesParser()
        self.assertEqual(parser.validate('(abc)'), True)

    def test_parser_can_parse_other_types_of_brackets(self):
        parser = ParenthesesParser()
        self.assertEqual(parser.validate('[a,b,c]'), True)
        self.assertEqual(parser.validate('{foo: "bar"}'), True)

    def test_parser_can_parse_multiple_bracket_combinations_correctly(self):
        parser = ParenthesesParser()
        self.assertEqual(parser.validation_error_position('({})'), -1)
        # shouldn't be able to close an opened bracket of a different type
        self.assertEqual(parser.validation_error_position('({)}'), 2)
        # ({a}: [abc])



