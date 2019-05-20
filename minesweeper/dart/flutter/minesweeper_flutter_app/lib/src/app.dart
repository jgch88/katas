import 'package:flutter/material.dart';
import './screens/game_screen.dart';

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
            child: GameScreen(),
        )
      ),
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
    );
  }
}