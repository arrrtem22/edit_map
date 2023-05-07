import 'package:flutter/material.dart';

abstract class IconBaseParams {
  final double x;
  final double y;
  final Size size;
  final int angle;
  final double factor;

  IconBaseParams(this.x, this.y, this.size, this.angle, this.factor);
}

enum IconType {
  empty,
  icon,
  photo,
  text,
  sign,
  signDashed,
}

abstract class IconInterface {
  final double x;
  final double y;
  final Size size;
  final int angle;
  final double factor;

  IconInterface(this.x, this.y, this.size, this.angle, this.factor);

  void setParams(IconBaseParams params);

  void draw();

  IconInterface clone();
}
