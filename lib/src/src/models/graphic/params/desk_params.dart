import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:edit_map/src/src/interfaces/graphic/desk/desk_interface.dart';

class Area extends Equatable {
  final double rotation;
  final double scale;
  final Offset? position;

  const Area({
    this.rotation = 0,
    this.scale = 1.0,
    this.position,
  });

  static Area fromJson(Map<String, dynamic> json) {
    return Area(
      rotation: json['rotation'] as double? ?? 0,
      scale: json['scale'] as double? ?? 1.0,
      position: Offset(json['position']['x'], json['position']['y']),
    );
  }

  Map<String, dynamic> get toJson => {
        'rotation': rotation,
        'scale': scale,
        'position': {
          'x': position!.dx,
          'y': position!.dy,
        },
      };

  @override
  List<Object?> get props => [rotation, scale, position];
}

class DeskParams extends Equatable {
  final String id;
  final String? name;
  final Area area;
  final DeskTypeEnum type;

  const DeskParams({
    required this.id,
    this.name,
    this.area = const Area(),
    this.type = DeskTypeEnum.common,
  });

  DeskPayload toDeskPayload({isBooked = false}) {
    return DeskPayload(deskParams: this, isBooked: isBooked);
  }

  DeskParams copyWith({
    String? id,
    String? name,
    Offset? position,
    double? rotation,
    double? scale,
    Area? area,
    DeskTypeEnum? type,
  }) {
    if (position != null || rotation != null || scale != null) {
      area = Area(
        position: position ?? this.area.position,
        rotation: rotation ?? this.area.rotation,
        scale: scale ?? this.area.scale,
      );
    }
    return DeskParams(
      id: id ?? this.id,
      name: name ?? this.name,
      area: area ?? this.area,
      type: type ?? this.type,
    );
  }

  static DeskParams fromJson(Map<String, dynamic> json) {
    return DeskParams(
      id: json['id'] as String? ?? 'undefined',
      name: json['name'] as String?,
      area: Area.fromJson(json['area']),
      type: DeskTypeEnum.common,
    );
  }

  Map<String, dynamic> get toJson => {
        "id": id,
        "name": name ?? '',
        "area": area.toJson,
        "type": 'common',
      };

  @override
  List<Object?> get props => [id, name, area, type];
}

class DeskPayload extends DeskParams {
  final bool isBooked;

  DeskPayload({required DeskParams deskParams, this.isBooked = false})
      : super(
          id: deskParams.id,
          name: deskParams.name,
          area: deskParams.area,
          type: deskParams.type,
        );

  @override
  DeskPayload copyWith({
    String? id,
    String? name,
    Offset? position,
    double? rotation,
    double? scale,
    Area? area,
    DeskTypeEnum? type,
    bool? isBooked,
  }) {
    final deskParams = super.copyWith(
      id: id,
      name: name,
      position: position,
      rotation: rotation,
      scale: scale,
      area: area,
      type: type,
    );
    return DeskPayload(
      deskParams: deskParams,
      isBooked: isBooked ?? this.isBooked,
    );
  }

  @override
  List<Object?> get props => [isBooked, ...super.props];
}
