import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:pacman/components/tile_map.dart';

class PacMan extends BaseGame {
  Size screenSize;
  final gameColumns = 15;
  final gameRows = 11;
  double tileWidth, tileHeight;

  TileMap _tileMap;

  PacMan() {
    initialize();
  }

  void initialize() async {
    resize(await Flame.util.initialDimensions());
    _tileMap = TileMap(this);
  }

  @override
  void update(double t) {
    if (_tileMap != null) _tileMap.update(t);

    super.update(t);
  }

  @override
  void render(Canvas canvas) {
    if (this.screenSize == null) {
      return;
    }

    if (_tileMap != null) _tileMap.render(canvas);

    super.render(canvas);
  }

  @override
  void resize(Size size) {
    screenSize = size;
    tileHeight = (screenSize.height / 1.5) / gameRows;
    tileWidth = (screenSize.width) / gameColumns;

    double mazeWidth = tileWidth * gameColumns;
    double mazeHeight = tileHeight * gameRows;
    Size mazeSize = Size(mazeWidth, mazeHeight);

    super.resize(mazeSize);
  }
}
