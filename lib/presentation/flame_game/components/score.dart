import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Score extends TextComponent {
  Score(this.scoreText, Vector2 position,)
      : super(
          text: scoreText,
          position: position,
          textRenderer: TextPaint(
            style: const TextStyle(
              fontSize: 30,
              color: Colors.white,
              fontFamily: 'Press Start 2P',
            ),
          ),
        );

  final String scoreText;

  void increment(String value) {
    text = scoreText.replaceFirst('0', value);
  }
}
