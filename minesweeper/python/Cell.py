class Cell:
    def __init__(self, value):
        self._value = value
        self._revealed = False
        self._marked = False

    def display_value(self):
        if (self._marked):
            return '^'

        if not (self._revealed):
            return ' '

        return self._value

    def actual_value(self):
        return self._value

    def reveal(self):
        self._revealed = True

    def mark_as_mine(self):
        self._marked = True
