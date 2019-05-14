from Board import Board

class Minesweeper:
    """
    The Minesweeper game engine API
    """
    def __init__(self):
        pass

    def new_game(self):
        self._board = Board()
        self._board.add_mines()

    def view_board(self):
        return self._board.view_board()

    def mines_remaining(self):
        return self._board.mines_remaining()

    def reveal(self, position):
        self._board.reveal_position(position)
