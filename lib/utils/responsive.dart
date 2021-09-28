import 'package:flutter/material.dart';
import 'dart:math' as math;

class Responsive {
  late double _width;
  late double _height;
  late double _diagonal;

  Responsive(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    this._width = size.width;
    this._height = size.height;
    this._diagonal = math.sqrt(math.pow(_width, 2) + math.pow(_height, 2));
    //c2 + a2 + b2 = c
  }

  double get width => _width;
  double get height => _height;
  double get diagonal => _diagonal;

  //returna una nueva instancia de la clase
  static Responsive of(BuildContext context) => Responsive(context);

  double wp(double percent) => _width * percent / 100;
  double hp(double percent) => _width * percent / 100;
  double dp(double percent) => _diagonal * percent / 100;
}
