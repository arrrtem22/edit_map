import 'dart:collection' show IterableMixin;
import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:edit_map/src/src/helpers/list_extensions.dart';
import 'package:edit_map/src/src/helpers/shape_helper.dart';
import 'package:edit_map/src/src/interfaces/graphic/object_interface.dart';
import 'package:edit_map/src/src/models/graphic/base_graphic.dart';
import 'package:edit_map/src/src/models/graphic/desk/desk.dart';

@immutable
class OfficeMap extends Object with IterableMixin<BaseGraphic> {
  final String? selectedObjectId;
  final List<BaseGraphic> _mapObjects = <BaseGraphic>[];
  final ui.Image? mapImage;
  final double horizontalMapPadding;
  final double verticalMapPadding;
  final double convertedHorizontalMapPadding;
  final double convertedVerticalMapPadding;
  final double ratio;

  OfficeMap({
    this.mapImage,
    this.horizontalMapPadding = .0,
    this.verticalMapPadding = .0,
    this.convertedHorizontalMapPadding = .0,
    this.convertedVerticalMapPadding = .0,
    this.ratio = 1.0,
    this.selectedObjectId,
    List<BaseGraphic>? objects,
  }) {
    if (objects != null) {
      _mapObjects.addAll(objects);
    }
    // else {
    //   // Generate boardPoints for a fresh board.
    //   var boardPoint = _getNextBoardPoint(null);
    //   while (boardPoint != null) {
    //     _boardPoints.add(boardPoint);
    //     boardPoint = _getNextBoardPoint(boardPoint);
    //   }
    // }
  }

  @override
  Iterator<BaseGraphic> get iterator => _BoardIterator(_mapObjects);

  void drawMap(Canvas canvas) {
    Paint paint = Paint()..color = Colors.green;

    canvas.scale(ratio);

    if (mapImage != null) {
      canvas.drawImage(mapImage!, const Offset(0, 0), paint);
    }
    // mapSvg.scaleCanvasToViewBox(canvas, size);
    // mapSvg.clipCanvasToViewBox(canvas);
    // mapSvg.draw(canvas, bounds);
  }

  void drawObjects(Canvas canvas) {
    for (final object in _mapObjects) {
      object.draw(canvas);
    }
  }

  // For a given q axial coordinate, get the range of possible r values
  // See the definition of BoardPoint for more information about hex grids and
  // axial coordinates.
  // _Range _getRRangeForQ(int q) {
  //   int rStart;
  //   int rEnd;
  //   if (q <= 0) {
  //     rStart = -boardRadius - q;
  //     rEnd = boardRadius;
  //   } else {
  //     rEnd = boardRadius - q;
  //     rStart = -boardRadius;
  //   }
  //
  //   return _Range(rStart, rEnd);
  // }

  // Check if the board point is actually on the board.
  // ignore: unused_element
  bool _validateBoardPoint(BaseGraphic boardPoint) {
    // const center = ObjectInterface(0, 0);
    // final distanceFromCenter = getDistance(center, boardPoint);
    // TODO implement method
    return true;
  }

  // Get the distance between two BoardPoints.
  static double getDistance(BaseGraphic a, BaseGraphic b) {
    final point1 = a.coordinates;
    final point2 = b.coordinates;
    return sqrt(pow(point2.dx - point1.dx, 2) + pow(point2.dy - point1.dy, 2));
  }

  // Return the q,r BoardPoint for a point in the scene, where the origin is in
  // the center of the board in both coordinate systems. If no BoardPoint at the
  // location, return null.
  BaseGraphic? determinateSelectedObject(Offset offset) {
    Offset point = Offset(offset.dx, offset.dy);
    BaseGraphic? selectedGraphic;
    for (final object in _mapObjects) {
      if (object is Desk) {
        if (isPointInPolygon(point, object.getShape())) {
          selectedGraphic = object;
        }
      }
    }
    if (kDebugMode) {
      print('selected object id: ${selectedGraphic?.id ?? 'null'}');
      print(point);
    }
    return selectedGraphic;
    // final BaseGraphic object =
    //     (_mapObjects as List<BaseGraphic?>).firstWhere((BaseGraphic? object) {
    //   bool isPointInObject = false;
    //   if (object is Desk) {
    //     isPointInObject = isPointInPolygon(point, object.shape);
    //   }
    //   return isPointInObject;
    // });
  }

