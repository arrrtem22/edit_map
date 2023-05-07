import 'package:flutter/material.dart';

abstract class GraphicFactoryInterface<Object, ObjectType, ObjectParams> {
  @factory
  Object createGraphic(
    ObjectType type,
    ObjectParams params,
  );
}
