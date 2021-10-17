import 'dart:math';
import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:flame/sprite.dart';

import '../pacman.dart';

class Player extends SpriteComponent {
  PacMan _game;
  Sprite sprite;
  Rect pacmanRect;
  Point _position;
  Point _targetLocation;

  Point get position => _position;

  Player(game) {
    this._game = game;
    this._position = Point(2.0, 1.0); // starting position
    sprite = Sprite('pacman.png');
    pacmanRect = Rect.fromLTWH(
        game.tileWidth * _position.x,
        game.tileHeight * _position.y,
        game.tileWidth / 1.1,
        game.tileHeight / 1.1);
  }

  set targetLocation(Point targetPoint) {
    _targetLocation = targetPoint;
  }

  @override
  void render(Canvas canvas) {
    sprite.renderRect(canvas, pacmanRect.inflate(2));
  }

  @override
  void update(double t) {
    if (_targetLocation != null) {
      Offset toTarget = Offset(_targetLocation.x * _game.tileWidth,
              _targetLocation.y * _game.tileHeight) -
          Offset(_position.x * _game.tileWidth, _position.y * _game.tileHeight);

      pacmanRect = pacmanRect.shift(toTarget);

      _position = _targetLocation; // update player position with target
      _targetLocation = null;
    }
    super.update(t);
  }
}
