from Cell import Cell

class Board:
    def __init__(self, size={'rows': 10, 'cols': 10}):
        self._status = 'Playing'
        self._create_board(size)

    def view_board(self):
        displayed_board = []
        for row in self._board:
            displayed_row = list(map(lambda cell: cell.display_value(), row))
            displayed_board.append(displayed_row)
        return displayed_board

    def mines_remaining(self):
        mines = 0
        for row in self._board:
            for cell in row:
                if cell.actual_value() == '*':
                    mines += 1
        return mines

    def add_mines(self, mines):
        for mine in mines:
            row = mine['row']
            col = mine['col']
            self._board[row][col] = Cell('*')

    def reveal_position(self, position):
        row = position['row']
        col = position['col']
        cell = self._board[row][col]
        cell.reveal()
        if cell.actual_value() == '*':
            self._status = 'Lose'
            return
        bombs_count = self._count_bombs_surrounding_cell(position)
        if bombs_count > 0:
            cell.has_bombs_around(bombs_count)

    def toggle_mine_marking(self, position):
        row = position['row']
        col = position['col']
        cell = self._board[row][col]
        cell.toggle_mine_marking()

    def status(self):
        if (self._all_cells_are_revealed_or_marked_as_mines() and self._status != 'Lose'):
            self._status = 'Win'
        return self._status

    def _count_bombs_surrounding_cell(self, position):
        # get valid neighbours
        # if neighbour is bomb, add to bomb_count
        bomb_count = 0
        valid_neighbours = self._get_valid_neighbours(position)
        for neighbour_position in valid_neighbours:
            row = neighbour_position['row']
            col = neighbour_position['col']
            cell = self._board[row][col]
            if (cell.is_bomb()):
                bomb_count += 1
        return bomb_count

    def _get_valid_neighbours(self, position):
        row = position['row']
        col = position['col']
        positions = [{'row': r, 'col': c}
            for r in range(row - 1, row + 2) 
            for c in range(col - 1, col + 2)
        ]
        valid_positions = list(filter(lambda p: p['row'] >= 0 and p['row'] < len(self._board) and p['col'] >= 0 and p['col'] < len(self._board[0]), positions)) # exclude out of bounds positions
        valid_positions = list(filter(lambda p: p['row'] != row or p['col'] != col, valid_positions)) # exclude current position

        return valid_positions
        


    def _all_cells_are_revealed_or_marked_as_mines(self):
        for row in self._board:
            for cell in row:
                if not (cell.is_revealed() or cell.is_marked()):
                    return False
        return True

    def _create_board(self, size):
        rows = size['rows']
        cols = size['cols']
        if rows < 1 or cols < 1:
            raise ValueError('Both rows and columns must be at least 1.')
        self._board = [[Cell(' ') for c in range(cols)] for r in range(rows)]

