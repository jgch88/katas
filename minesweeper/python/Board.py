class Board:
    def __init__(self, size={'rows': 10, 'cols': 10}):
        self._create_board(size)

    def view_board(self):
        return self._board

    def mines_remaining(self):
        return 10

    def _create_board(self, size):
        rows = size['rows']
        cols = size['cols']
        if rows < 1 or cols < 1:
            raise ValueError('Both rows and columns must be at least 1.')
        self._board = [[' ' for c in range(cols)] for r in range(rows)]

