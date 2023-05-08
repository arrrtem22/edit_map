import 'package:flutter/material.dart';

enum StateType {
  main,
  // hover, maybe will be implemented for web
  active,
}

abstract class StateInterface {
  final Color fillColor;
  final Color borderColor;

  const StateInterface(
    this.fillColor,
    this.borderColor,
  );
}

class Params<T> {
  final T main;

  // T hover;
  final T active;

  Params(
    this.main,
    this.active,
  );
}

abstract class ObjectInterface {
  final Size size;

  final double rotation;

  final Offset coordinates;

  final StateType stateType;

  ObjectInterface(
    this.size,
    this.rotation,
    this.coordinates,
    this.stateType,
  );
}
