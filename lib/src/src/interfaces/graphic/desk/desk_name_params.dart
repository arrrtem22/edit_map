import 'package:flutter/cupertino.dart';

abstract class DeskNameParams {
  final String name;
  final double x;
  final double y;
  final double factor;
  final TextStyle textStyle;

  DeskNameParams(this.name, this.x, this.y, this.factor, this.textStyle);
}

abstract class DeskNameInterface extends DeskNameParams {
  DeskNameInterface(
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
