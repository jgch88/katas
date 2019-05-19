import 'package:flutter/material.dart';
import './domain/Minesweeper.dart';

class App extends StatelessWidget {
  Widget build(BuildContext context) {
     return MaterialApp(
      title: 'Minesweeper',
      initialRoute: '/',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Minesweeper'),
        ),
        body: Center(
            child: MinesweeperUI(),
        )
      ),
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
    );
  }
}

class MinesweeperUI extends StatefulWidget {
  @override
  MinesweeperUIState createState() => MinesweeperUIState();
}

class MinesweeperUIState extends State<MinesweeperUI> {
  @override
  Widget build(BuildContext context) {
    Minesweeper minesweeper = Minesweeper();
    minesweeper.new_game();
    return Text(minesweeper.time_elapsed().toString());
  }
}