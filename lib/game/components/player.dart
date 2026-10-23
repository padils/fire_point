import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import '../helpers/direction.dart';

import 'package:flame/sprite.dart';

class Player extends SpriteAnimationComponent with HasGameReference {
  final int _playerSpeed = 300;

  int get playerSpeed => _playerSpeed;
  final double _animationSpeed = 0.15;

  late final SpriteAnimation _runDownAnimation;
  late final SpriteAnimation _runLeftAnimation;
  late final SpriteAnimation _runUpAnimation;
  late final SpriteAnimation _runRightAnimation;
  late SpriteAnimation _standingAnimation;
  late final SpriteAnimation _standingDownAnimation;
  late final SpriteAnimation _standingLeftAnimation;
  late final SpriteAnimation _standingUpAnimation;
  late final SpriteAnimation _standingRightAnimation;
  final void Function() addScore;
  final Vector2 maxSizeWorld;
  late bool isRunning;

  late Direction direction;

  Player({required this.addScore, required this.maxSizeWorld})
    : super(
        size: Vector2(100, 100),
        position: Vector2(maxSizeWorld.x / 2, maxSizeWorld.y / 2),
      );

  @override
  Future<void> onLoad() async {
    super.onLoad();
    await _loadAnimations();
    isRunning = false;
    direction = Direction.down;
    animation = _standingAnimation;

    add(CircleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    movePlayer(dt);
  }

  void movePlayer(double delta) {
    if (!isRunning) {
      animation = _standingAnimation;
      return;
    }
    switch (direction) {
      case Direction.up:
      case Direction.upLeft:
      case Direction.upRight:
        animation = _runUpAnimation;
        _standingAnimation = _standingUpAnimation;
        break;
      case Direction.down:
      case Direction.downLeft:
      case Direction.downRight:
        animation = _runDownAnimation;
        _standingAnimation = _standingDownAnimation;
        break;
      case Direction.left:
        animation = _runLeftAnimation;
        _standingAnimation = _standingLeftAnimation;
        break;
      case Direction.right:
        animation = _runRightAnimation;
        _standingAnimation = _standingRightAnimation;
        break;
      case Direction.none:
        return;
    }

    position.add(direction.unitVector * (_playerSpeed * delta));
    position
      ..x = position.x.clamp(0, maxSizeWorld.x - size.x)
      ..y = position.y.clamp(0, maxSizeWorld.y - size.y);
  }

  Future<void> _loadAnimations() async {
    final spriteSheet = SpriteSheet(
      image: await game.images.load('sp_player.png'),
      srcSize: Vector2(84.0, 110.0),
    );

    _runDownAnimation = spriteSheet.createAnimation(
      row: 0,
      stepTime: _animationSpeed,
      to: 4,
    );

    _runLeftAnimation = spriteSheet.createAnimation(
      row: 2,
      stepTime: _animationSpeed,
      to: 4,
    );

    _runUpAnimation = spriteSheet.createAnimation(
      row: 1,
      stepTime: _animationSpeed,
      to: 4,
    );

    _runRightAnimation = spriteSheet.createAnimation(
      row: 3,
      stepTime: _animationSpeed,
      to: 4,
    );

    _standingDownAnimation = spriteSheet.createAnimation(
      row: 0,
      stepTime: _animationSpeed,
      to: 1,
    );
    _standingAnimation = _standingDownAnimation;

    _standingUpAnimation = spriteSheet.createAnimation(
      row: 1,
      stepTime: _animationSpeed,
      to: 1,
    );
    _standingLeftAnimation = spriteSheet.createAnimation(
      row: 2,
      stepTime: _animationSpeed,
      to: 1,
    );
    _standingRightAnimation = spriteSheet.createAnimation(
      row: 3,
      stepTime: _animationSpeed,
      to: 1,
    );
  }
}
