import 'package:flutter/material.dart';
import 'package:edit_map/src/src/interfaces/graphic/desk/desk_interface.dart';

class ChairParams {
  final double? x;
  final double? y;

  ChairParams(
    this.x,
    this.y,
  );
}

enum ChairEnum {
  desk,
  deskSmaller,
}

abstract class ChairInterface extends ChairParams {
  final ChairEnum type;

  ChairInterface(
    double x,
    double y,
    this.type,
  ) : super(x, y);

  void draw(Canvas canvas, DeskState deskState);

  ChairInterface copyWith({
    double? x,
    double? y,
    ChairEnum? type,
    double? factor,
    Color? fillColor,
    double? borderWidth,
    Color? borderColor,
  });
}
