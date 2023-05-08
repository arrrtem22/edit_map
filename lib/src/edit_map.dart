import 'dart:io';
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:edit_map/src/src/models/graphic/params/desk_params.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:edit_map/src/src/builders/graphic/desk_builder.dart';
import 'package:edit_map/src/src/map_values.dart';
import 'package:edit_map/src/src/models/graphic/base_graphic.dart';
import 'package:edit_map/src/src/models/graphic/desk/desk_values.dart';
import 'package:edit_map/src/src/models/graphic/office_map.dart';

export 'package:edit_map/src/src/models/graphic/params/desk_params.dart';

const logsEnabled = true;

/// Draw container with black border around draggable desk.
const double draggableDeskPadding = 50;

/// Size of icon that a user sees in edit mode with draggable desk.
const fourDirectionArrowIconSize = Size(18, 18);

class EditMap extends StatefulWidget {
  final File mapImage;

  /// It can be a draggable desk (in edit mode) also it can be just selected
  /// desk on the map with highlighting.
  final DeskPayload? selectedDesk;
  final List<DeskPayload> deskParamsList;
  final Color? backgroundWithDraggableObject;
  final Color? background;
  final bool isEditMode;
  final void Function(Offset offset)? onDeskMoved;
  final void Function(DeskPayload? deskParams)? onObjectSelected;

  const EditMap({
    Key? key,
    required this.mapImage,
    required this.deskParamsList,
    this.selectedDesk,
    this.onDeskMoved,
    this.background = Colors.white,
    this.backgroundWithDraggableObject = Colors.red,
    this.onObjectSelected,
    this.isEditMode = false,
  }) : super(key: key);

  @override
  _EditMapState createState() => _EditMapState();
}

