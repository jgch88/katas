from math import sqrt
from random import randint
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
        cells_marked_as_mines = 0
        for row in self._board:
            for cell in row:
                if cell.is_bomb():
                    mines += 1
                if cell.is_marked():
                    cells_marked_as_mines += 1
        return mines - cells_marked_as_mines

    def add_mines(self, mines=None):
        if mines is None: # couldn't do mines=self._generate_mines() in the method signature
            mines = self._generate_mines()
        for mine in mines:
            row = mine['row']
            col = mine['col']
            self._board[row][col] = Cell('*')
        self._mine_positions = mines


    def reveal_position(self, position):
        row = position['row']
        col = position['col']
        cell = self._board[row][col]
        if cell.is_marked():
            return
        cell.reveal()
        if cell.is_bomb():
            self._status = 'Lose'
            self._reveal_all_mines()
            self._cross_out_wrongly_marked_cells()
            return
        bombs_count = self._count_bombs_surrounding_cell(position)
        if bombs_count > 0:
            cell.set_display_value(bombs_count)
            return
        neighbour_positions_to_reveal = self._get_valid_neighbours(position)
        # remove bombs
        neighbour_positions_to_reveal = list(filter(lambda p: not self._board[p['row']][p['col']].is_bomb(), neighbour_positions_to_reveal))
        # remove already revealed cells
        neighbour_positions_to_reveal = list(filter(lambda p: not self._board[p['row']][p['col']].is_revealed(), neighbour_positions_to_reveal))
        while len(neighbour_positions_to_reveal) > 0:
            self.reveal_position(neighbour_positions_to_reveal[0])
            neighbour_positions_to_reveal.pop(0)

    def mass_reveal_around_position(self, position):
        row = position['row']
        col = position['col']
        cell = self._board[row][col]
        if not cell.is_revealed():
            return

        marked_count = self._count_marked_neighbours_surrounding_cell(position)
        if marked_count != cell.actual_value():
            return

        valid_neighbours = self._get_valid_neighbours(position)
        for neighbour_position in valid_neighbours:
            self.reveal_position(neighbour_position)


    def toggle_mine_marking(self, position):
        row = position['row']
        col = position['col']
        cell = self._board[row][col]
        if cell.is_revealed():
            return
        cell.toggle_mine_marking()

    def status(self):
        if (self._all_cells_are_revealed_or_marked_as_mines() and self._status != 'Lose'):
            self._status = 'Win'
        return self._status

    def _reveal_all_mines(self):
        for mine in self._mine_positions:
            row = mine['row']
            col = mine['col']
            cell = self._board[row][col]
            cell.reveal()

    def _cross_out_wrongly_marked_cells(self):
        for row in self._board:
            for cell in row:
                if cell.is_marked() and not cell.is_bomb():
                    cell.toggle_mine_marking()
                    cell.set_display_value('X')
                    cell.reveal()

    def _generate_mines(self):
        rows = len(self._board)
        cols = len(self._board[0])
        mines_to_generate = round(sqrt(rows * cols))
        mine_list = []
        mines = set() # use a set to make sure it is unique
        
        while len(mines) != mines_to_generate:
            row = randint(0, rows - 1)
            col = randint(0, cols - 1)
            position = {
                'row': row,
                'col': col
            }

            prev_mines_length = len(mines)
            mines.add((row,col))
            new_mines_length = len(mines)

            if prev_mines_length != new_mines_length:
                mine_list.append(position)
        return mine_list

    def _count_marked_neighbours_surrounding_cell(self, position):
        marked_count = 0
        valid_neighbours = self._get_valid_neighbours(position)
        for neighbour_position in valid_neighbours:
            row = neighbour_position['row']
            col = neighbour_position['col']
            cell = self._board[row][col]
            if (cell.is_marked()):
                marked_count += 1
        return marked_count


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

