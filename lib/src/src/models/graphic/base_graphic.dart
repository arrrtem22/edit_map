import 'package:flutter/material.dart';
import 'package:edit_map/src/src/helpers/shape_helper.dart';
import 'package:edit_map/src/src/interfaces/graphic/object_interface.dart';
import 'package:edit_map/src/src/models/graphic/desk/desk_values.dart';

abstract class BaseGraphic implements ObjectInterface {
  final String id;

  double x;
  double y;
  @override
  final double rotation;

  BaseGraphic(this.id, this.x, this.y, this.rotation);

  ObjectInterface getSelf() {
    return this;
  }

  List<Offset> getShape() {
    final topLeft = Offset(x, y);

    final shape = [
      topLeft,
      Offset(topLeft.dx + commonDeskSize.width, topLeft.dy),
      Offset(topLeft.dx + commonDeskSize.width,
          topLeft.dy + commonDeskSize.height),
      Offset(topLeft.dx, topLeft.dy + commonDeskSize.height),
    ];

    return rotation == 0
        ? shape
        : shape.map((e) => rotatePoint(e, shape.first, rotation)).toList();
  }

  Size getSize() {
    return const Size(0, 0);
  }

  void setCoordinates(Offset coordinates) {
    x = coordinates.dx;
    y = coordinates.dy;
  }

  Offset getCoordinates() {
    return Offset(x, y);
  }

  Params<StateInterface> getStates() {
    throw Exception('Method not implemented.');
  }

  void redraw() {
    throw Exception('Method not implemented.');
  }

  void draw(Canvas canvas);
}
