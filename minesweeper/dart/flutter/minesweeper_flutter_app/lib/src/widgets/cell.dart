import 'package:flutter/material.dart';

class Cell extends StatelessWidget {
  final String displayedValue;

  Cell({this.displayedValue});

  Widget build(BuildContext context) {
    return Text(this.displayedValue);
  }

}