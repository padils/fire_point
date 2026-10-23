// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:game_test/game/helpers/direction.dart';
import 'package:game_test/provider/settings_provider.dart';

void main() {
  group('Direction', () {
    test('maps joystick offsets to eight directions', () {
      expect(Direction.fromOffset(Offset.zero), Direction.none);
      expect(Direction.fromOffset(const Offset(30, 0)), Direction.right);
      expect(Direction.fromOffset(const Offset(30, 30)), Direction.downRight);
      expect(Direction.fromOffset(const Offset(0, 30)), Direction.down);
      expect(Direction.fromOffset(const Offset(-30, 30)), Direction.downLeft);
      expect(Direction.fromOffset(const Offset(-30, 0)), Direction.left);
      expect(Direction.fromOffset(const Offset(-30, -30)), Direction.upLeft);
      expect(Direction.fromOffset(const Offset(0, -30)), Direction.up);
      expect(Direction.fromOffset(const Offset(30, -30)), Direction.upRight);
    });

    test('diagonal vectors preserve movement speed', () {
      expect(Direction.upRight.unitVector.length, closeTo(1, 0.000001));
      expect(Direction.downLeft.unitVector.length, closeTo(1, 0.000001));
    });
  });

  group('SettingsProvider', () {
    test('supports custom numeric values and reset', () {
      final settings = SettingsProvider()
        ..updateCustom(
          goal: 12,
          speed: 9,
          lifetime: 4,
          timerSeconds: 90,
          width: 1200,
          height: 800,
        );

      expect(settings.currentType, isNull);
      expect(settings.goalForWin, 12);
      expect(settings.worldSize.x, 1200);

      settings.reset();

      expect(settings.currentType, TypesEnum.easy);
      expect(settings.goalForWin, 5);
      expect(settings.timer, const Duration(minutes: 2));
      expect(settings.worldSize.x, 600);
    });

    test('clamps custom values to safe limits', () {
      final settings = SettingsProvider()
        ..updateCustom(
          goal: 0,
          speed: 100,
          lifetime: 0,
          timerSeconds: 0,
          width: 10,
          height: 9000,
        );

      expect(settings.goalForWin, 1);
      expect(settings.ballSpeed, 30);
      expect(settings.pointLiveTime, 1);
      expect(settings.timer, const Duration(seconds: 1));
      expect(settings.worldSize.x, 320);
      expect(settings.worldSize.y, 4000);
    });
  });
}
