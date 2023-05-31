import 'package:edit_map/src/edit_map.dart';
import 'package:edit_map/src/src/factories/desk/desk_chair_factory.dart';
import 'package:edit_map/src/src/factories/desk/tabletop_factory.dart';
import 'package:edit_map/src/src/interfaces/graphic/object_interface.dart';
import 'package:edit_map/src/src/map_values.dart';
import 'package:edit_map/src/src/models/graphic/desk/desk.dart';
import 'package:edit_map/src/src/models/graphic/desk/desk_values.dart';
import 'package:flutter/material.dart';

class DeskBuilder {
  final TabletopFactory tabletopFactory = const TabletopFactory();
  final DeskChairFactory chairFactory = const DeskChairFactory();

  const DeskBuilder();

  Desk create(DeskPayload params) {
    return Desk(
      params.id,
      params.area.position!.dx,
      params.area.position!.dy,
      rotation: params.area.rotation,

      // coordinates: null,
      stateType: StateType.main,
      // icon: null,
      size: commonTabletopSize,
      // availability: null,
      states: Params(params.isBooked ? bookedDeskState : defaultDeskState,
          activeDeskState),
      coordinates: Offset(
        params.area.position!.dx,
        params.area.position!.dy,
      ),
    );
  }
}
