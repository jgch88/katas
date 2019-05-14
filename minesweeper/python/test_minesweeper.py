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

    def test_query_mines_remaining(self):
        minesweeper = Minesweeper()
        minesweeper.new_game()
        self.assertEqual(minesweeper.mines_remaining(), 10)

    def test_command_reveal_position(self):
        minesweeper = Minesweeper()
        minesweeper.new_game()
        minesweeper.reveal({
            'row': 0,
            'col': 0
        })

    def test_command_mass_reveal_position(self):
        minesweeper = Minesweeper()
        minesweeper.new_game()
        minesweeper.reveal({'row': 0,'col': 0})
        minesweeper.mass_reveal({'row': 0,'col': 0})

    def test_command_toggle_mine_marking(self):
        minesweeper = Minesweeper()
        minesweeper.new_game()
        minesweeper.toggle_mine_marking({'row': 0,'col': 0})

    def test_query_game_status(self):
        minesweeper = Minesweeper()
        minesweeper.new_game()
        self.assertEqual(minesweeper.status(), 'Playing')



if __name__ == '__main__':
    unittest.main()
