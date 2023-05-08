import 'package:flutter/material.dart';
import 'package:edit_map/src/src/interfaces/graphic/chair_interface.dart';
import 'package:edit_map/src/src/interfaces/graphic/desk/desk_interface.dart';
import 'package:edit_map/src/src/models/graphic/desk/desk_values.dart';

class ChairDesk implements ChairInterface {
  @override
  final ChairEnum type = ChairEnum.desk;

  @override
  final double x;

  @override
  final double y;

  @protected
  final double width;

  @protected
  final double height;

  ChairDesk(ChairParams? params)
      : width = 70.0,
        height = 40.0,
        x = params?.x ?? 0,
        y = params?.y ?? 0;

  @override
  void draw(Canvas canvas, DeskState deskState) {
    drawChairDesk(canvas, deskState);
  }

  @protected
  void drawChairDesk(Canvas canvas, DeskState deskState) {
    final Paint chairPaint = Paint()
      ..color = deskState.fillColor
      ..style = PaintingStyle.fill;

    final chairX = x + commonTabletopSize.width / 2 - deskChairSize.width / 2;
    final chairY = y + commonTabletopSize.height + 2;

    RRect tabletopShape = RRect.fromRectAndCorners(
      Offset(chairX, chairY) &
      deskChairSize,
      bottomLeft: const Radius.circular(deskBorderRadius),
      bottomRight: const Radius.circular(deskBorderRadius),
    );

    canvas.drawRRect(tabletopShape, chairPaint);
  }

  @override
  ChairDesk copyWith({
    double? x,
    double? y,
    ChairEnum? type,
    double? factor,
    Color? fillColor,
    double? borderWidth,
    Color? borderColor,
  }) {
    return ChairDesk(
      ChairParams(
        x ?? this.x,
        y ?? this.y,
      ),
    );
  }
}
