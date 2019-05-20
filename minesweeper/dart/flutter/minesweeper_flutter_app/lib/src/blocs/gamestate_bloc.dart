import 'package:rxdart/rxdart.dart';
import 'dart:async';
import '../domain/Minesweeper.dart';

class GamestateBloc {
  final _minesweeper = Minesweeper();
  final _boardOutput = BehaviorSubject<List<List<String>>>();
  final _timerOutput = BehaviorSubject<int>();
  final _minesRemaining = BehaviorSubject<int>();
  final _gameStatus = BehaviorSubject<String>();

  Observable<int> get minesRemaining => _minesRemaining.stream;
  Observable<List<List<String>>> get board => _boardOutput.stream;
  Observable<int> get timer => _timerOutput.stream;
  Observable<String> get gameStatus => _gameStatus.stream;

  GamestateBloc() {
    _minesweeper.new_game();
    _timerOutput.sink.add(_minesweeper.time_elapsed());
    _gameStatus.sink.add(_minesweeper.status());
    _minesRemaining.sink.add(_minesweeper.mines_remaining());

    Timer.periodic(Duration(seconds:1), (Timer t) {
      _timerOutput.sink.add(_minesweeper.time_elapsed());
    });
  }

  dispose() {
    _boardOutput.close();
    _timerOutput.close();
    _minesRemaining.close();
  }
}