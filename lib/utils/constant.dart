import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Constant {
  static Color mainColor = Colors.blue[300];

  static setMainColor(Color color) {
    mainColor = color;
  }

  static Color getMainColor() {
    return mainColor;
  }
}
