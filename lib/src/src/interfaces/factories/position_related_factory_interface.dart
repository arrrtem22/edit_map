import 'package:flutter/material.dart';

abstract class PositionRelatedFactoryInterface<ObjectType, ObjectParams> {
  Offset createPosition(
    ObjectType type,
    Size objectSize,
    Size relatedObjectSize,
    Offset center,
  );
}
