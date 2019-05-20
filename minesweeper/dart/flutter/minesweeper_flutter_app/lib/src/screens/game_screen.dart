import 'package:flutter/material.dart';

class GameScreen extends StatelessWidget {
  final int timeElapsedInSeconds = 0;
  final List<List<String>> displayedBoardData = [];
  final List<List<String>> dummyData =
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
      children: <Widget>[
        Text('Mines Remaining: 10'),
        Text('Time Elapsed: 0'),
        Text('Status: Playing'),
      ]
    );
  }

  Widget drawBoard() {
    int rows = dummyData.length;
    int cols = dummyData[0].length;
    int cellCount = rows * cols;
    return GridView.count(
      crossAxisCount: rows,
      children: List.generate(cellCount, (index) {
        int row = (index / rows).floor();
        int col = index.remainder(rows);
        return Center(
          child: Text(
            '${dummyData[row][col]}'
          )
        );
      }),
    );
  }
}

