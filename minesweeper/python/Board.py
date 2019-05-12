class Board:
    def __init__(self, size={'rows': 10, 'cols': 10}):
        self._create_board(size)

    def view_board(self):
        return self._board

    def _create_board(self, size):
        rows = size['rows']
        cols = size['cols']
        self._board = [[' ' for c in range(cols)] for r in range(rows)]

