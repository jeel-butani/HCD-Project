import 'package:flutter/material.dart';

class CompnentSize {
  static Color background = Colors.indigo;
  static Color boldTextColor = Colors.white;
  static Color textColor = Colors.black;
  static double getHeight(context, double i) {
    double result = MediaQuery.of(context).size.height * i;
    return result;
  }

  static double getWidth(context, double i) {
    double result = MediaQuery.of(context).size.width * i;
    return result;
  }

  static double getFontSize(context, double i) {
    double result = MediaQuery.of(context).size.width * i;
    return result;
  }
}
