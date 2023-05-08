import 'package:edit_map/src/src/interfaces/factories/graphic_factory_interface.dart';
import 'package:edit_map/src/src/interfaces/graphic/desk/desk_interface.dart';
import 'package:edit_map/src/src/interfaces/graphic/desk/tabletop_interface.dart';
import 'package:edit_map/src/src/models/graphic/desk/tabletop/tabletop_common.dart';

class TabletopFactory
    implements
        GraphicFactoryInterface<TabletopInterface, DeskTypeEnum,
            TabletopParams> {
  const TabletopFactory();

  @override
  TabletopInterface createGraphic(
    DeskTypeEnum type,
    TabletopParams params,
  ) {
    TabletopInterface tabletop;
    switch (type) {
      case DeskTypeEnum.common:
      // case DeskTypeEnum.commonHorizontal:
        tabletop = TabletopCommon(params);
        break;
      // case DeskTypeEnum.large:
      // case DeskTypeEnum.largeHorizontal:
      //   tabletop = TabletopLarge(params);
      //   break;
      // case DeskTypeEnum.cornerLeft:
      //   tabletop = TabletopCornerLeft(params);
      //   break;
      // case DeskTypeEnum.cornerRight:
      //   tabletop = TabletopCornerRight(params);
      //   break;
      default:
        tabletop = TabletopCommon(params);
    }
    return tabletop;
  }
}
