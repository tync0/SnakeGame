import 'dart:async';
import 'package:flutter/material.dart';
import 'package:snake_game/widget/text.dart';
import '../snake_class.dart';
import '../widget/pixel.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  late final Snake snake;
  @override
  void initState() {
    snake = Snake();
    super.initState();
  }

  void _showDialog() {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
          title: const TextWidget(data: 'Game Over!', fontSize: 24),
          content: const TextWidget(data: 'You run in yourself', fontSize: 18),
        );
      },
    );
  }

  void startGame() {
    Timer.periodic(
      const Duration(milliseconds: 150),
      (timer) {
        setState(
          () {
            if (snake.playGame()) {
              timer.cancel();
              _showDialog();
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  const SizedBox(height: 25),
                  const TextWidget(
                    data: "Score",
                  ),
                  TextWidget(
                    data: snake.score.toString(),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: GestureDetector(
                onVerticalDragUpdate: (details) {
                  if (details.delta.dy > 0 &&
                      snake.currentDirection != SnakeDirection.up) {
                    snake.currentDirection = SnakeDirection.down;
                  } else if (details.delta.dy < 0 &&
                      snake.currentDirection != SnakeDirection.down) {
                    snake.currentDirection = SnakeDirection.up;
                  }
                },
                onHorizontalDragUpdate: (details) {
                  if (details.delta.dx > 0 &&
                      snake.currentDirection != SnakeDirection.left) {
                    snake.currentDirection = SnakeDirection.right;
                  } else if (details.delta.dx < 0 &&
                      snake.currentDirection != SnakeDirection.right) {
                    snake.currentDirection = SnakeDirection.left;
                  }
                },
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 100,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 10,
                  ),
                  itemBuilder: (context, index) {
                    if (snake.position.contains(index)) {
                      return const Pixel(color: Colors.white);
                    } else if (snake.foodPosition == index) {
                      return const Pixel(color: Colors.red);
                    } else {
                      return Pixel(color: Colors.grey.shade900);
                    }
                  },
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: snake.gameIsRunning
                    ? const SizedBox()
                    : MaterialButton(
                        height: 40,
                        minWidth: 100,
                        color: Colors.red,
                        onPressed: startGame,
                        child: const TextWidget(
                          data: 'Play',
                          fontSize: 18,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
