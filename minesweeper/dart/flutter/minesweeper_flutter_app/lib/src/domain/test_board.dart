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

  test('Board should not display mines', () {
    Board board = Board();
    var mines = [{'row': 0, 'col': 0}];
    board.add_mines(mines);
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

  test('Board allows cells to be revealed', () {
    Board board = Board(rows:1, cols:1);
    var mines = [{'row': 0, 'col': 0}];
    board.add_mines(mines);
    expect(board.view_board(), [
      [' '],
    ]);
    var position = {'row': 0, 'col': 0};
    board.reveal_position(position);
    expect(board.view_board(), [
      ['*'],
    ]);
  });

  test('Board starts as not game over', () {
    Board board = Board();
    expect(board.status(), 'Playing');
  });

  test('Revealing a bomb causes game over', () {
    Board board = Board(rows:2, cols:2);
    var mines = [{'row': 0, 'col': 0}];
    board.add_mines(mines);
    var position = {'row': 0, 'col': 0};
    board.reveal_position(position);
    expect(board.status(), 'Lose');
  });

  test('Board allows cells to be marked as mines', () {
    Board board = Board(rows:1, cols:1);
    var mines = [{'row': 0, 'col': 0}];
    board.add_mines(mines);
    var position = {'row': 0, 'col': 0};
    board.toggle_mine_marking(position);
    expect(board.view_board(), [
      ['^'],
    ]);
  });

  test('Board allows cells to be marked as mines and unmarked', () {
    Board board = Board(rows:1, cols:1);
    var mines = [{'row': 0, 'col': 0}];
    board.add_mines(mines);
    var position = {'row': 0, 'col': 0};
    board.toggle_mine_marking(position);
    expect(board.view_board(), [
      ['^'],
    ]);
    board.toggle_mine_marking(position);
    expect(board.view_board(), [
      [' '],
    ]);
  });

  test('Board cannot reveal a cell that is marked as mine', () {
    Board board = Board(rows:2, cols:2);
    var mines = [{'row': 0, 'col': 0}];
    board.add_mines(mines);
    var position = {'row': 0, 'col': 0};
    board.toggle_mine_marking(position);
    board.reveal_position(position);
    expect(board.status(), 'Playing');
  });

  test('Board cannot mark an already revealed cell', () {
    Board board = Board(rows:2, cols:2);
    var mines = [{'row': 0, 'col': 0}];
    board.add_mines(mines);
    var position = {'row': 1, 'col': 1};
    board.reveal_position(position);
    board.toggle_mine_marking(position);
    expect(board.view_board(), [
      [' ', ' '],
      [' ', '1'],
    ]);
  });

  test('Revealing all tiles and marking all mines wins the game', () {
    Board board = Board(rows:1, cols:1);
    var mines = [{'row': 0, 'col': 0}];
    board.add_mines(mines);
    var position = {'row': 0, 'col': 0};
    board.toggle_mine_marking(position);
    expect(board.view_board(), [
      ['^'],
    ]);
    expect(board.status(), 'Win');
  });

  test('Revealing a tile beside a bomb displays how many bombs are around it', () {
    Board board = Board(rows:2, cols:2);
    var mines = [{'row': 0, 'col': 0}, {'row': 0, 'col': 1}, {'row': 1, 'col': 0}];
    board.add_mines(mines);
    var position = {'row': 1, 'col': 1};
    board.reveal_position(position);
    expect(board.view_board(), [
      [' ', ' '],
      [' ', '3'],
    ]);

    // Test case 2
    board = Board(rows:3, cols:3);
    mines = [{'row': 0, 'col': 0}, {'row': 0, 'col': 1}, {'row': 0, 'col': 2}, 
    {'row': 1, 'col': 0}, {'row': 1, 'col': 2},
    {'row': 2, 'col': 0}, {'row': 2, 'col': 1}, {'row': 2, 'col': 2}];
    board.add_mines(mines);
    position = {'row': 1, 'col': 1};
    board.reveal_position(position);
    expect(board.view_board(), [
      [' ', ' ', ' '],
      [' ', '8', ' '],
      [' ', ' ', ' '],
    ]);
  });

  test('Revealing a tile will also reveal neighbouring tiles until they reach a mine', () {
    Board board = Board(rows:3, cols:3);
    var mines = [{'row': 0, 'col': 0}];
    board.add_mines(mines);
    var position = {'row': 2, 'col': 2};
    board.reveal_position(position);
    expect(board.view_board(), [
      [' ', '1', '.'],
      ['1', '1', '.'],
      ['.', '.', '.'],
    ]);

    // Test case 2
    board = Board(rows:8, cols:10);
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
    ];
    board.add_mines(mines);
    position = {'row': 0, 'col': 0};
    board.reveal_position(position);
    expect(board.view_board(), [
      ['.', '.', '.', '1', ' ', ' ', ' ', ' ', ' ', ' '],
      ['.', '.', '.', '1', '1', ' ', ' ', ' ', ' ', ' '],
      ['.', '.', '.', '.', '1', ' ', ' ', ' ', ' ', ' '],
      ['.', '.', '.', '.', '1', ' ', ' ', ' ', ' ', ' '],
      ['1', '1', '.', '.', '1', '3', ' ', ' ', ' ', ' '],
      [' ', '1', '.', '.', '.', '3', ' ', ' ', ' ', ' '],
      [' ', '2', '.', '.', '.', '2', ' ', ' ', ' ', ' '],
      [' ', '1', '.', '.', '.', '1', ' ', ' ', ' ', ' '],
    ]);
  });

  test('Plays a full game correctly', () {
    Board board = Board(rows:8, cols:10);
    var mines = [
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
    ];
    board.add_mines(mines);
    board.reveal_position({ 'row': 0, 'col': 0 });
    expect(board.status(), 'Playing');
    expect(board.mines_remaining(), 10);
    board.toggle_mine_marking({ 'row': 5, 'col': 0 });
    expect(board.mines_remaining(), 9);
    board.reveal_position({ 'row': 6, 'col': 0 });
    board.toggle_mine_marking({ 'row': 7, 'col': 0 });
    expect(board.mines_remaining(), 8);
    board.toggle_mine_marking({ 'row': 0, 'col': 4 });
    board.reveal_position({ 'row': 0, 'col': 5 });
    board.reveal_position({ 'row': 1, 'col': 5 });
    board.reveal_position({ 'row': 2, 'col': 5 });

    board.toggle_mine_marking({ 'row': 3, 'col': 5 });
    board.reveal_position({ 'row': 1, 'col': 6 });
    board.reveal_position({ 'row': 2, 'col': 6 });
    board.reveal_position({ 'row': 3, 'col': 6 });

    board.toggle_mine_marking({ 'row': 0, 'col': 6 });
    board.reveal_position({ 'row': 2, 'col': 7 });

    board.toggle_mine_marking({ 'row': 0, 'col': 7 });
    board.reveal_position({ 'row': 0, 'col': 8 });
    board.reveal_position({ 'row': 0, 'col': 9 });
    board.reveal_position({ 'row': 1, 'col': 9 });

    board.toggle_mine_marking({ 'row': 2, 'col': 9 });
    board.reveal_position({ 'row': 3, 'col': 9 });
    board.reveal_position({ 'row': 4, 'col': 9 });

    board.toggle_mine_marking({ 'row': 4, 'col': 6 });

    board.toggle_mine_marking({ 'row': 5, 'col': 6 });

    board.toggle_mine_marking({ 'row': 6, 'col': 6 });
    expect(board.mines_remaining(), 0);
    board.reveal_position({ 'row': 7, 'col': 6 });

    expect(board.status(), 'Win');

  });

  test('Mass reveal will reveal all cells around current cell', () {
    Board board = Board(rows:2, cols:2);
    var mines = [
        { 'row': 0, 'col': 0 },
    ];
    board.add_mines(mines);
    board.toggle_mine_marking({ 'row': 0, 'col': 0 });
    board.reveal_position({ 'row': 1, 'col': 1 });

    board.mass_reveal_around_position({ 'row': 1, 'col': 1 });
    expect(board.view_board(), [
        ['^','1'],
        ['1','1'],
    ]);
  });

  test('Cannot mass reveal an unrevealed cell', () {
    Board board = Board(rows:2, cols:2);
    var mines = [
        { 'row': 0, 'col': 0 },
    ];
    board.add_mines(mines);
    board.toggle_mine_marking({ 'row': 0, 'col': 0 });

    board.mass_reveal_around_position({ 'row': 1, 'col': 1 });
    expect(board.view_board(), [
        ['^',' '],
        [' ',' '],
    ]);
  });
  
  test('Cannot mass reveal a marked cell', () {
    Board board = Board(rows:2, cols:2);
    var mines = [
        { 'row': 0, 'col': 0 },
    ];
    board.add_mines(mines);
    board.toggle_mine_marking({ 'row': 0, 'col': 0 });
    board.mass_reveal_around_position({ 'row': 0, 'col': 0 });
    expect(board.view_board(), [
        ['^',' '],
        [' ',' '],
    ]);
  });

  test('Cannot mass reveal a cell if there are insufficient marked mines around it', () {
    Board board = Board(rows:2, cols:2);
    var mines = [
        { 'row': 0, 'col': 0 },
    ];
    board.add_mines(mines);
    board.reveal_position({ 'row': 1, 'col': 1 });
    board.mass_reveal_around_position({ 'row': 1, 'col': 1 });
    expect(board.view_board(), [
        [' ',' '],
        [' ','1'],
    ]);
  });

  test('Board creates random mines equal to floor of square root of number of tiles by default', () {
    Board board = Board(rows:2, cols:2);
    board.add_mines();
    expect(board.mines_remaining(), 2);

    board = Board(rows:8, cols:10);
    board.add_mines();
    expect(board.mines_remaining(), 9);
  });

  test('Bombs reveal themselves when game is lost', () {
    Board board = Board(rows:2, cols:2);
    var mines = [
        { 'row': 0, 'col': 0 },
        { 'row': 0, 'col': 1 },
    ];
    board.add_mines(mines);
    board.reveal_position({ 'row': 0, 'col': 0 });
    expect(board.view_board(), [
        ['*','*'],
        [' ',' '],
    ]);
  });

  test('Bombs reveal themselves when game is lost', () {
    Board board = Board(rows:2, cols:2);
    var mines = [
        { 'row': 0, 'col': 0 },
        { 'row': 0, 'col': 1 },
    ];
    board.add_mines(mines);
    board.toggle_mine_marking({ 'row': 0, 'col': 0 });
    board.toggle_mine_marking({ 'row': 1, 'col': 0 });
    board.reveal_position({ 'row': 0, 'col': 1 });
    expect(board.view_board(), [
        ['^','*'],
        ['X',' '],
    ]);
  });
}
