import 'package:flame/components.dart';
import 'package:flutter/material.dart';

enum TypesEnum {
  easy('Easy'),
  hard('Hard'),
  infinity('Infinity');

  final String key;

  const TypesEnum(this.key);
}

class SettingsProvider with ChangeNotifier {
  TypesEnum? currentType = TypesEnum.easy;
  int goalForWin = 5;
  int ballSpeed = 5;
  int pointLiveTime = 3;
  Duration timer = const Duration(minutes: 2);
  Vector2 worldSize = Vector2(600, 600);

  void setType(TypesEnum type) {
    currentType = type;
    switch (type) {
      case TypesEnum.easy:
        _applyValues(
          goal: 5,
          speed: 5,
          lifetime: 3,
          timerSeconds: 120,
          width: 600,
          height: 600,
        );
      case TypesEnum.hard:
        _applyValues(
          goal: 8,
          speed: 3,
          lifetime: 2,
          timerSeconds: 8,
          width: 600,
          height: 600,
        );
      case TypesEnum.infinity:
        _applyValues(
          goal: 9999,
          speed: 8,
          lifetime: 9999,
          timerSeconds: 9999,
          width: 999,
          height: 999,
        );
    }

    notifyListeners();
  }

  void updateCustom({
    int? goal,
    int? speed,
    int? lifetime,
    int? timerSeconds,
    double? width,
    double? height,
  }) {
    currentType = null;
    goalForWin = (goal ?? goalForWin).clamp(1, 9999);
    ballSpeed = (speed ?? ballSpeed).clamp(1, 30);
    pointLiveTime = (lifetime ?? pointLiveTime).clamp(1, 9999);
    timer = Duration(seconds: (timerSeconds ?? timer.inSeconds).clamp(1, 9999));
    worldSize = Vector2(
      (width ?? worldSize.x).clamp(320, 4000),
      (height ?? worldSize.y).clamp(320, 4000),
    );
    notifyListeners();
  }

  void reset() => setType(TypesEnum.easy);

  void _applyValues({
    required int goal,
    required int speed,
    required int lifetime,
    required int timerSeconds,
    required double width,
    required double height,
  }) {
    goalForWin = goal;
    ballSpeed = speed;
    pointLiveTime = lifetime;
    timer = Duration(seconds: timerSeconds);
    worldSize = Vector2(width, height);
  }
}