class _EditMapState extends State<EditMap>
    with TickerProviderStateMixin {
  static const DeskBuilder deskBuilder = DeskBuilder();
  final GlobalKey interactiveViewerKey = GlobalKey();
  final GlobalKey stackKey = GlobalKey();

  final TransformationController transformationController =
      TransformationController();
  Animation<Matrix4>? _animationReset;
  late AnimationController _controllerReset;
  Matrix4? _homeMatrix;

  OfficeMap? officeMap;

  Offset draggableDeskPosition = const Offset(0.0, 0.0);
  late Offset initialPosition;

  void _onAnimateReset() {
    transformationController.value = _animationReset!.value;
    if (_controllerReset.isAnimating == false) {
      _animationReset?.removeListener(_onAnimateReset);
      _animationReset = null;
      _controllerReset.reset();
    }
  }

  void animateResetInitialize() {
    _controllerReset.reset();
    _animationReset = Matrix4Tween(
      begin: transformationController.value,
      end: _homeMatrix,
    ).animate(_controllerReset);
    _controllerReset.duration = const Duration(milliseconds: 400);
    _animationReset?.addListener(_onAnimateReset);
    _controllerReset.forward();
  }

  void animateResetStop() {
    _controllerReset.stop();
    _animationReset?.removeListener(_onAnimateReset);
    _animationReset = null;
    _controllerReset.reset();
  }

  void onScaleStart(ScaleStartDetails details) {
    // If the user tries to cause a transformation while the reset animation is
    // running, cancel the reset animation.
    if (_controllerReset.status == AnimationStatus.forward) {
      animateResetStop();
    }
  }

  @override
  void initState() {
    _controllerReset = AnimationController(
      vsync: this,
    );
    super.initState();
  }

  @override
  void didUpdateWidget(EditMap oldWidget) {
    if (widget.isEditMode) {
      if (oldWidget.selectedDesk == null && widget.selectedDesk != null) {
        animateResetInitialize();
        if (widget.selectedDesk?.area.position == null) {
          // TODO(Aremii): find another solution
          draggableDeskPosition = initialPosition;
        } else {
          draggableDeskPosition = Offset(
            widget.selectedDesk!.area.position!.dx * officeMap!.ratio -
                draggableDeskPadding,
            widget.selectedDesk!.area.position!.dy * officeMap!.ratio -
                draggableDeskPadding,
          );
        }
        officeMap = officeMap!.clearSelection();
        onDeskMoved(draggableDeskPosition);
      }
    }
    if (!listEquals(oldWidget.deskParamsList, widget.deskParamsList)) {
      final List<BaseGraphic> objects = [];
      for (final deskParams in widget.deskParamsList) {
        objects.add(deskBuilder.create(deskParams));
      }
      officeMap = officeMap!.copyWith(mapObjects: objects);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    if (officeMap == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        final Size size = context.size!;
        final codec =
            await ui.instantiateImageCodec(await widget.mapImage.readAsBytes());
        final mapImage = (await codec.getNextFrame()).image;
        final int imageHeight = mapImage.height;
        final int imageWidth = mapImage.width;

        // Start the first render, start the scene centered in the viewport.
        _homeMatrix ??= transformationController.value;

        double horizontalPadding = 0.0;
        double verticalPadding = 0.0;
        final svgMapRatio = imageHeight / imageWidth;
        final deviceMapRatio = size.height / size.width;
        if (deviceMapRatio < svgMapRatio) {
          final rightDeviceMapWidth = size.height * imageWidth / imageHeight;
          horizontalPadding = (size.width - rightDeviceMapWidth) / 2;
        } else if (deviceMapRatio > svgMapRatio) {
          final rightDeviceMapHeight = size.width * imageHeight / imageWidth;
          verticalPadding = (size.height - rightDeviceMapHeight) / 2;
        }

        final List<BaseGraphic> objects = [];
        for (final deskParams in widget.deskParamsList) {
          objects.add(deskBuilder.create(deskParams));
        }

        final double widthRatio = (size.width - horizontalPadding) / imageWidth;
        final double heightRatio =
            (size.height - verticalPadding) / imageHeight;

        final OfficeMap officeMap = OfficeMap(
          mapImage: mapImage,
          horizontalMapPadding: horizontalPadding,
          verticalMapPadding: verticalPadding,
          convertedHorizontalMapPadding: horizontalPadding / widthRatio,
          convertedVerticalMapPadding: verticalPadding / heightRatio,
          objects: objects,
          ratio: horizontalPadding == 0 ? widthRatio : heightRatio,
        );

        final draggableDeskInitialPosition = Offset(
          mapImage.width / 2 * officeMap.ratio - draggableDeskPadding,
          mapImage.height / 2 * officeMap.ratio - draggableDeskPadding,
        );

        setState(() {
          this.officeMap = officeMap;
          initialPosition = draggableDeskInitialPosition;
        });
      });
      return Container(
        color: whiteColor,
        constraints: const BoxConstraints.expand(),
      );
    }
    final Widget mapWidget = RepaintBoundary(
      child: CustomPaint(
        // TODO(Artemii): Split custom painter for map and objects
        painter: MapPainter(officeMap!),
      ),
    );

    if (widget.isEditMode) {
      final bool isDraggableDeskNull = widget.selectedDesk == null;
      final Widget deskWidget = _DraggableDeskWidget(
        officeMap: officeMap,
        rotation: widget.selectedDesk?.area.rotation ?? 0.0,
      );
      return Container(
        padding: EdgeInsets.only(
          top: isDraggableDeskNull ? 0 : officeMap!.verticalMapPadding,
          left: isDraggableDeskNull ? 0 : officeMap!.horizontalMapPadding,
        ),
        color: isDraggableDeskNull
            ? widget.background
            : widget.backgroundWithDraggableObject,
        child: SizedBox(
          width: isDraggableDeskNull
              ? null
              : officeMap!.mapImage!.width.toDouble() * officeMap!.ratio,
          height: isDraggableDeskNull
              ? null
              : officeMap!.mapImage!.height.toDouble() * officeMap!.ratio,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTapUp: isDraggableDeskNull ? onTapUp : null,
            child: InteractiveViewer(
              key: interactiveViewerKey,
              maxScale: isDraggableDeskNull ? 6 : 1,
              minScale: 1,
              transformationController: transformationController,
              onInteractionStart: onScaleStart,
              child: Stack(
                key: stackKey,
                children: [
                  !isDraggableDeskNull
                      ? mapWidget
                      : Positioned(
                          left: officeMap!.horizontalMapPadding,
                          top: officeMap!.verticalMapPadding,
                          child: mapWidget,
                        ),
                  if (!isDraggableDeskNull)
                    Positioned(
                      left: draggableDeskPosition.dx,
                      top: draggableDeskPosition.dy,
                      child: Draggable(
                        onDragEnd: (dragDetails) {
                          onDeskMoved(dragDetails.offset, needToSetState: true);
                        },
                        feedback: deskWidget,
                        child: deskWidget,
                        childWhenDragging: Container(),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapUp: onTapUp,
        child: InteractiveViewer(
          key: interactiveViewerKey,
          maxScale: 6,
          minScale: 1,
          transformationController: transformationController,
          onInteractionStart: onScaleStart,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: officeMap!.horizontalMapPadding,
              vertical: officeMap!.verticalMapPadding,
            ),
            child: mapWidget,
          ),
        ),
      );
    }
  }

  Offset convertOffset(Offset position) {
    final renderBox =
        interactiveViewerKey.currentContext?.findRenderObject() as RenderBox;
    final offset = position - renderBox.localToGlobal(Offset.zero);
    return transformationController.toScene(offset);
  }

  void onDeskMoved(Offset offset, {bool needToSetState = false}) {
    final deskTopLeftPoint = convertOffset(
        offset + const Offset(draggableDeskPadding, draggableDeskPadding));
    final deskInDraggableWrapperTopLeftPoint = convertOffset(offset);

    if (deskTopLeftPoint.dy > 0 &&
        deskTopLeftPoint.dy < officeMap!.mapImage!.height * officeMap!.ratio &&
        deskTopLeftPoint.dx > 0 &&
        deskTopLeftPoint.dx < officeMap!.mapImage!.width * officeMap!.ratio) {
      _print('x: ${deskTopLeftPoint.dx}');
      _print('y: ${deskTopLeftPoint.dy}');
      draggableDeskPosition = deskInDraggableWrapperTopLeftPoint;
      widget.onDeskMoved?.call(Offset(deskTopLeftPoint.dx / officeMap!.ratio,
          deskTopLeftPoint.dy / officeMap!.ratio));
      if (needToSetState) setState(() {});
    }
  }

  void onTapUp(TapUpDetails details) {
    final scenePoint = convertOffset(details.globalPosition);
    final mapObject = officeMap?.determinateSelectedObject(Offset(
        (scenePoint.dx - officeMap!.horizontalMapPadding) / officeMap!.ratio,
        (scenePoint.dy - officeMap!.verticalMapPadding) / officeMap!.ratio));
    if (mapObject != null) {
      widget.onObjectSelected?.call(widget.deskParamsList
          .firstWhere((element) => element.id == mapObject.id));
    }
    setState(() {
      officeMap = officeMap!.copyWithSelected(mapObject);
    });
  }
}

class _DraggableDeskWidget extends StatelessWidget {
  const _DraggableDeskWidget({
    Key? key,
    required this.officeMap,
    required this.rotation,
  }) : super(key: key);

  final OfficeMap? officeMap;
  final double rotation;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      origin: Offset(-commonDeskSize.width * officeMap!.ratio / 2,
          -commonDeskSize.height * officeMap!.ratio / 2),
      angle: rotation * math.pi / 180,
      child: Container(
        padding: const EdgeInsets.all(draggableDeskPadding),
        decoration: BoxDecoration(border: Border.all()),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: activeBorderColor,
                boxShadow: [
                  BoxShadow(
                      spreadRadius: 1,
                      blurRadius: 1,
                      color: Colors.black.withOpacity(0.3)),
                ],
              ),
              width: commonTabletopSize.width * officeMap!.ratio,
              height: commonTabletopSize.height * officeMap!.ratio,
            ),
            Padding(
              padding: const EdgeInsets.only(top: chairMargin),
              child: Container(
                decoration: BoxDecoration(
                  color: activeBorderColor,
                  boxShadow: [
                    BoxShadow(
                        spreadRadius: 1,
                        blurRadius: 1,
                        color: Colors.black.withOpacity(0.3)),
                  ],
                ),
                width: deskChairSize.width * officeMap!.ratio,
                height: deskChairSize.height * officeMap!.ratio,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MapPainter extends CustomPainter {
  final OfficeMap officeMap;

  MapPainter(this.officeMap);

  @override
  void paint(Canvas canvas, Size size) {
    officeMap.drawMap(canvas);

    officeMap.drawObjects(canvas);
  }

  @override
  bool shouldRepaint(covariant MapPainter oldDelegate) {
    return oldDelegate.officeMap != officeMap;
  }
}

// ignore: avoid_print
_print(Object? object) => logsEnabled ? print(object) : null;
