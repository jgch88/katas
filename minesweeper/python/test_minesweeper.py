import unittest
from Minesweeper import Minesweeper

class TestMinesweeper(unittest.TestCase):

    def test_command_create_a_new_game(self):
        minesweeper = Minesweeper()
        minesweeper.new_game()

    def test_query_view_the_board(self):
        minesweeper = Minesweeper()
        minesweeper.new_game()
        board = minesweeper.view_board()
        # by default, board initialises to 10 x 10 tiles
        # unrevealed tiles are marked by spaces ' '
        self.assertEqual(board, [
            [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
            [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
            [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
            [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
            [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
            [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
            [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
            [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
            [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
            [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
        ])

if __name__ == '__main__':
    unittest.main()
