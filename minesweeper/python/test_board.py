import unittest
from Board import Board

class TestBoard(unittest.TestCase):

    maxDiff = None

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

    def test_board_shows_number_of_mines_remaining_correctly_after_marking_mines(self):
        board = Board()
        mines = [{ 'row': 0, 'col': 0 }]
        board.add_mines(mines)
        self.assertEqual(board.mines_remaining(), 1);
        board.toggle_mine_marking({ 'row': 0, 'col': 0 })
        self.assertEqual(board.mines_remaining(), 0);
        board.toggle_mine_marking({ 'row': 1, 'col': 0 })
        self.assertEqual(board.mines_remaining(), -1);

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
        board.add_mines(mines)
        board.reveal_position({
            'row': 1,
            'col': 1,
        })
        self.assertEqual(board.view_board(), [
            [' ', ' '],
            [' ', 3]
        ])

        # Test case 2
        size2 = {
            'rows': 3,
            'cols': 3
        }
        board2 = Board(size=size2)

        mines2 = [
            {
                'row': 0,
                'col': 0
            },
            {
                'row': 0,
                'col': 1
            },
            {
                'row': 0,
                'col': 2
            },
            {
                'row': 1,
                'col': 0
            },
            {
                'row': 1,
                'col': 2
            },
            {
                'row': 2,
                'col': 0
            },
            {
                'row': 2,
                'col': 1
            },
            {
                'row': 2,
                'col': 2
            },
        ]
        board2.add_mines(mines2)
        board2.reveal_position({
            'row': 1,
            'col': 1,
        })
        self.assertEqual(board2.view_board(), [
            [' ', ' ', ' '],
            [' ',  8 , ' '],
            [' ', ' ', ' '],
        ])

    def test_board_revealing_a_tile_will_also_reveal_neighbouring_tiles_until_they_reach_a_mine(self):
        size = {
            'rows': 3,
            'cols': 3
        }
        board = Board(size=size)

        mines = [
            {
                'row': 0,
                'col': 0
            },
        ]
        board.add_mines(mines)
        board.reveal_position({
            'row': 2,
            'col': 2,
        })
        self.assertEqual(board.view_board(), [
            [' ',  1 , '.'],
            [ 1 ,  1 , '.'],
            ['.', '.', '.'],
        ])

        # Test case 2
        size = { 'rows': 8,'cols': 10 }
        board = Board(size=size)
        mines = [
            { 'row': 0, 'col': 4 },
            { 'row': 0, 'col': 6 },
            { 'row': 0, 'col': 7 },
            { 'row': 2, 'col': 9 },
            { 'row': 3, 'col': 5 },
            { 'row': 4, 'col': 6 },
            { 'row': 5, 'col': 0 },
            { 'row': 5, 'col': 6 },
            { 'row': 6, 'col': 6 },
            { 'row': 7, 'col': 0 },
        ]
        board.add_mines(mines)
        board.reveal_position({ 'row': 0, 'col': 0 })
        self.assertEqual(board.view_board(), [
            ['.', '.', '.',  1 , ' ', ' ', ' ', ' ', ' ', ' '],
            ['.', '.', '.',  1 ,  1 , ' ', ' ', ' ', ' ', ' '],
            ['.', '.', '.', '.',  1 , ' ', ' ', ' ', ' ', ' '],
            ['.', '.', '.', '.',  1 , ' ', ' ', ' ', ' ', ' '],
            [ 1 ,  1 , '.', '.',  1 ,  3 , ' ', ' ', ' ', ' '],
            [' ',  1 , '.', '.', '.',  3 , ' ', ' ', ' ', ' '],
            [' ',  2 , '.', '.', '.',  2 , ' ', ' ', ' ', ' '],
            [' ',  1 , '.', '.', '.',  1 , ' ', ' ', ' ', ' '],
        ])

    def test_board_plays_a_full_game_correctly(self):
        size = { 'rows': 8,'cols': 10 }
        board = Board(size=size)
        mines = [
            { 'row': 0, 'col': 4 },
            { 'row': 0, 'col': 6 },
            { 'row': 0, 'col': 7 },
            { 'row': 2, 'col': 9 },
            { 'row': 3, 'col': 5 },
            { 'row': 4, 'col': 6 },
            { 'row': 5, 'col': 0 },
            { 'row': 5, 'col': 6 },
            { 'row': 6, 'col': 6 },
            { 'row': 7, 'col': 0 },
        ]
        board.add_mines(mines)
        board.reveal_position({ 'row': 0, 'col': 0 })
        self.assertEqual(board.status(), 'Playing')


if __name__ == '__main__':
    unittest.main()
