import 'package:test/test.dart';
import './Minesweeper.dart';

void main() {
  test('Command: create a new game', () {
    Minesweeper minesweeper = Minesweeper();
    minesweeper.new_game();
  });

  test('Query: view the board', () {
    Minesweeper minesweeper = Minesweeper();
    minesweeper.new_game();
    expect(minesweeper.view_board(), [
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

  test('Query: mines remaining', () {
    Minesweeper minesweeper = Minesweeper();
    minesweeper.new_game();
    expect(minesweeper.mines_remaining(), 10);
  });

  test('Command: reveal position', () {
    Minesweeper minesweeper = Minesweeper();
    minesweeper.new_game();
    minesweeper.reveal({
      'row': 0,
      'col': 0
    });
  });

  test('Command: mass reveal position', () {
    Minesweeper minesweeper = Minesweeper();
    minesweeper.new_game();
    minesweeper.reveal({'row': 0,'col': 0});
    minesweeper.mass_reveal({'row': 0,'col': 0});
  });

  test('Command: toggle mine marking', () {
    Minesweeper minesweeper = Minesweeper();
    minesweeper.new_game();
    minesweeper.toggle_mine_marking({'row': 0,'col': 0});
  });

  test('Query: game status', () {
    Minesweeper minesweeper = Minesweeper();
    minesweeper.new_game();
    expect(minesweeper.status(), 'Playing');
  });

  test('Query: time elapsed', () {
    Minesweeper minesweeper = Minesweeper();
    minesweeper.new_game();
    expect(minesweeper.time_elapsed(), 0);
  });
}
