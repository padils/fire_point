import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:game_test/game/helpers/direction.dart';

class Ball extends SpriteComponent with HasGameReference, CollisionCallbacks {
  Ball(this.maxSizeWorld, this.direction, this.initPosition, this.ballSpeed)
    : super(size: spriteSize, anchor: Anchor.center, position: initPosition);

  static final Vector2 spriteSize = Vector2.all(30);
  final int ballSpeed;

  final Direction direction;

  final Vector2 maxSizeWorld;
  final Vector2 initPosition;

  static const double _rotationSpeed = 4;
  static const double _lifeTime = 3;
  double _age = 0;

  @override
  Future<void> onLoad() async {
    final ball = await game.images.load('ball2.png');
    sprite = Sprite(ball);
    add(CircleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    _age += dt;
    if (_age >= _lifeTime) {
      removeFromParent();
    }

    angle -= _rotationSpeed * dt;
    final travelDirection = direction == Direction.none
        ? Direction.down
        : direction;
    position.add(travelDirection.unitVector * (ballSpeed * 60 * dt));
  }
}
