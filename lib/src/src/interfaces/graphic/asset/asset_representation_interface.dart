import 'package:flutter/material.dart';

abstract class AssetRepresentationParams {
  final double x;
  final double y;
  final double capacity;
  final Color fillColor;
  final double borderWidth;
  final Color borderColor;

  AssetRepresentationParams(
    this.x,
    this.y,
    this.capacity,
    this.fillColor,
    this.borderWidth,
    this.borderColor,
  );
}

enum AssetRepresentationInterfaceEnum {
  common,
  cornerLeft,
  cornerRight,
  stack,
  round,
  rectangle,
  modular,
  oval,
}

abstract class AssetRepresentationInterface extends AssetRepresentationParams {
  final AssetRepresentationInterfaceEnum type;

// graphics: ExtGraphics;
  void draw(Canvas canvas);

  void redraw(Canvas canvas);

  List<Offset> getHitAreaPolygon();

  void correctAngelRelatedParts(double angle);

  AssetRepresentationInterface(
    double x,
    double y,
    double capacity,
    Color fillColor,
    double borderWidth,
    Color borderColor,
    this.type,
  ) : super(x, y, capacity, fillColor, borderWidth, borderColor);
}
