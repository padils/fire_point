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
  TypesEnum currentType = TypesEnum.easy;
  int goalForWin = 5;
  int ballSpeed = 1;
  int pointLiveTime = 3;
  Duration timer = const Duration(minutes: 2);
  Vector2 worldSize = Vector2(600, 600);

  void setType(TypesEnum type) {
    currentType = type;
    if (type == TypesEnum.easy) {
      goalForWin = 5;
      ballSpeed = 3;
      pointLiveTime = 3;
      worldSize = Vector2(600, 600);
      timer = const Duration(seconds: 120);
    }
    if (type == TypesEnum.hard) {
      goalForWin = 8;
      ballSpeed = 2;
      pointLiveTime = 2;
      worldSize = Vector2(600, 600);
      timer = const Duration(seconds: 8);
    }
    if (type == TypesEnum.infinity) {
      goalForWin = 9999;
      ballSpeed = 4;
      pointLiveTime = 9999;
      worldSize = Vector2(999, 999);
      timer = const Duration(seconds: 9999);
    }

    notifyListeners();
  }
}
