import unittest
from Cell import Cell

class TestCell(unittest.TestCase):

    def test_cell_shows_space_when_not_yet_revealed(self):
        cell = Cell('*')
        self.assertEqual(cell.display_value(), ' ')

    def test_cell_shows_actual_value_when_revealed(self):
        cell = Cell('*')
        self.assertEqual(cell.display_value(), ' ')
        cell.reveal()
        self.assertEqual(cell.display_value(), '*')

    def test_cell_can_be_marked_as_a_mine(self):
        cell = Cell('*')
        cell.toggle_mine_marking()
        self.assertEqual(cell.display_value(), '^')

    def test_cell_marked_cell_can_be_unmarked(self):
        cell = Cell('*')
        self.assertEqual(cell.display_value(), ' ')
        cell.toggle_mine_marking()
        self.assertEqual(cell.display_value(), '^')
        cell.toggle_mine_marking()
        self.assertEqual(cell.display_value(), ' ')

if __name__ == "__main__":
    unittest.main()
