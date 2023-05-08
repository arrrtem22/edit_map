import 'package:flutter/cupertino.dart';
import 'package:edit_map/src/src/interfaces/factories/position_related_factory_interface.dart';
import 'package:edit_map/src/src/interfaces/graphic/desk/desk_interface.dart';
import 'package:edit_map/src/src/models/graphic/desk/desk_values.dart';

class ChairPositionFactory
    implements PositionRelatedFactoryInterface<DeskTypeEnum, Offset> {
  @override
  Offset createPosition(
    DeskTypeEnum type,
    Size chair,
    Size relatedObject,
    Offset center,
  ) {
    switch (type) {
      case DeskTypeEnum.common:
        return Offset(
          center.dx + relatedObject.width / 2 - chair.width / 2,
          center.dy + relatedObject.height + chairMargin,
        );
    }
  }
}
