import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:flame/sprite.dart';

import '../pacman.dart';

class Dots extends Component {
  final PacMan game;
  Sprite sprite;
  Rect dotsRect;

  Rect get rect => dotsRect;

  Dots(String pathImage, this.game, double x, double y) {
    sprite = Sprite(pathImage);
    dotsRect = Rect.fromLTWH(x, y, game.tileWidth / 1.1, game.tileHeight / 1.1);
  }

  @override
  void render(Canvas canvas) {
    sprite.renderRect(canvas, dotsRect.inflate(2));
  }

  @override
  void update(double t) {
    if (game.tileMap.player.toRect().contains(this.rect.bottomCenter) ||
        game.tileMap.player.toRect().contains(this.rect.bottomLeft) ||
        game.tileMap.player.toRect().contains(this.rect.bottomRight) ||
        game.tileMap.player.toRect().contains(this.rect.topCenter) ||
        game.tileMap.player.toRect().contains(this.rect.topLeft) ||
        game.tileMap.player.toRect().contains(this.rect.topRight)) {
      print('colidiu');
    }
  }
}
