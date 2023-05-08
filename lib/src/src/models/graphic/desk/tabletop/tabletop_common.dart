import 'package:flutter/material.dart';
import 'package:edit_map/src/src/interfaces/graphic/desk/desk_interface.dart';
import 'package:edit_map/src/src/interfaces/graphic/desk/tabletop_interface.dart';
import 'package:edit_map/src/src/map_values.dart';
import 'package:edit_map/src/src/models/graphic/desk/desk_values.dart';

class TabletopCommon implements TabletopInterface {
  @override
  final TabletopEnum type = TabletopEnum.common;

  @override
  final double x;

  @override
  final double y;

  @protected
  final double width;

  @protected
  final double height;

  TabletopCommon(TabletopParams? params)
      : width = 70.0,
        height = 40.0,
        x = params?.x ?? 0,
        y = params?.y ?? 0;

  @override
  void draw(Canvas canvas, DeskState deskState) {
    drawTabletop(canvas, deskState);
  }

  @protected
  void drawTabletop(Canvas canvas, DeskState deskState) {
    final Paint deskPaint = Paint()
      ..color = deskState.fillColor
      ..style = PaintingStyle.fill;

    // y - commontabletopHeight + 4 = aligned as in web version
    RRect tabletopShape = RRect.fromRectAndRadius(
      Offset(x, y) &
          const Size(commonTabletopWidth, (commonTabletopHeight - borderWidth)),
      const Radius.circular(deskBorderRadius),
    );

    canvas.drawRRect(tabletopShape, deskPaint);
  }

  @override
  TabletopCommon copyWith({
    double? x,
    double? y,
    TabletopEnum? type,
  }) {
    return TabletopCommon(
      TabletopParams(
        x ?? this.x,
        y ?? this.y,
      ),
    );
  }
}
