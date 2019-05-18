import './Cell.dart';

class Board {
  final int _rows;
  final int _cols;
  String _status = 'Playing';
  List<List<Cell>> _board;

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

  _generate_mines() {

  }

}
