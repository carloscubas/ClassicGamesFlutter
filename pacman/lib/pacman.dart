import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pacman/components/tile_map.dart';

class PacMan extends BaseGame
    with VerticalDragDetector, HorizontalDragDetector {
  Size screenSize;
  final gameColumns = 15;
  final gameRows = 17;
  double tileWidth, tileHeight;

  TileMap tileMap;

  PacMan() {
    initialize();
  }

  void initialize() async {
    resize(await Flame.util.initialDimensions());
    tileMap = TileMap(this);
  }

  @override
  void update(double t) {
    if (tileMap != null) tileMap.update(t);

    super.update(t);
  }

  @override
  void render(Canvas canvas) {
    if (this.screenSize == null) {
      return;
    }

    if (tileMap != null) tileMap.render(canvas);

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

  @override
  void onVerticalDragEnd(DragEndDetails details) {
    double velocity = details.primaryVelocity;
    if (velocity < 0) {
      tileMap.managePlayerMovement('DOWN');
    } else {
      tileMap.managePlayerMovement('UP');
    }
  }

  @override
  void onHorizontalDragEnd(DragEndDetails details) {
    double velocity = details.primaryVelocity;
    if (velocity < 0) {
      tileMap.managePlayerMovement('LEFT');
    } else {
      tileMap.managePlayerMovement('RIGHT');
    }
  }
}
