class Board:
    def __init__(self, size=[10,10]):
        self._create_board(size)

    def view_board(self):
        return self._board

    def _create_board(self, size):
        rows = size[0]
        cols = size[1]
        self._board = [[' ' for c in range(cols)] for r in range(rows)]

