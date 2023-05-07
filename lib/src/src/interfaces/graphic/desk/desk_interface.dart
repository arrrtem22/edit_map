import 'package:flutter/material.dart';
import 'package:edit_map/src/src/interfaces/graphic/chair_interface.dart';
import 'package:edit_map/src/src/interfaces/graphic/desk/tabletop_interface.dart';
import 'package:edit_map/src/src/interfaces/graphic/icon/icon_interface.dart';
import 'package:edit_map/src/src/interfaces/graphic/icon/iconable_interface.dart';
import 'package:edit_map/src/src/interfaces/graphic/object_interface.dart';

enum DeskTypeEnum {
  common,
}

class DeskState extends StateInterface {
  final Color nameColor;

  // final Color nameStrokeColor;
  // final double nameStrokeWidth;
  // final Color availabilityColor;
  // final double availabilityThickness;

  const DeskState({
    required Color fillColor,
    required Color borderColor,
    required this.nameColor,
    // required this.nameStrokeColor,
    // required this.nameStrokeWidth,
    // required this.availabilityColor,
    // required this.availabilityThickness,
  }) : super(fillColor, borderColor);
}

abstract class DeskInterface implements ObjectInterface, IconableInterface {
  final DeskTypeEnum type;
  final bool isSimplified;
  final TabletopInterface tabletop;
  final ChairInterface chair;

  // final DeskNameInterface deskName;
  // final IconInterface icon;
  // final AvailabilityInterface availability;

  DeskInterface(
    this.type,
    this.isSimplified,
    this.tabletop,
    this.chair,
    // this.deskName,
    // this.icon,
    // this.availability,
  );

  List<Offset> getRotatedShape();

  void resetIcon(IconInterface icon);

  Params<StateInterface> getStates();

  void draw(Canvas canvas);
}
