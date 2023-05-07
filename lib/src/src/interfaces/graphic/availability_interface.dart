import 'package:flutter/material.dart';

abstract class AvailabilityParams {
  final double x;
  final double y;
  final double factor;
  final double length;
  final Color fillColor;
  final double thickness;

  AvailabilityParams(
    this.x,
    this.y,
    this.factor,
    this.length,
    this.fillColor,
    this.thickness,
  );
}

enum AvailabilityEnum {
  empty,
  plain,
}

abstract class AvailabilityInterface extends AvailabilityParams {
  AvailabilityInterface(
    double x,
    double y,
    double factor,
    double length,
    Color fillColor,
    double thickness,
  ) : super(x, y, factor, length, fillColor, thickness);

  void draw();

  void redraw();

  void setParams({Color fillColor, double thickness});

  AvailabilityInterface clone();
}
