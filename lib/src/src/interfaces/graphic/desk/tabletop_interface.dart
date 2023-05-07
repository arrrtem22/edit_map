import 'package:flutter/material.dart';
import 'package:edit_map/src/src/interfaces/graphic/desk/desk_interface.dart';

class TabletopParams {
  final double? x;
  final double? y;

  TabletopParams(
    this.x,
    this.y,
  );
}

enum TabletopEnum {
  common,
  large,
  cornerLeft,
  cornerRight,
}

abstract class TabletopInterface extends TabletopParams {
  final TabletopEnum type;

  TabletopInterface(
    double x,
    double y,
    this.type,
  ) : super(x, y);

  void draw(Canvas canvas, DeskState deskState);

  TabletopInterface copyWith({
    double? x,
    double? y,
    TabletopEnum? type,
  });
}
