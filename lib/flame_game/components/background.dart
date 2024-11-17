import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/flame.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';

class Background extends SpriteComponent {
  final Vector2 maxSizeWorld;

  Background({
    required this.maxSizeWorld,
  });

  @override
  Future<void> onLoad() async {
    var background = await Flame.images.load('grass.jpg');
    size = (Vector2(600, 1020)..add(maxSizeWorld));
    position = Vector2(-300, -550);
    sprite = Sprite(background);
  }
}
