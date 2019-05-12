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



if __name__ == '__main__':
    unittest.main()
