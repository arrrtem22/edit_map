import 'package:edit_map/src/src/interfaces/factories/graphic_factory_interface.dart';
import 'package:edit_map/src/src/interfaces/graphic/chair_interface.dart';
import 'package:edit_map/src/src/models/graphic/chair/chair_desk.dart';

class DeskChairFactory
    implements GraphicFactoryInterface<ChairInterface, ChairEnum, ChairParams> {
  const DeskChairFactory();

  @override
  ChairInterface createGraphic(ChairEnum type, ChairParams params) {
    ChairInterface chair;
    switch (type) {
      case ChairEnum.desk:
        chair = ChairDesk(params);
        break;
      // case ChairEnum.deskSmaller:
      //   chair = ChairDeskSmaller(params);
      //   break;
      default:
        throw Exception('Chair with type $type cannot be created');
    }

    return chair;
  }
}
