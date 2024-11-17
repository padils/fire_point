import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/extensions.dart';
import 'package:flame/geometry.dart';
import 'package:game_test/flame_game/components/player.dart';
import 'package:game_test/flame_game/helpers/direction.dart';

class Ball extends SpriteComponent with HasGameReference, CollisionCallbacks {
  Ball(
    this.maxSizeWorld,
    this.direction,
    this.initPosition,
    this.ballSpeed,
  ) : super(
          size: spriteSize,
          anchor: Anchor.center,
          position: initPosition,
        );

  static final Vector2 spriteSize = Vector2.all(30);
  final int ballSpeed;

  final Direction direction;

  final Vector2 maxSizeWorld;
  final Vector2 initPosition;

  @override
  Future<void> onLoad() async {
    final ball = await game.images.load(
      'ball.png',
    );

    sprite = Sprite(ball);
    add(CircleHitbox());
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    moveBall();
    Future.delayed(const Duration(seconds: 3), () {
      removeFromParent();
    });
  }

  void moveBall() {
    switch (direction) {
      case Direction.up:
        add(
          RotateEffect.by(
            tau / 4,
            EffectController(speed: 0.3, infinite: true),
          ),
        );
        add(
          MoveByEffect(
            Vector2(0, -maxSizeWorld.y),
            EffectController(speed: 5),
          ),
        );
        break;
      case Direction.down:
      case Direction.none:
        add(
          RotateEffect.by(
            tau / 4,
            EffectController(speed: 0.3, infinite: true),
          ),
        );
        add(
          MoveByEffect(
            Vector2(0, maxSizeWorld.y),
            EffectController(speed: 10),
          ),
        );

        break;
      case Direction.left:
        // moveLeft(delta);
        add(
          RotateEffect.by(
            tau / 4,
            EffectController(speed: 0.3, infinite: true),
          ),
        );
        add(
          MoveByEffect(
            Vector2(-maxSizeWorld.x, 0),
            EffectController(speed: 10),
          ),
        );
        break;
      case Direction.right:
        // moveRight(delta);
        add(
          RotateEffect.by(
            tau / 4,
            EffectController(speed: 0.3, infinite: true),
          ),
        );
        add(
          MoveByEffect(
            Vector2(maxSizeWorld.x, 0),
            EffectController(speed: 10),
          ),
        );
        break;
    }
  }
}
