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
        self._opening_parentheses = ['(']
        self._closing_parentheses_pair = {
            ')': '(',
        }

    def validate(self, string):
        # use a stack to validate whether string is valid
        # if character is an opening bracket, push it onto the stack
        # if character is a closing bracket, pop it off the stack.
        stack = []
        index = 0
        for character in string:
            if character in self._opening_parentheses:
                stack.append(character)

        # if stack is balanced (equal number of opening/closing brackets)
        # stack at the end should be empty
        if len(stack) != 0:
            return False

        return True
