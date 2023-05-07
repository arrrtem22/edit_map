

// class ChairFactory
//     implements
//         GraphicFactoryInterface<AssetRepresentationInterface, AssetTypeEnum,
//             AssetRepresentationInterface> {
//   @override
//   AssetRepresentationInterface createGraphic(
//       AssetTypeEnum type, AssetRepresentationParams params) {
//     AssetRepresentationInterface chair;
//     switch (type) {
//       case AssetTypeEnum.chairSmall:
//         chair = ChairSmall(params);
//         break;
//       case AssetTypeEnum.chairStack:
//         chair = ChairStack(params);
//         break;
//       default:
//         throw Exception('Chair with type $type cannot be created');
//     }
//     return chair;
//   }
// }
