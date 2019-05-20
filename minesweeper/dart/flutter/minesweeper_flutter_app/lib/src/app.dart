import 'package:flutter/material.dart';
import './screens/game_screen.dart';
import 'blocs/gamestate_provider.dart';

class App extends StatelessWidget {
  Widget build(BuildContext context) {
     return GamestateProvider(
       child: MaterialApp(
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
       ),
     );
  }
}