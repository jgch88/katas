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

        if (self._value == ' '):
            return '.'

        return self._value

    def actual_value(self):
        return self._value

    def reveal(self):
        self._revealed = True

    def is_revealed(self):
        return self._revealed

    def is_marked(self):
        return self._marked

    def is_bomb(self):
        return self._value == '*'

    def has_bombs_around(self, number_of_bombs):
        self._value = number_of_bombs

    def toggle_mine_marking(self):
        if self._marked:
            self._marked = False
        else:
            self._marked = True
