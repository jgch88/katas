"""Parser classes.

Contains ParenthesesParser to validate strings.

"""
# Skiena (Algorithm Design Manual) Exercise 3-1
class ParenthesesParser:
    """
    ParenthesesParser has a collection of utility methods
    to check if a string of parentheses is properly nested and balanced

    Single reason to change: when the definition of utility methods
    changes
    """

    # Every left parentheses must have an accompanying right parentheses mapped as a dictionary
    def __init__(self):
        # Refactor later to allow user to define custom bracket pairs
        self._opening_parentheses = ['(', '[', '{', '<']
        self._closing_parentheses_pair = {
            ')': '(',
            ']': '[',
            '}': '{',
            '>': '<',
        }

    def add_custom_bracket_pair(self, opening, closing):
        """
        Allows user to add custom bracket pairs.

        p.add_custom_bracket_pair(opening="<", closing=">")
        """
        self._opening_parentheses.append(opening)
        self._closing_parentheses_pair[closing] = opening

    def validate(self, string):
        """
        Returns True if string provided has balanced and properly nested
        parentheses.
        """
        if not self.validation_error_position(string) == -1:
            return False
        return True

    def validation_error_position(self, string):
        """
        Returns -1 if string provided has balanced and properly nested
        parentheses. Otherwise, returns the position of the error.
        """
        # use a stack to validate whether string is valid
        # if character is an opening bracket, push it onto the stack
        # if character is a closing bracket, pop it off the stack.
        index = 0
        stack = []

        for character in string:
            if character in self._opening_parentheses:
                stack.append(character)
            elif character in self._closing_parentheses_pair.keys():
                # for a properly nested string, the closing bracket
                # should be able to find the opening bracket on the top of the stack
                try:
                    if stack.pop() != self._closing_parentheses_pair[character]:
                        return index
                except IndexError:
                    return index
            index += 1

        # stack should not be empty for a balanced string
        if stack:
            return index

        return -1
