import './Board.dart';
import './Timer.dart';

class Minesweeper {
  Board _board;
  Timer _timer;

  Minesweeper() {
    this._timer = Timer();
  }

  void new_game() {
    this._board = Board();
    this._board.add_mines();
    this._timer.start();
  }

  List<List<String>> view_board() {
    return this._board.view_board();
  }

  int mines_remaining() {
    return this._board.mines_remaining();
  }

  void reveal(position) {
    this._board.reveal_position(position);
  }

  void mass_reveal(position) {
    this._board.mass_reveal_around_position(position);
  }

  void toggle_mine_marking(position) {
    this._board.toggle_mine_marking(position);
  }

  String status() {
    return this._board.status();
  }

  int time_elapsed() {
    return this._timer.seconds_elapsed();
  }
}
