import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:game_test/flame_game/components/ball.dart';

class Point extends SpriteAnimationComponent
    with HasGameReference, CollisionCallbacks {
  final void Function() addScore;
  final int pointLiveTime;

  Point(
    this.addScore,
    this.pointLiveTime,
  ) : super(
          size: Vector2.all(80),
          anchor: Anchor.center,
        );

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
  void render(Canvas canvas) {
    super.render(canvas);
    Future.delayed(Duration(seconds: pointLiveTime), () {
      removeFromParent();
    });
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
