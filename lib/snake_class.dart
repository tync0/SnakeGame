import 'dart:math';

enum SnakeDirection {
  up,
  down,
  left,
  right,
}

class Snake {
  List<int> position = [1, 2, 3];
  int foodPosition = 55, score = 0;
  SnakeDirection currentDirection = SnakeDirection.right;
  bool gameIsRunning = false;
  bool playGame() {
    moveSnake();
    if (gameOver()) {
      position = [1, 2, 3];
      foodPosition = 55;
      currentDirection = SnakeDirection.right;
      gameIsRunning = false;
      score = 0;
      return true;
    }
    return false;
  }

  void moveSnake() {
    gameIsRunning = true;

    switch (currentDirection) {
      case SnakeDirection.down:
        {
          if (position.last >= 90) {
            position.add(position.last - 90);
          } else {
            position.add(position.last + 10);
          }
        }
        break;
      case SnakeDirection.up:
        {
          if (position.last < 10) {
            position.add(position.last + 90);
          } else {
            position.add(position.last - 10);
          }
        }
        break;
      case SnakeDirection.left:
        {
          if (position.last % 10 == 0) {
            position.add(position.last + 9);
          } else {
            position.add(position.last - 1);
          }
        }
        break;
      case SnakeDirection.right:
        {
          if (position.last % 10 == 9) {
            position.add(position.last - 9);
          } else {
            position.add(position.last + 1);
          }
        }
        break;
    }
    eatFood();
  }

  void eatFood() {
    if (position.last == foodPosition) {
      do {
        foodPosition = Random().nextInt(100);
      } while (position.contains(foodPosition));
      score++;
    } else {
      position.removeAt(0);
    }
  }

  bool gameOver() {
    List<int> newList = position.sublist(0, position.length - 1);
    if (newList.contains(position.last)) {
      return true;
    }
    return false;
  }
}
