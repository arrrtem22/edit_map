import 'package:flutter/material.dart';
import 'package:edit_map/src/src/interfaces/graphic/availability_interface.dart';
import 'package:edit_map/src/src/interfaces/graphic/icon/icon_interface.dart';
import 'package:edit_map/src/src/interfaces/graphic/icon/iconable_interface.dart';
import 'package:edit_map/src/src/interfaces/graphic/object_interface.dart';
import 'package:edit_map/src/src/interfaces/graphic/parking_lot/lot_interface.dart';
import 'package:edit_map/src/src/interfaces/graphic/parking_lot/parking_lot_name_interface.dart';

enum ParkingLotTypeEnum {
  common,
}

abstract class ParkingLotStateInterface extends StateInterface {
  final Color nameColor;
  final Color nameStrokeColor;
  final double nameStrokeWidth;
  final Color availabilityColor;
  final double availabilityThickness;

  ParkingLotStateInterface(
    this.nameColor,
    this.nameStrokeColor,
    this.nameStrokeWidth,
    this.availabilityColor,
    this.availabilityThickness,
    Color fillColor,
    Color borderColor,
  ) : super(fillColor, borderColor);
}

abstract class ParkingLotInterface
    implements ObjectInterface, IconableInterface {
  final ParkingLotTypeEnum type;
  final bool isSimplified;
  final LotInterface lot;
  final ParkingLotNameInterface parkingLotName;
  final IconInterface icon;
  final AvailabilityInterface availability;

  ParkingLotInterface(
    this.type,
    this.isSimplified,
    this.lot,
    this.parkingLotName,
    this.icon,
    this.availability,
  );

  List<Offset> getRotatedShape();

  void resetIcon(IconInterface icon);

  void setStates(Params<ParkingLotStateInterface> states);

  Params<ParkingLotStateInterface> getStates();

  void setCurrentState(ParkingLotStateInterface state);
}
