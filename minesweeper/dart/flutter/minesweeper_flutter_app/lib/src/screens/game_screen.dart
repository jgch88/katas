import 'package:flutter/material.dart';
import '../blocs/gamestate_provider.dart';

class GameScreen extends StatelessWidget {

  Widget build(BuildContext context) {
    final bloc = GamestateProvider.of(context);
    return drawScreen(bloc);
  }

  Widget drawScreen(GamestateBloc bloc) {
    return Column(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: drawInfoPanel(bloc),
        ),
        Expanded(
          flex: 7,
          child: drawBoard(bloc),
        ),
        Expanded(
          flex: 2,
          child: drawRestartGameButton(bloc),
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
    return StreamBuilder(
      stream: bloc.board,
      builder: (context, AsyncSnapshot<List<List<String>>> snapshot) {
        if (snapshot.hasData) {
          int rows = snapshot.data.length;
          int cols = snapshot.data[0].length;
          int cellCount = rows * cols;
          return GridView.count(
            crossAxisCount: rows,
            childAspectRatio: 1,
            children: List.generate(cellCount, (index) {
              int row = (index / rows).floor();
              int col = index.remainder(rows);
              Map position = {'row': row, 'col': col};
              return GestureDetector(
                child: Container(
                  margin: EdgeInsets.all(1),
                  padding: EdgeInsets.all(1),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.teal)
                  ),
                  child: Center (
                    child: Text(
                        '${snapshot.data[row][col]}'
                    ),
                  ),
                ),
                onLongPress: () {
                  bloc.reveal(position);
                },
                onTap: () {
                  bloc.toggleMineMarking(position);
                },
                onDoubleTap: () {
                  bloc.massReveal(position);
                },
              );
            }),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget drawRestartGameButton(GamestateBloc bloc) {
    return Center(
      child:FloatingActionButton(
        child: IconButton(
          icon: Icon(Icons.refresh),
          onPressed: () {
            bloc.newGame();
          },
        ),
      ),
    );
  }
}

