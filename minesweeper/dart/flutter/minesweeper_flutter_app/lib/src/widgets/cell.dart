import 'package:flutter/material.dart';

class Cell extends StatelessWidget {
  final String displayedValue;

  Cell({this.displayedValue});

  Widget build(BuildContext context) {
    if (this.displayedValue == ' ') {
      return Container(
        decoration: BoxDecoration(
          color: Colors.tealAccent,
        ),
      );
    } else if (this.displayedValue == '^') {
      return Container(
        decoration: BoxDecoration(
          color: Colors.tealAccent,
        ),
        child: Center(
          child: Icon(Icons.flag),
        )
      );
    } else if (this.displayedValue == '*') {
      return Container(
        decoration: BoxDecoration(
          color: Colors.red,
        ),
        child: Center(
          child: Icon(Icons.settings),
        )
      );
    } else if (this.displayedValue == '.') {
      return Container(
        decoration: BoxDecoration(
          color: Colors.grey,
        )
      );
    } else if (this.displayedValue == 'X') {
      return Container(
        decoration: BoxDecoration(
          color: Colors.red,
        ),
        child: Center(
          child: Icon(Icons.close),
        )
      );
    } else {
      int value = int.parse(this.displayedValue);
      const colourMap = {
        1: Colors.red,
        2: Colors.orange,
        3: Colors.yellow,
        4: Colors.green,
        5: Colors.teal,
        6: Colors.blue,
        7: Colors.purple,
        8: Colors.black,
      };
      
      return Container(
        decoration: BoxDecoration(
          color: Colors.grey,
        ),
        child: Center(
          child: Text(
            this.displayedValue,
            style: TextStyle(
              color: colourMap[value],
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }
  }
}