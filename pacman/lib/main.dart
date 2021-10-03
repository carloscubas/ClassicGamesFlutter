import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:flame/util.dart';
import 'package:flutter/services.dart';
import 'package:pacman/pacman.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Util flameUtil = Util();
  flameUtil.fullScreen();
  flameUtil.setOrientation(DeviceOrientation.portraitUp);
  Flame.images.loadAll(<String>[
    'wall.png',
    'pacman.png',
    'ghost.png',
    'yellowDot.png',
  ]);
  runApp(PacMan().widget);
}
