import unittest
from Board import Board

class TestBoard(unittest.TestCase):

    def test_board_initialises_with_size_10x10(self):
        board = Board()
        self.assertEqual(board.view_board(),[
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

    def test_board_initialises_with_size_options(self):
        size = {
            'rows': 1,
            'cols': 1
        }
        board = Board(size=size)
        self.assertEqual(board.view_board(),[
            [' ']
        ])

    def test_board_cannot_initialise_with_0_rows_or_cols(self):
        size = {
            'rows': 0,
            'cols': 1
        }
        with self.assertRaises(ValueError):
            board = Board(size=size)

    def test_board_shows_number_of_mines_remaining(self):
        board = Board()
        self.assertEqual(board.mines_remaining(), 10)


if __name__ == '__main__':
    unittest.main()
