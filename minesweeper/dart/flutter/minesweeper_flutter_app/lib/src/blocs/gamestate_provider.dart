import 'package:flutter/material.dart';
import 'gamestate_bloc.dart';
export 'gamestate_bloc.dart';

class GamestateProvider extends InheritedWidget {
  final GamestateBloc bloc;

  GamestateProvider({Key key, Widget child})
    : bloc = GamestateBloc(),
      super(key: key, child: child);

  bool updateShouldNotify(_) => true;

  static GamestateBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(GamestateProvider)
      as GamestateProvider).bloc;
  }
}