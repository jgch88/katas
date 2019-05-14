from Board import Board

class Minesweeper:
    """
    The Minesweeper game engine API
    """
    def __init__(self):
        pass

    def new_game(self):
        self._board = Board()

    def view_board(self):
        return self._board.view_board()
