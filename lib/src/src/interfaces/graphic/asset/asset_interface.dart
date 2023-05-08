import 'package:flutter/material.dart';
import 'package:edit_map/src/src/interfaces/graphic/asset/asset_representation_interface.dart';
import 'package:edit_map/src/src/interfaces/graphic/object_interface.dart';

class AssetParams {
  final double x;
  final double y;
  final Color fillColor;
  final double borderWidth;
  final Color borderColor;

  AssetParams(
    this.x,
    this.y,
    this.fillColor,
    this.borderWidth,
    this.borderColor,
  );
}

enum AssetTypeEnum {
  armchairCommon,
  chairSmall,
  chairStack,
  barTableCommon,
  barTableCorner,
  coffeeTableRounded,
  coffeeTableOval,
  diningTableRounded,
  diningTableRectangle,
  diningTableModular,
  receptionDeskCornerLeft,
  receptionDeskCornerRight,
  sofaCommon,
  sofaCornerLeft,
  sofaCornerRight,
  whiteboardSmall,
  whiteboardBig,
  tvScreen,
  tvOnWheels,
  phoneBoothCommon,
}

class AssetStateInterface extends StateInterface {
  final double borderWidth;

  AssetStateInterface(
    Color fillColor,
    Color borderColor,
    this.borderWidth,
  ) : super(fillColor, borderColor);
}

abstract class AssetInterface extends ObjectInterface {
  final AssetTypeEnum type;
  final double capacity;
  final bool isSimplified;
  final AssetRepresentationInterface representation;

// setShapeBase(base: { width: number; height: number }): void;
  List<Offset> getRotatedShape();

// setStates(states: ParamsInterface<AssetStateInterface>): void;
  Params<AssetStateInterface> getStates();

  void setCurrentState(AssetStateInterface state);

  AssetInterface(
    Size size,
    double rotation,
    Offset coordinates,
    StateType stateType,
    this.type,
    this.capacity,
    this.isSimplified,
    this.representation,
  ) : super(size, rotation, coordinates, stateType);
}
