import 'package:flutter/material.dart';

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
    return drawScreen();
  }

  Widget drawScreen() {
    return Column(
      children: <Widget>[
        drawInfoPanel(),
        Expanded(
          child: drawBoard(),
        ),
      ],
    );
  }

  Widget drawInfoPanel() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
        Text('Mines Remaining: $dummyMinesRemaining'),
        Text('Time Elapsed: $dummyTimeElapsed'),
        Text('Status: $dummyGameStatus'),
      ]
    );
  }

  Widget drawBoard() {
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

