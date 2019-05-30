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
        # Maybe a tuple is more elegant?
        self._opening_parentheses = ['(', '[', '{']
        self._closing_parentheses_pair = {
            ')': '(',
            ']': '[',
            '}': '{',
        }

    def validate(self, string):
        # use a stack to validate whether string is valid
        # if character is an opening bracket, push it onto the stack
        # if character is a closing bracket, pop it off the stack.
        stack = []
        for character in string:
            if character in self._opening_parentheses:
                stack.append(character)
            if character in self._closing_parentheses_pair.keys():
                try:
                    if stack.pop() != self._closing_parentheses_pair[character]:
                        return False
                except IndexError: # popping an empty list
                    return False

        # if stack is balanced (equal number of opening/closing brackets)
        # stack at the end should be empty
        if len(stack) != 0:
            return False

        return True

    def validation_error_position(self, string):
        result = -1
        index = 0
        stack = []

        for character in string:
            if character in self._opening_parentheses:
                stack.append(character)
            if character in self._closing_parentheses_pair.keys():
                try:
                    if stack.pop() != self._closing_parentheses_pair[character]:
                        return index
                except IndexError:
                    # index of closing bracket that doesn't have 
                    # a prior opening bracket
                    return index
            index += 1

        # return last unclosed bracket's index
        if len(stack) != 0:
            # print('expected to close', stack[-1], 'at position', index)
            return index

        return -1

