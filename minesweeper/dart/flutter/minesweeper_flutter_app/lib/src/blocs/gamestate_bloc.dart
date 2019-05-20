import 'package:rxdart/rxdart.dart';
import 'dart:async';
import '../domain/Minesweeper.dart';

class GamestateBloc {
  final _minesweeper = Minesweeper();

  final _minesRemaining = BehaviorSubject<int>();
  final _timer = BehaviorSubject<int>();
  final _gameStatus = BehaviorSubject<String>();
  final _board = BehaviorSubject<List<List<String>>>();

  Timer _timerInstance;

  Observable<int> get minesRemaining => _minesRemaining.stream;
  Observable<int> get timer => _timer.stream;
  Observable<String> get gameStatus => _gameStatus.stream;
  Observable<List<List<String>>> get board => _board.stream;

  GamestateBloc() {
    this.newGame();
  }

  newGame() {
    _minesweeper.new_game();
    _timer.sink.add(_minesweeper.time_elapsed());
    _gameStatus.sink.add(_minesweeper.status());
    _minesRemaining.sink.add(_minesweeper.mines_remaining());
    _board.sink.add(_minesweeper.view_board());

    if (this._timerInstance != null) {
      this._timerInstance.cancel();
    }

    this._timerInstance = Timer.periodic(Duration(milliseconds:50), (Timer timer) {
      if (_minesweeper.status() != 'Playing') {
        timer.cancel();
      }
      _timer.sink.add(_minesweeper.time_elapsed());
    });
  }

  reveal(position) {
    _minesweeper.reveal(position);
    _gameStatus.sink.add(_minesweeper.status());
    _minesRemaining.sink.add(_minesweeper.mines_remaining());
    _board.sink.add(_minesweeper.view_board());
  }

  toggleMineMarking(position) {
    _minesweeper.toggle_mine_marking(position);
    _gameStatus.sink.add(_minesweeper.status());
    _minesRemaining.sink.add(_minesweeper.mines_remaining());
    _board.sink.add(_minesweeper.view_board());
  }

  massReveal(position) {
    _minesweeper.mass_reveal(position);
    _gameStatus.sink.add(_minesweeper.status());
    _minesRemaining.sink.add(_minesweeper.mines_remaining());
    _board.sink.add(_minesweeper.view_board());
  }

  dispose() {
    _minesRemaining.close();
    _timer.close();
    _gameStatus.close();
    _board.close();

    _timerInstance.cancel();
  }
}