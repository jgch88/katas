import 'package:test/test.dart';
import './Board.dart';

void main() {
  test('Board initialises with size 10x10', () {
    Board board = Board();
    expect(board.view_board(), [
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
    ]);
  });

  test('Board initialises with size options', () {
    Board board = Board(rows:1, cols:1);
    expect(board.view_board(), [
      [' ']
    ]);
  });

  test('Board cannot initialise with 0 rows or cols', () {
    expect(() => Board(rows:0, cols:1), throwsException);
  });

  test('Board shows number of mines remaining', () {
    Board board = Board();
    expect(board.mines_remaining(), 0);
  });

  test('Board shows number of mines remaining correctly after marking mines', () {
    Board board = Board();
    var mines = [{'row': 0, 'col': 0}];
    board.add_mines(mines);
    expect(board.mines_remaining(), 1);
    board.toggle_mine_marking({'row': 0, 'col':0});
    expect(board.mines_remaining(), 0);
    board.toggle_mine_marking({'row': 1, 'col':0});
    expect(board.mines_remaining(), -1);

  });

  test('Board can add mines', () {
    Board board = Board();
    var mines = [{ 'row': 0, 'col': 0}];
    board.add_mines(mines);
  });

  test('Board shows correct number of mines remaining', () {
    Board board = Board();
    var mines = [{'row': 0, 'col': 0}];
    board.add_mines(mines);
    expect(board.mines_remaining(), 1);
  });
}
