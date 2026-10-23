import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart' hide Timer;
import 'package:flame/events.dart';
import 'package:flame/experimental.dart' show Rectangle;
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:game_test/game/components/ball.dart';
import 'package:game_test/game/components/score.dart';
import 'package:game_test/game/helpers/direction.dart';
import 'package:game_test/game/game_screen.dart';
import 'package:game_test/game/components/player.dart';
import 'package:game_test/game/components/enemy.dart';
import 'package:game_test/provider/settings_provider.dart';

import 'background.dart';

class MyWorld extends FlameGame with HasCollisionDetection, KeyboardEvents {
  final scoreNotifier = ValueNotifier<int>(0);
  final SettingsProvider provider;

  MyWorld(this.provider);

  late Player player;
  Timer? _countdownTimer;

  @override
  void onMount() {
    super.onMount();
    overlays.add(GameScreen.pauseKey);
    overlays.add(GameScreen.leftBottomController);
    overlays.add(GameScreen.rightBottomController);
  }

  @override
  void onRemove() {
    _countdownTimer?.cancel();
    scoreNotifier.dispose();
    overlays.remove(GameScreen.pauseKey);
    overlays.remove(GameScreen.leftBottomController);
    overlays.remove(GameScreen.rightBottomController);
    super.onRemove();
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
    await super.onLoad();
    final goalForWin = provider.goalForWin;
    final pointLiveTime = provider.pointLiveTime;
    final maxSizeWorld = provider.worldSize;
    player = Player(addScore: _addScore, maxSizeWorld: maxSizeWorld);
    await world.add(Background(maxSizeWorld: maxSizeWorld));
    await world.add(player);
    camera.follow(player);
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

    final scoreComponent = Score('Embers: 0 / $goalForWin', Vector2.all(30));
    var remainingSeconds = provider.timer.inSeconds;
    final gameTimer = TextComponent(
      text: _formatTimer(remainingSeconds),
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
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (paused) return;
      remainingSeconds--;
      gameTimer.text = _formatTimer(remainingSeconds);
      if (remainingSeconds <= 0) {
        timer.cancel();
        pauseEngine();
        overlays.add(GameScreen.timeLeftKey);
      }
    });
    scoreNotifier.addListener(() {
      if (scoreNotifier.value >= goalForWin) {
        _countdownTimer?.cancel();
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

  String _formatTimer(int totalSeconds) {
    final minutes = totalSeconds ~/ 60;
    final seconds = totalSeconds % 60;
    return 'Timer: $minutes:${seconds.toString().padLeft(2, '0')}';
  }
}