  // // Return a scene point for the center of a hexagon given its q,r point.
  // Point<double> boardPointToPoint(ObjectInterface boardPoint) {
  //   return Point<double>(
  //     sqrt(3) * hexagonRadius * boardPoint.q +
  //         sqrt(3) / 2 * hexagonRadius * boardPoint.r +
  //         size.width / 2,
  //     1.5 * hexagonRadius * boardPoint.r + size.height / 2,
  //   );
  // }

  // // Get Vertices that can be drawn to a Canvas for the given BoardPoint.
  // Vertices getVerticesForBoardPoint(ObjectInterface boardPoint, Color color) {
  //   final centerOfHexZeroCenter = boardPointToPoint(boardPoint);
  //
  //   final positions = positionsForHexagonAtOrigin.map((offset) {
  //     return offset.translate(centerOfHexZeroCenter.x, centerOfHexZeroCenter.y);
  //   }).toList();
  //
  //   return Vertices(
  //     VertexMode.triangleFan,
  //     positions,
  //     colors: List<Color>.filled(positions.length, color),
  //   );
  // }

  // Return a new board with the given Object selected.
  OfficeMap copyWithSelected(BaseGraphic? object) {
    if (selectedObjectId == object?.id) {
      return this;
    }
    OfficeMap nextBoard =
        copyWithBoardObjectStateType(selectedObjectId, StateType.main);

    return nextBoard.copyWithBoardObjectStateType(object?.id, StateType.active);
  }

  // Return a new board where boardPoint has the given color.
  OfficeMap copyWithBoardObjectStateType(
    String? objectId,
    StateType stateType,
  ) {
    if (objectId == null) return this;

    final BaseGraphic? oldObject =
        _mapObjects.firstWhereOrNull((element) => element.id == objectId);
    if (oldObject == null) return this;

    late BaseGraphic newObject;

    if (oldObject is Desk) {
      newObject = oldObject.copyWith(stateType: stateType);

      final int boardPointIndex = _mapObjects.indexWhere(
          (BaseGraphic boardObject) =>
              boardObject is Desk && boardObject.id == newObject.id);

      if (_mapObjects[boardPointIndex] == oldObject &&
          oldObject.stateType == stateType) {
        return this;
      }

      final nextMapObjects = List<BaseGraphic>.from(_mapObjects);
      nextMapObjects[boardPointIndex] = newObject;
      // final selectedBoardPoint = object == selected ? newObject : selected;
      return OfficeMap(
        mapImage: mapImage,
        selectedObjectId: objectId,
        objects: nextMapObjects,
        horizontalMapPadding: horizontalMapPadding,
        verticalMapPadding: verticalMapPadding,
        convertedHorizontalMapPadding: convertedHorizontalMapPadding,
        convertedVerticalMapPadding: convertedVerticalMapPadding,
        ratio: ratio,
      );
    }
    return this;
  }

  OfficeMap clearSelection() {
    return copyWithBoardObjectStateType(selectedObjectId, StateType.main);
  }

  OfficeMap copyWith({
    String? selectedObjectId,
    List<BaseGraphic>? mapObjects,
    ui.Image? mapImage,
    double? horizontalMapPadding,
    double? verticalMapPadding,
    double? convertedHorizontalMapPadding,
    double? convertedVerticalMapPadding,
    double? ratio,
  }) {
    return OfficeMap(
      selectedObjectId: selectedObjectId ?? this.selectedObjectId,
      mapImage: mapImage ?? this.mapImage,
      objects: mapObjects ?? _mapObjects,
      horizontalMapPadding: horizontalMapPadding ?? this.horizontalMapPadding,
      verticalMapPadding: verticalMapPadding ?? this.verticalMapPadding,
      convertedHorizontalMapPadding:
          convertedHorizontalMapPadding ?? this.convertedHorizontalMapPadding,
      convertedVerticalMapPadding:
          convertedVerticalMapPadding ?? this.convertedVerticalMapPadding,
      ratio: ratio ?? this.ratio,
    );
  }
}

class _BoardIterator extends Iterator<BaseGraphic> {
  _BoardIterator(this.boardPoints);

  final List<BaseGraphic> boardPoints;
  int currentIndex = 0;

  @override
  late BaseGraphic current;

  @override
  bool moveNext() {
    currentIndex += 1;

    if (currentIndex >= boardPoints.length) {
      return false;
    }

    current = boardPoints[currentIndex];
    return true;
  }
}
