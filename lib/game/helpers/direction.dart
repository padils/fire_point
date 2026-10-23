import 'dart:math' as math;

import 'package:flame/components.dart';
import 'package:flutter/widgets.dart';

enum Direction {
  up,
  upRight,
  right,
  downRight,
  down,
  downLeft,
  left,
  upLeft,
  none;

  Vector2 get unitVector => switch (this) {
    up => Vector2(0, -1),
    upRight => Vector2(_diagonal, -_diagonal),
    right => Vector2(1, 0),
    downRight => Vector2(_diagonal, _diagonal),
    down => Vector2(0, 1),
    downLeft => Vector2(-_diagonal, _diagonal),
    left => Vector2(-1, 0),
    upLeft => Vector2(-_diagonal, -_diagonal),
    none => Vector2.zero(),
  };

  static const double _diagonal = math.sqrt1_2;

  static Direction fromOffset(Offset offset, {double deadZone = 20}) {
    if (offset.distance <= deadZone) {
      return Direction.none;
    }

    final angle = math.atan2(offset.dy, offset.dx);
    final sector = ((angle + math.pi / 8) / (math.pi / 4)).floor() % 8;
    return switch (sector) {
      0 => Direction.right,
      1 => Direction.downRight,
      2 => Direction.down,
      3 => Direction.downLeft,
      4 => Direction.left,
      5 => Direction.upLeft,
      6 => Direction.up,
      7 => Direction.upRight,
      _ => Direction.left,
    };
  }
}
