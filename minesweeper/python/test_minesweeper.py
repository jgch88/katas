import unittest
from Minesweeper import Minesweeper

class TestMinesweeper(unittest.TestCase):

    def test_can_create_a_new_game(self):
        minesweeper = Minesweeper()
        minesweeper.new_game()

if __name__ == '__main__':
    unittest.main()
