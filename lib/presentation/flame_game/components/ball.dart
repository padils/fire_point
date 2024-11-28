import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:game_test/presentation/flame_game/helpers/direction.dart';

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


  final double rotationSpeed = 40 * 3.14;

  @override
  Future<void> onLoad() async {
    final ball = await game.images.load(
      'ball2.png',
    );
    sprite = Sprite(ball);
    add(CircleHitbox());
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    const dt = 1.0;

    moveBall(dt);
    Future.delayed(const Duration(seconds: 3), () {
      removeFromParent();
    });
  }

  void moveUp(double delta) {
    position.add(Vector2(0, delta * -ballSpeed));
  }

  void moveDown(double delta) {
    position.add(Vector2(0, delta * ballSpeed));
  }

  void moveLeft(double delta) {
    position.add(Vector2(delta * -ballSpeed, 0));
  }

  void moveRight(double delta) {
    position.add(Vector2(delta * ballSpeed, 0));
  }

  void moveBall(double dt) {
    angle -= rotationSpeed * dt;
    switch (direction) {
      case Direction.up:
        moveUp(dt);
      case Direction.down:
      case Direction.none:
        moveDown(dt);
      case Direction.left:
        moveLeft(dt);
      case Direction.right:
        moveRight(dt);
    }
  }
}
