import 'package:flutter/material.dart';
import 'package:edit_map/src/skia_office_map.dart';
import 'package:edit_map/src/src/factories/desk/desk_chair_factory.dart';
import 'package:edit_map/src/src/factories/desk/tabletop_factory.dart';
import 'package:edit_map/src/src/interfaces/graphic/chair_interface.dart';
import 'package:edit_map/src/src/interfaces/graphic/desk/tabletop_interface.dart';
import 'package:edit_map/src/src/interfaces/graphic/object_interface.dart';
import 'package:edit_map/src/src/map_values.dart';
import 'package:edit_map/src/src/models/graphic/desk/desk.dart';
import 'package:edit_map/src/src/models/graphic/desk/desk_values.dart';

class DeskBuilder {
  final TabletopFactory tabletopFactory = const TabletopFactory();
  final DeskChairFactory chairFactory = const DeskChairFactory();

  const DeskBuilder();

  Desk create(DeskPayload params) {
    // final Offset center = determinateRectCenter(params.shape);
    TabletopInterface tabletopInterface = tabletopFactory.createGraphic(
      params.type,
      TabletopParams(params.area.position?.dx, params.area.position?.dy),
    );

    ChairInterface chairInterface = chairFactory.createGraphic(
      // params.type == DeskTypeEnum.cornerRight ||
      //         params.type == DeskTypeEnum.cornerLeft
      //     ? ChairEnum.deskSmaller
      //     :
      ChairEnum.desk,
      ChairParams(
        params.area.position?.dx,
        params.area.position?.dy,
      ),
    );

    return Desk(
      params.id,
      params.area.position!.dx,
      params.area.position!.dy,
      type: params.type,
      rotation: params.area.rotation,

      // icons: null,
      // deskName: null,
      isSimplified: false,
      // coordinates: null,
      stateType: StateType.main,
      // icon: null,
      size: commonTabletopSize,
      tabletop: tabletopInterface,
      chair: chairInterface,
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
