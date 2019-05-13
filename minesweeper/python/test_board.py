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
        self.assertEqual(board.mines_remaining(), 0);

    def test_board_can_add_mines(self):
        board = Board()
        mines = [
            {
                'row': 0,
                'col': 0
            }
        ]
        board.add_mines(mines)

    def test_board_shows_correct_number_of_mines_remaining(self):
        board = Board()
        mines = [
            {
                'row': 0,
                'col': 0
            }
        ]
        board.add_mines(mines)
        self.assertEqual(board.mines_remaining(), 1)

    def test_board_should_not_display_mines(self):
        board = Board()
        mines = [
            {
                'row': 0,
                'col': 0
            }
        ]
        board.add_mines(mines)
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

    def test_board_allows_cells_to_be_revealed(self):
        size = {
            'rows': 1,
            'cols': 1
        }
        board = Board(size=size)

        mines = [
            {
                'row': 0,
                'col': 0
            }
        ]
        board.add_mines(mines)
        self.assertEqual(board.view_board(),[
            [' ']
        ])

        position = {
            'row': 0,
            'col': 0,
        }
        board.reveal_position(position)
        self.assertEqual(board.view_board(),[
            ['*']
        ])

    def test_board_starts_as_not_game_over(self):
        board = Board()
        self.assertEqual(board.status(), 'Playing')

    def test_board_revealing_a_bomb_causes_game_over(self):
        size = {
            'rows': 2,
            'cols': 2
        }
        board = Board(size=size)

        mines = [
            {
                'row': 0,
                'col': 0
            }
        ]
        board.add_mines(mines)

        position = {
            'row': 0,
            'col': 0,
        }
        board.reveal_position(position)
        self.assertEqual(board.status(), 'Lose')

    def test_board_allows_cells_to_be_marked_as_mines(self):
        size = {
            'rows': 1,
            'cols': 1
        }
        board = Board(size=size)

        mines = [
            {
                'row': 0,
                'col': 0
            }
        ]
        board.add_mines(mines)

        position = {
            'row': 0,
            'col': 0,
        }
        board.toggle_mine_marking(position)
        self.assertEqual(board.view_board(),[
            ['^']
        ])

    def test_board_allows_cells_to_be_marked_as_mines_and_unmarked(self):
        size = {
            'rows': 1,
            'cols': 1
        }
        board = Board(size=size)

        mines = [
            {
                'row': 0,
                'col': 0
            }
        ]
        board.add_mines(mines)

        position = {
            'row': 0,
            'col': 0,
        }
        board.toggle_mine_marking(position)
        self.assertEqual(board.view_board(),[
            ['^']
        ])
        board.toggle_mine_marking(position)
        self.assertEqual(board.view_board(),[
            [' ']
        ])

    def test_board_revealing_all_tiles_and_marking_all_mines_causes_game_over(self):
        size = {
            'rows': 1,
            'cols': 1
        }
        board = Board(size=size)

        mines = [
            {
                'row': 0,
                'col': 0
            }
        ]
        board.add_mines(mines)

        position = {
            'row': 0,
            'col': 0,
        }
        board.toggle_mine_marking(position)
        self.assertEqual(board.view_board(),[
            ['^']
        ])
        self.assertEqual(board.status(), 'Win')

    def test_board_revealing_all_tiles_and_marking_all_mines_correctly_causes_game_over(self):
        size = {
            'rows': 2,
            'cols': 2
        }
        board = Board(size=size)

        mines = [
            {
                'row': 0,
                'col': 0
            },
            {
                'row': 1,
                'col': 1
            },
        ]
        board.add_mines(mines)
        board.toggle_mine_marking({
            'row': 0,
            'col': 0,
        })
        board.toggle_mine_marking({
            'row': 0,
            'col': 1,
        })
        board.reveal_position({
            'row': 1,
            'col': 0,
        })
        board.reveal_position({
            'row': 1,
            'col': 1,
        })
        self.assertEqual(board.status(), 'Lose')

    def test_board_revealing_a_tile_beside_a_bomb_displays_how_many_bombs_are_around_it(self):
        size = {
            'rows': 2,
            'cols': 2
        }
        board = Board(size=size)

        mines = [
            {
                'row': 0,
                'col': 0
            },
            {
                'row': 0,
                'col': 1
            },
            {
                'row': 1,
                'col': 0
            },
        ]
        board.reveal_position({
            'row': 1,
            'col': 1,
        })
        self.assertEqual(board.view_board(), [
            [' ', ' '],
            [' ', '3']
        ])


if __name__ == '__main__':
    unittest.main()
