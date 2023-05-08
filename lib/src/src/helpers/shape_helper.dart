import 'dart:math';

import 'package:flutter/material.dart';

Offset rotatePoint(
  Offset point,
  Offset center,
  double angleDeg,
) {
  final angleRad = angleDeg * (pi / 180);
  final rotatedX = cos(angleRad) * (point.dx - center.dx) -
      sin(angleRad) * (point.dy - center.dy) +
      center.dx;
  final rotatedY = sin(angleRad) * (point.dx - center.dx) +
      cos(angleRad) * (point.dy - center.dy) +
      center.dy;
  return Offset(rotatedX, rotatedY);
}

Offset determinateRectCenter(List<Offset>? coords) {
  if (coords == null) return const Offset(0, 0);
  final Offset topLeft = Offset(coords[0].dx, coords[0].dy);
  final Offset bottomRight = Offset(coords[2].dx, coords[2].dy);

  final double centerX = (topLeft.dx + bottomRight.dx) / 2;
  final double centerY = (topLeft.dy + bottomRight.dy) / 2;
  return Offset(centerX, centerY);
}

bool isPointInPolygon(Offset p, List<Offset> polygon) {
  double minX = polygon[0].dx;
  double maxX = polygon[0].dx;
  double minY = polygon[0].dy;
  double maxY = polygon[0].dy;
  for (int i = 1; i < polygon.length; i++) {
    Offset q = polygon[i];
    minX = min(q.dx, minX);
    maxX = max(q.dx, maxX);
    minY = min(q.dy, minY);
    maxY = max(q.dy, maxY);
  }

  if (p.dx < minX || p.dx > maxX || p.dy < minY || p.dy > maxY) {
    return false;
  }

  bool inside = false;
  for (int i = 0, j = polygon.length - 1; i < polygon.length; j = i++) {
    if ((polygon[i].dy > p.dy) != (polygon[j].dy > p.dy) &&
        p.dx <
            (polygon[j].dx - polygon[i].dx) *
                    (p.dy - polygon[i].dy) /
                    (polygon[j].dy - polygon[i].dy) +
                polygon[i].dx) {
      inside = !inside;
    }
  }

  return inside;
}
