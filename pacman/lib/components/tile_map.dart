import 'dart:math';
import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:pacman/components/player.dart';

import '../pacman.dart';
import 'dots.dart';
import 'wall.dart';

const DOT = 0;
const WALL = 1;
const PACMAN = 2;
const GHOST = 3;

class Imagens {
  static const Map<int, String> wallsMap = {
    0: 'yellowDot.png',
    1: 'wall.png',
    2: 'pacman.png',
    3: 'ghost.png',
  };
}

class TileMap extends Component {
  Map<Point, Component> _map;
  List<Dots> _dots = <Dots>[];
  List<List<int>> _mapDefinition = [
    [1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1],
    [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
    [1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1],
    [1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1],
    [0, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 0, 1, 0, 1],
    [1, 0, 1, 0, 1, 0, 0, 0, 0, 0, 1, 0, 1, 0, 1],
    [1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1],
    [1, 0, 1, 0, 1, 0, 1, 0, 0, 0, 1, 0, 1, 0, 1],
    [1, 0, 1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 1, 0, 1],
    [1, 0, 1, 0, 1, 0, 0, 0, 1, 0, 1, 0, 1, 0, 0],
    [1, 0, 1, 0, 1, 0, 1, 1, 1, 0, 1, 0, 1, 0, 1],
    [1, 0, 1, 0, 1, 0, 0, 0, 0, 0, 1, 0, 1, 0, 1],
    [1, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 0, 1, 0, 1],
    [1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1],
    [1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1],
    [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
    [1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
  ];

  Map<Point, Component> get map => _map;

  TileMap(this.game) {
    _init();
    _addPlayer();
  }

  final PacMan game;
  Player player;

  void _init() {
    var gameMap = Map<Point, Component>();
    for (var y = 0; y < _mapDefinition.length; y++) {
      for (var x = 0; x < _mapDefinition[0].length; x++) {
        double posX = game.tileWidth * x;
        double posY = game.tileHeight * y;

        switch (_mapDefinition[y][x]) {
          case WALL:
            gameMap[Point(x, y)] =
                Wall(Imagens.wallsMap[WALL], game, posX, posY);
            break;
          case DOT:
            var dot = Dots(Imagens.wallsMap[DOT], game, posX, posY);
            _dots.add(dot);
            gameMap[Point(x, y)] = dot;
            break;
        }
      }
    }
    this._map = gameMap;
  }

  void _addPlayer() {
    if (_map.isNotEmpty) {
      player = Player(game);
    }
  }

  @override
  void render(Canvas c) {
    _map.forEach((position, component) {
      component.render(c);
    });

    player.render(c);
  }

  @override
  void update(double t) {
    player.update(t);

    if (_dots.length > 0) {
      _dots.forEach((_dot) {
        _dot.update(t);
      });
    }
  }

  void managePlayerMovement(String direction) {
    switch (direction) {
      case "LEFT":
        _movePlayer(-1.0, 0.0);
        break;
      case "RIGHT":
        _movePlayer(1.0, 0.0);
        break;
      case "UP":
        _movePlayer(0.0, 1.0);
        break;
      case "DOWN":
        _movePlayer(0.0, -1.0);
        break;
    }
  }

  void _movePlayer(double offsetX, double offsetY) {
    if (player.position == null) {
      return;
    }

    Point targetPoint = Point(
      (player.position.x + offsetX),
      (player.position.y + offsetY),
    );

    if (_map[targetPoint] is Wall) {
      return;
    }

    player.targetLocation = targetPoint;
  }
}
