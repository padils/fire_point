import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart' hide Timer;
import 'package:flame/events.dart';
import 'package:flame/experimental.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:game_test/game/components/ball.dart';
import 'package:game_test/game/components/score.dart';
import 'package:game_test/game/helpers/direction.dart';
import 'package:game_test/game/game_screen.dart';
import 'package:game_test/game/components/player.dart';
import 'package:game_test/game/components/enemy.dart';
import 'package:game_test/provider/settings_provider.dart';
import 'package:leap/leap.dart';

import 'background.dart';

class MyWorld extends LeapGame with HasCollisionDetection, KeyboardEvents {
  final scoreNotifier = ValueNotifier<int>(0);
  final SettingsProvider provider;
  final Vector2 screenSize;

  MyWorld(
    this.provider,
    this.screenSize,
  ) : super(
          tileSize: 20,
          configuration: const LeapConfiguration(
            tiled: TiledOptions(
              atlasMaxX: 846,
              atlasMaxY: 846,
            ),
          ),
        );
  late Player player;

  @override
  void onMount() {
    super.onMount();
    overlays.add(GameScreen.pauseKey);
    overlays.add(GameScreen.leftBottomController);
    overlays.add(GameScreen.rightBottomController);
  }

  @override
  void onRemove() {
    overlays.remove(GameScreen.pauseKey);
    overlays.add(GameScreen.leftBottomController);
    overlays.add(GameScreen.rightBottomController);
  }

  @override
  KeyEventResult onKeyEvent(
    KeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    if (event.logicalKey == LogicalKeyboardKey.space && event is KeyUpEvent) {
      trowBall();
    }
    return KeyEventResult.handled;
  }

  @override
  Future<void> onLoad() async {
    final goalForWin = provider.goalForWin;
    final pointLiveTime = provider.pointLiveTime;
    final maxSizeWorld = provider.worldSize;
    player = Player(
      addScore: _addScore,
      maxSizeWorld: maxSizeWorld,
    );
    camera.follow(player);

    world.add(
      Background(
        maxSizeWorld: maxSizeWorld,
      ),
    );
    world.add(player);
    world.add(
      SpawnComponent(
        factory: (_) => Enemy(_addScore, pointLiveTime),
        period: 1.0,
        area: Rectangle.fromPoints(
          Vector2(maxSizeWorld.x, 0),
          Vector2(0, maxSizeWorld.y),
        ),
        random: Random(),
      ),
    );

    final scoreComponent = Score(
      'Embers: 0 / $goalForWin',
      Vector2.all(30),
    );
    Duration timerTime = provider.timer;
    DateTime dateTime = DateTime.fromMicrosecondsSinceEpoch(timerTime.inMicroseconds);
    final gameTimer = TextComponent(
      text: 'Timer: ${dateTime.minute}:${dateTime.second}',
      position: Vector2(30, 60),
      textRenderer: TextPaint(
        style: const TextStyle(
          fontSize: 25,
          color: Colors.white,
          fontFamily: 'Press Start 2P',
        ),
      ),
    );

    camera.viewport.add(scoreComponent);
    camera.viewport.add(gameTimer);
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (paused) return;
      dateTime = dateTime.subtract(const Duration(seconds: 1));
      gameTimer.text = 'Timer: ${dateTime.minute}:${dateTime.second}';
      if (dateTime.minute * 60 + dateTime.second >= timerTime.inSeconds) {
        timer.cancel();
        pauseEngine();
        overlays.add(GameScreen.timeLeftKey);
      }
    });
    scoreNotifier.addListener(() {
      if (scoreNotifier.value == goalForWin) {
        pauseEngine();
        overlays.add(GameScreen.winDialogKey);
      }

      scoreComponent.increment(scoreNotifier.value.toString());
    });
  }

  void onJoyPadDirectionChanged(Direction direction) {
    player.isRunning = true;
    if (direction == Direction.none) {
      player.isRunning = false;
      return;
    }
    player.direction = direction;
  }

  void trowBall() {
    world.add(
      Ball(
        provider.worldSize,
        player.direction,
        player.position + player.size / 2,
        player.isRunning ? provider.ballSpeed + 5 : provider.ballSpeed,
      ),
    );
  }

  void _addScore() => scoreNotifier.value++;
}
