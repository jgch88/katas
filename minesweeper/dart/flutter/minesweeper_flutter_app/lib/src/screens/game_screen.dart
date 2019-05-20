import 'package:flutter/material.dart';
import '../blocs/gamestate_provider.dart';

class GameScreen extends StatelessWidget {
  final int timeElapsedInSeconds = 0;
  final List<List<String>> displayedBoardData = [];
  final int dummyMinesRemaining = 10;
  final int dummyTimeElapsed = 100;
  final String dummyGameStatus = 'Playing';
  final List<List<String>> dummyBoardData =
  /*
  [
    [' ', ' '],
    [' ', ' '],
  ];
  */
  [
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
  ];


  Widget build(BuildContext context) {
    final bloc = GamestateProvider.of(context);
    return drawScreen(bloc);
  }

  Widget drawScreen(GamestateBloc bloc) {
    return Column(
      children: <Widget>[
        drawInfoPanel(bloc),
        Expanded(
          child: drawBoard(bloc),
        ),
      ],
    );
  }

  Widget drawInfoPanel(GamestateBloc bloc) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        drawMinesRemaining(bloc),
        drawTimer(bloc),
        drawGameStatus(bloc),
      ]
    );
  }

  Widget drawMinesRemaining(GamestateBloc bloc) {
    return StreamBuilder(
      stream: bloc.minesRemaining,
      builder: (context, AsyncSnapshot<int> snapshot) {
        return Text('Mines Remaining: ${snapshot.data}');
      }
    );
  }

  Widget drawTimer(GamestateBloc bloc) {
    return StreamBuilder(
        stream: bloc.timer,
        builder: (context, AsyncSnapshot<int> snapshot) {
          return Text('Time Elapsed: ${snapshot.data}');
        }
    );
  }

  Widget drawGameStatus(GamestateBloc bloc) {
    return StreamBuilder(
        stream: bloc.gameStatus,
        builder: (context, AsyncSnapshot<String> snapshot) {
          return Text('Status: ${snapshot.data}');
        }
    );
  }

  Widget drawBoard(GamestateBloc bloc) {
    int rows = dummyBoardData.length;
    int cols = dummyBoardData[0].length;
    int cellCount = rows * cols;
    return GridView.count(
      crossAxisCount: rows,
      childAspectRatio: 1,
      children: List.generate(cellCount, (index) {
        int row = (index / rows).floor();
        int col = index.remainder(rows);
        return Container(
          margin: EdgeInsets.all(1),
          padding: EdgeInsets.all(1),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.teal)
          ),
          child: Center (
            child: Text(
                '${dummyBoardData[row][col]}'
            ),
          ),
        );
      }),
    );
  }
}

