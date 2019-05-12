class Cell:
    def __init__(self, value):
        self._value = value
        self._revealed = False

    def display_value(self):
        return (self._value if self._revealed else ' ')

    def actual_value(self):
        return self._value

    def reveal(self):
        self._revealed = True
