import 'package:flame/components.dart';
import 'package:flame/flame.dart';

class Background extends PositionComponent {
  static const double tileSize = 320;
  static const double _cameraPadding = 800;

  final Vector2 maxSizeWorld;

  Background({required this.maxSizeWorld});

  @override
  Future<void> onLoad() async {
    final image = await Flame.images.load('grass.jpg');
    final sprite = Sprite(image);

    position = Vector2.all(-_cameraPadding);
    size = maxSizeWorld + Vector2.all(_cameraPadding * 2);

    final columns = (size.x / tileSize).ceil();
    final rows = (size.y / tileSize).ceil();
    for (var column = 0; column < columns; column++) {
      for (var row = 0; row < rows; row++) {
        add(
          SpriteComponent(
            sprite: sprite,
            position: Vector2(column * tileSize, row * tileSize),
            size: Vector2.all(tileSize),
          ),
        );
      }
    }
  }
}
