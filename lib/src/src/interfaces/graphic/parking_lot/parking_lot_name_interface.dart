import 'package:flutter/material.dart';

abstract class ParkingLotNameParams {
  final String name;
  final double x;
  final double y;
  final double factor;
  final TextStyle textStyle;

  ParkingLotNameParams(this.name, this.x, this.y, this.factor, this.textStyle);
}

abstract class ParkingLotNameInterface extends ParkingLotNameParams {
  ParkingLotNameInterface(
    String name,
    double x,
    double y,
    double factor,
    TextStyle textStyle,
  ) : super(name, x, y, factor, textStyle);

  void draw();

  void redraw();

  void setParams(TextStyle textStyle);
}
