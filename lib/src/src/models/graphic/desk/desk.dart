import 'dart:math' as math;

import 'package:edit_map/src/src/interfaces/graphic/availability_interface.dart';
import 'package:edit_map/src/src/interfaces/graphic/chair_interface.dart';
import 'package:edit_map/src/src/interfaces/graphic/desk/desk_interface.dart';
import 'package:edit_map/src/src/interfaces/graphic/desk/desk_name_params.dart';
import 'package:edit_map/src/src/interfaces/graphic/desk/tabletop_interface.dart';
import 'package:edit_map/src/src/interfaces/graphic/icon/icon_interface.dart';
import 'package:edit_map/src/src/interfaces/graphic/object_interface.dart';
import 'package:edit_map/src/src/map_values.dart';
import 'package:edit_map/src/src/models/graphic/base_graphic.dart';
import 'package:edit_map/src/src/models/graphic/desk/desk_values.dart';
import 'package:flutter/cupertino.dart';

const TextStyle deskTextStyle = TextStyle(
  fontSize: 10,
  fontWeight: FontWeight.bold,
  color: blackColor,
);

class Desk extends BaseGraphic {
  Desk(
    String id,
    double x,
    double y, {
    required double rotation,
    required this.states,
    required this.coordinates,
    required this.size,
    required this.stateType,
    // required this.icons,
  }) : super(id, x, y, rotation);

  @override
  final Offset coordinates;

  @override
  final Size size;

  @override
  final StateType stateType;

  final Params<DeskState> states;

  @override
  void draw(Canvas canvas) {
    canvas.save();

    canvas.translate(size.width / 2, size.height / 2); // todo maybe change to 0
    canvas.rotate(rotation * math.pi / 180);
    canvas.translate(-(size.width / 2), -(size.height / 2));

    final DeskState state =
        stateType == StateType.active ? states.active : states.main;

    final Paint deskPaint = Paint()
      ..color = state.fillColor
      ..style = PaintingStyle.fill;

    // y - commontabletopHeight + 4 = aligned as in web version
    RRect tabletopShape = RRect.fromRectAndRadius(
      Offset(x, y) &
          const Size(commonTabletopWidth, (commonTabletopHeight - borderWidth)),
      const Radius.circular(deskBorderRadius),
    );

    canvas.drawRRect(tabletopShape, deskPaint);
    final Paint chairPaint = Paint()
      ..color = state.fillColor
      ..style = PaintingStyle.fill;

    final chairX = x + commonTabletopSize.width / 2 - deskChairSize.width / 2;
    final chairY = y + commonTabletopSize.height + 2;

    RRect chairShape = RRect.fromRectAndCorners(
      Offset(chairX, chairY) & deskChairSize,
      bottomLeft: const Radius.circular(deskBorderRadius),
      bottomRight: const Radius.circular(deskBorderRadius),
    );

    canvas.drawRRect(chairShape, chairPaint);

    canvas.restore();
  }

  Desk copyWith({
    String? id,
    double? x,
    double? y,
    double? rotation,
    StateInterface? state,
    Params<DeskState>? states,
    AvailabilityInterface? availability,
    ChairInterface? chair,
    Offset? coordinates,
    DeskNameInterface? deskName,
    IconInterface? icon,
    bool? isSimplified,
    List<Offset>? shape,
    Size? size,
    StateType? stateType,
    TabletopInterface? tabletop,
    DeskTypeEnum? type,
    Params<IconInterface>? icons,
  }) {
    return Desk(
      id ?? this.id,
      x ?? this.x,
      y ?? this.y,
      rotation: rotation ?? this.rotation,
      states: states ?? this.states,
      coordinates: coordinates ?? this.coordinates,
      size: size ?? this.size,
      stateType: stateType ?? this.stateType,
    );
  }
}
