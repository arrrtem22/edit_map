import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:edit_map/src/src/helpers/shape_helper.dart';
import 'package:edit_map/src/src/interfaces/graphic/availability_interface.dart';
import 'package:edit_map/src/src/interfaces/graphic/chair_interface.dart';
import 'package:edit_map/src/src/interfaces/graphic/desk/desk_interface.dart';
import 'package:edit_map/src/src/interfaces/graphic/desk/desk_name_params.dart';
import 'package:edit_map/src/src/interfaces/graphic/desk/tabletop_interface.dart';
import 'package:edit_map/src/src/interfaces/graphic/icon/icon_interface.dart';
import 'package:edit_map/src/src/interfaces/graphic/object_interface.dart';
import 'package:edit_map/src/src/map_values.dart';
import 'package:edit_map/src/src/models/graphic/base_graphic.dart';

const TextStyle deskTextStyle = TextStyle(
  fontSize: 10,
  fontWeight: FontWeight.bold,
  color: blackColor,
);

class Desk extends BaseGraphic implements DeskInterface {
  // @override
  // final AvailabilityInterface availability;

  @override
  final ChairInterface chair;

  @override
  final Offset coordinates;

  // @override
  // final DeskNameInterface deskName;

  // @override
  // final IconInterface icon;

  @override
  final bool isSimplified;

  @override
  final Size size;

  @override
  final StateType stateType;

  @override
  final TabletopInterface tabletop;

  @override
  final DeskTypeEnum type;

  final Params<DeskState> states;

  // final ParamsInterface<IconInterface> icons;

  Desk(
    String id,
    double x,
    double y, {
    required double rotation,
    required this.states,
    // required this.availability,
    required this.chair,
    required this.coordinates,
    // required this.deskName,
    // required this.icon,
    required this.isSimplified,
    required this.size,
    required this.stateType,
    required this.tabletop,
    required this.type,
    // required this.icons,
  }) : super(id, x, y, rotation);

  @override
  Params<IconInterface> getIcons() {
    // TODO: implement getIcons
    throw UnimplementedError();
  }

  @override
  List<Offset> getRotatedShape() {
    // saved points, static
    final List<Offset> deskShape = getShape();
    // top-left point
    final tl = deskShape[0];
    // bottom-right point
    final br = deskShape[2];
    final rectCenter = Offset((tl.dx + br.dx) / 2, (tl.dy + br.dy) / 2);
    // shape points with rotation
    return deskShape
        .map((point) => rotatePoint(point, rectCenter, rotation))
        .toList();
  }

  @override
  void resetIcon(IconInterface icon) {
    // TODO: implement resetIcon
  }

  @override
  void setIcon(IconInterface icon) {
    // TODO: implement setIcon
  }

  @override
  void setIcons(Params<IconInterface> icons) {
    // TODO: implement setIcons
  }

  @override
  void draw(Canvas canvas) {
    canvas.save();

    canvas.translate(tabletop.x ?? 0, tabletop.y ?? 0);
    canvas.rotate(rotation * math.pi / 180);
    canvas.translate(-(tabletop.x ?? 0), -(tabletop.y ?? 0));

    final DeskState state =
        stateType == StateType.active ? states.active : states.main;

    tabletop.draw(canvas, state);
    chair.draw(canvas, state);

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
      // availability: availability ?? this.availability,
      chair: chair ?? this.chair,
      coordinates: coordinates ?? this.coordinates,
      // deskName: deskName ?? this.deskName,
      // icon: icon ?? this.icon,
      isSimplified: isSimplified ?? this.isSimplified,
      size: size ?? this.size,
      stateType: stateType ?? this.stateType,
      tabletop: tabletop ?? this.tabletop,
      type: type ?? this.type,
      // icons: icons ?? this.icons,
    );
  }
}
