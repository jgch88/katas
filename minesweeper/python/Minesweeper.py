from Board import Board
from Timer import Timer

class Minesweeper:
    """
    The Minesweeper game engine API
    """
    def __init__(self):
        self._timer = Timer()

    def new_game(self):
        self._board = Board()
        self._board.add_mines()
        self._timer.start()

    def view_board(self):
        return self._board.view_board()

    def mines_remaining(self):
        return self._board.mines_remaining()

    def reveal(self, position):
        self._board.reveal_position(position)

    def mass_reveal(self, position):
        self._board.mass_reveal_around_position(position)

    def toggle_mine_marking(self, position):
        self._board.toggle_mine_marking(position)

    def status(self):
        return self._board.status()

    def time_elapsed(self):
        return self._timer.seconds_elapsed()
