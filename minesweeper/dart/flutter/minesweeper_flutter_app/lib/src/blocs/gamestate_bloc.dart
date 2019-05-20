import 'package:rxdart/rxdart.dart';
import 'dart:async';
import '../domain/Minesweeper.dart';

class GamestateBloc {
  final _minesweeper = Minesweeper();
  final _boardOutput = BehaviorSubject<List<List<String>>>();
  final _timerOutput = BehaviorSubject<int>();
  final _minesRemaining = BehaviorSubject<int>();

  Observable<int> get minesRemaining => _minesRemaining.stream;
  Observable<List<List<String>>> get board => _boardOutput.stream;
  Observable<int> get timer => _timerOutput.stream;

  GamestateBloc() {
    _minesweeper.new_game();
    _timerOutput.sink.add(_minesweeper.time_elapsed());

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