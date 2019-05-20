import 'package:flutter/material.dart';

class GameScreen extends StatelessWidget {
  final int timeElapsedInSeconds = 0;
  final List<List<String>> displayedBoardData = [];

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
    return GridView.count(
      crossAxisCount: 10,
      children: List.generate(100, (index) {
        return Center(
          child: Text(
            '$index'
          )
        );
      }),

    );
  }
}
