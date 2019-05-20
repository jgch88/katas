import 'package:test/test.dart';
import './Cell.dart';

void main() {
  test('Cell shows space when not yet revealed', () {
    Cell cell = Cell('*');
    expect(cell.display_value(), ' ');
  });

  test('Cell shows actual value when revealed', () {
    Cell cell = Cell('*');
    expect(cell.display_value(), ' ');
    cell.reveal();
    expect(cell.display_value(), '*');
  });

  test('Blank Cell shows dot when revealed', () {
    Cell cell = Cell(' ');
    expect(cell.display_value(), ' ');
    cell.reveal();
    expect(cell.display_value(), '.');
  });

  test('Cell can be marked as a mine', () {
    Cell cell = Cell(' ');
    cell.toggle_mine_marking();
    expect(cell.display_value(), '^');
  });

  test('Marked Cell can be unmarked', () {
    Cell cell = Cell('*');
    expect(cell.display_value(), ' ');
    cell.toggle_mine_marking();
    expect(cell.display_value(), '^');
    cell.toggle_mine_marking();
    expect(cell.display_value(), ' ');
  });
}
