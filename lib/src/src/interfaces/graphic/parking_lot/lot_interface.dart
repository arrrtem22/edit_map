import 'package:flutter/material.dart';

abstract class LotParams {
  final double x;
  final double y;
  final double factor;
  final Color fillColor;
  final double borderWidth;
  final Color borderColor;

  LotParams(
    this.x,
    this.y,
    this.factor,
    this.fillColor,
    this.borderWidth,
    this.borderColor,
  );
}

enum LotEnum {
  common,
}

abstract class LotInterface extends LotParams {
  final LotEnum type;

  LotInterface(
    double x,
    double y,
    double factor,
    Color fillColor,
    double borderWidth,
    Color borderColor,
    this.type,
  ) : super(x, y, factor, fillColor, borderWidth, borderColor);

  void draw();

  void redraw();

  void setParams({Color fillColor, Color borderColor});

  LotInterface clone();
}
