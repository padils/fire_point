import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:game_test/game/components/ball.dart';

class Enemy extends SpriteAnimationComponent
    with HasGameReference, CollisionCallbacks {
  final void Function() addScore;
  final int pointLiveTime;
  double _age = 0;

  Enemy(this.addScore, this.pointLiveTime)
    : super(size: Vector2.all(80), anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    animation = await game.loadSpriteAnimation(
      'ember.png',
      SpriteAnimationData.sequenced(
        amount: 4,
        textureSize: Vector2.all(16),
        stepTime: 0.15,
      ),
    );
    flipHorizontallyAroundCenter();
    add(CircleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    _age += dt;
    if (_age >= pointLiveTime) {
      removeFromParent();
    }
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is Ball) {
      addScore();
      removeFromParent();
    }
  }
}
