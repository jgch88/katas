import 'package:rxdart/rxdart.dart';
import 'dart:async';
import '../domain/Minesweeper.dart';

class GamestateBloc {
  final _minesweeper = Minesweeper();

  final _minesRemaining = BehaviorSubject<int>();
  final _timer = BehaviorSubject<int>();
  final _gameStatus = BehaviorSubject<String>();
  final _board = BehaviorSubject<List<List<String>>>();

  Observable<int> get minesRemaining => _minesRemaining.stream;
  Observable<int> get timer => _timer.stream;
  Observable<String> get gameStatus => _gameStatus.stream;
  Observable<List<List<String>>> get board => _board.stream;

  GamestateBloc() {
    _minesweeper.new_game();
    _timer.sink.add(_minesweeper.time_elapsed());
    _gameStatus.sink.add(_minesweeper.status());
    _minesRemaining.sink.add(_minesweeper.mines_remaining());
    _board.sink.add(_minesweeper.view_board());

    Timer.periodic(Duration(seconds:1), (Timer t) {
      _timer.sink.add(_minesweeper.time_elapsed());
    });
  }

  dispose() {
    _minesRemaining.close();
    _timer.close();
    _gameStatus.close();
    _board.close();
  }
}