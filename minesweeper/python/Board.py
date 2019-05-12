class Board:
    def __init__(self, size={'rows': 10, 'cols': 10}):
        self._create_board(size)

    def view_board(self):
        return self._board

    def mines_remaining(self):
        mines = 0
        for row in self._board:
            for col in row:
                for mine in col:
                    if mine == '*':
                        mines += 1
        return mines

    def add_mines(self, mines):
        for mine in mines:
            row = mine['row']
            col = mine['col']
            self._board[row][col] = '*'

    def _create_board(self, size):
        rows = size['rows']
        cols = size['cols']
        if rows < 1 or cols < 1:
            raise ValueError('Both rows and columns must be at least 1.')
        self._board = [[' ' for c in range(cols)] for r in range(rows)]

