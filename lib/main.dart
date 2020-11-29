import 'package:flutter/material.dart';
import 'package:flame/anchor.dart';
import 'package:flame/gestures.dart';
import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final game = MyGame();
    return MaterialApp(
        home: Scaffold(
            body: Container(
                color: Colors.amberAccent,
                child: Stack(children: [
                  game.widget,
                  Positioned(
                      left: 10,
                      bottom: 10,
                      child: GameButton(
                          onTapUp: (_) {
                            game.stopMoving();
                          },
                          onTapDown: (_) {
                            game.movingLeft();
                          },
                          label: '<---')),
                  Positioned(
                      right: 10,
                      bottom: 10,
                      child: GameButton(
                          onTapUp: (_) {
                            game.stopMoving();
                          },
                          onTapDown: (_) {
                            game.movingRight();
                          },
                          label: '--->'))
                ]))));
  }
}

class Player extends PositionComponent {
  double direction = 0.0;
  static final _white = Paint()..color = const Color(0xFFFFFFFF);

  Player() {
    width = height = 100;
    y = 50.0;
  }

  @override
  void update(double dt) {
    x += 200 * dt * direction;
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRect(toRect(), _white);
  }
}

class MyGame extends BaseGame {
  Player _player;

  void stopMoving() { _player.direction = 0; }

  void movingRight() { _player.direction = 1; }

  void movingLeft() { _player.direction = -1; }

  MyGame() {
    _player = Player();
    add(_player);
  }
}

class GameButton extends StatelessWidget {
  final String label;
  final void Function(TapUpDetails) onTapUp;
  final void Function(TapDownDetails) onTapDown;

  GameButton({this.label, this.onTapDown, this.onTapUp});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTapUp: onTapUp,
        onTapDown: onTapDown,
        child: SizedBox(
            width: 100,
            height: 100,
            child: Container(
                color: Colors.blueAccent,
                child: Center(child: Text(label)))));
  }
}

