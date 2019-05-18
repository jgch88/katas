import 'dart:math';
import './Cell.dart';

class Board {
  final int _rows;
  final int _cols;
  String _status = 'Playing';
  List<List<Cell>> _board;
  List<Map> _mine_positions;

  Board({
    rows=10, 
    cols=10
  }) :
    _rows = rows, 
    _cols = cols, 
    _board = _createBoard(rows, cols);

  List<List<String>> view_board() {
    List<List<String>> displayed_board = [];
    for (var row in this._board) {
      List<String> displayed_row = row.map((r) => r.display_value()).toList();
      displayed_board.add(displayed_row);
    }
    return displayed_board;
  }

  static List<List<Cell>> _createBoard(rows, cols) {
    if (rows < 1 || cols < 1) {
      throw Exception('Both rows and columns must be at least 1.');
    }
    List<List<Cell>> board = [];
    for (int row = 0; row < rows; row++) {
      board.add([]);
      for (int col = 0; col < cols; col++) {
        board[row].add(Cell(' '));
      }
    }

    /* Why doesn't this work?
    List<List<Cell>> board = List.filled(
        rows, 
        List.filled(cols, Cell(' '), growable: false), 
        growable: false
    );
    */
    return board;
  }

  int mines_remaining() {
    int mines = 0;
    int cells_marked_as_mines = 0;
    for (var row in this._board) {
      for (var cell in row) {
        if (cell.is_bomb()) {
          mines += 1;
        }
        if (cell.is_marked()) {
          cells_marked_as_mines += 1;
        }
      }
    }
    return mines - cells_marked_as_mines;
  }

  void add_mines([mines = null]) {
    if (mines == null) {
      mines = this._generate_mines();
    }
    for (var mine in mines) {
      int row = mine['row'];
      int col = mine['col'];
      this._board[row][col] = Cell('*');
    }
    this._mine_positions = mines;
  }

  void toggle_mine_marking(position) {
    int row = position['row'];
    int col = position['col'];
    Cell cell = this._board[row][col];
    if (cell.is_revealed()) {
      return;
    }
    cell.toggle_mine_marking();
  }

  void reveal_position(position) {
    int row = position['row'];
    int col = position['col'];
    Cell cell = this._board[row][col];
    if (cell.is_marked()) {
      return;
    }
    cell.reveal();
    if (cell.is_bomb()) {
      this._status = 'Lose';
      this._reveal_all_mines();
      this._cross_out_wrongly_marked_cells();
      return;
    }
    int bombs_count = this._count_bombs_surrounding_cell(position);
    if (bombs_count > 0) {
      cell.set_display_value(bombs_count.toString());
      return;
    }
    List<Map> neighbour_positions_to_reveal = this._get_valid_neighbours(position);
    neighbour_positions_to_reveal = neighbour_positions_to_reveal.where((p) => !this._board[p['row']][p['col']].is_bomb()).toList();
    neighbour_positions_to_reveal = neighbour_positions_to_reveal.where((p) => !this._board[p['row']][p['col']].is_revealed()).toList();
    while (neighbour_positions_to_reveal.length > 0) {
      reveal_position(neighbour_positions_to_reveal[0]);
      neighbour_positions_to_reveal.removeAt(0);
    }
  }

  void _reveal_all_mines() {
    for (var position in this._mine_positions) {
      int row = position['row'];
      int col = position['col'];
      Cell cell = this._board[row][col];
      cell.reveal();
    }
  }

  void _cross_out_wrongly_marked_cells() {
    for (var row in this._board) {
      for (var cell in row) {
        if (cell.is_marked() && !cell.is_bomb()) {
          cell.toggle_mine_marking();
          cell.set_display_value('X');
          cell.reveal();
        }
      }
    }
  }

  List<Map> _get_valid_neighbours(position) {
    int row = position['row'];
    int col = position['col'];
    List<Map> positions = [];
    for (int i = row - 1; i < row + 2; i++) {
      for (int j = col - 1; j < col +2; j++) {
        positions.add({'row': i,'col': j});
      }
    }
    List<Map> valid_positions = positions.where((p) => p['row'] >= 0 && p['row'] < this._board.length && p['col'] >= 0 && p['col'] < this._board[0].length).toList();
    valid_positions = valid_positions.where((p) => p['row'] != row || p['col'] != col).toList();
    return valid_positions;
  }

  int _count_bombs_surrounding_cell(position) {
    int bomb_count = 0;
    List<Map> valid_neighbours = this._get_valid_neighbours(position);
    for (var neighbour_position in valid_neighbours) {
      int row = neighbour_position['row'];
      int col = neighbour_position['col'];
      Cell cell = this._board[row][col];

      if (cell.is_bomb()) {
        bomb_count += 1;
      }
    }

    return bomb_count;
  }

  String status() {
    if (this._all_cells_are_revealed_or_marked_as_mines() && this._status != 'Lose') {
      this._status = 'Win';
    }
    return this._status;
  }

  void mass_reveal_around_position(position) {
    int row = position['row'];
    int col = position['col'];
    Cell cell = this._board[row][col];
    if (!cell.is_revealed()) {
      return;
    }

    int marked_count = this._count_marked_neighbours_surrounding_cell(position);
    if (marked_count.toString() != cell.actual_value()) {
      return;
    }

    List<Map> valid_neighbours = this._get_valid_neighbours(position);
    for (var neighbour_position in valid_neighbours) {
      this.reveal_position(neighbour_position);
    }

  }

  int _count_marked_neighbours_surrounding_cell(position) {
    int marked_count = 0;
    List<Map> valid_neighbours = this._get_valid_neighbours(position);
    for (var neighbour_position in valid_neighbours) {
      int row = neighbour_position['row'];
      int col = neighbour_position['col'];
      Cell cell = this._board[row][col];
      if (cell.is_marked()) {
        marked_count += 1;
      }
    }

    return marked_count;
  }

  bool _all_cells_are_revealed_or_marked_as_mines() {
    for (var row in this._board) {
      for (var cell in row) {
        if (!(cell.is_revealed() || cell.is_marked())) {
          return false;
        }
      }
    }

    return true;
  }

  List<Map> _generate_mines() {
    int rows = this._board.length;
    int cols = this._board[0].length;
    int mines_to_generate = (sqrt(rows * cols)).round();
    List<Map> mine_list = [];
    var mines = Set();

    while (mines.length != mines_to_generate) {
      Random rand = Random();
      int row = rand.nextInt(rows);
      int col = rand.nextInt(cols);
      var position = {
        'row': row,
        'col': col
      };

      // This doesn't work the same way as python
      // there are no tuples in dart...
      int prev_mines_length = mines.length;
      mines.add(position);
      int new_mines_length = mines.length;

      if (prev_mines_length != new_mines_length) {
        mine_list.add(position);
      }
    }

    return mine_list;
  }

}
