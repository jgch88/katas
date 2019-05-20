import 'package:rxdart/rxdart.dart';
import '../domain/Minesweeper.dart';

class GamestateBloc {
  final _minesweeper = Minesweeper();
  final _boardOutput = BehaviorSubject<List<List<String>>>();
  final _timerOutput = BehaviorSubject<int>();

  Observable<List<List<String>>> get board => _boardOutput.stream;
  Observable<int> get timer => _timerOutput.stream;

  Function(List<List<String>>) get fetchBoard => _boardOutput.sink.add;
  Function(int) get fetchTimer => _timerOutput.sink.add;

  GamestateBloc() {}


  dispose() {
    _boardOutput.close();
    _timerOutput.close();
  }
}