import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class SecondTab extends StatefulWidget {
  @override
  _SecondTabState createState() => _SecondTabState();
}

class _SecondTabState extends State<SecondTab> {
  static const int gridSize = 20;
  static const double cellSize = 20.0;
  static const int initialSpeed = 500;
  static const int minSpeed = 100;

  List<Point<int>> snake = [Point(10, 10)];
  Point<int> food = Point(5, 5);
  Direction? direction;
  bool gameStarted = false;
  int score = 0;
  int speed = initialSpeed;

  @override
  void initState() {
    super.initState();
  }

  void startGame() {
    setState(() {
      gameStarted = true;
    });
    const duration = Duration(milliseconds: initialSpeed);
    Timer.periodic(duration, (Timer timer) {
      setState(() {
        moveSnake();
        checkCollisions();
      });
    });
  }

  void moveSnake() {
    final head = snake.first;
    Point<int> newHead;

    switch (direction) {
      case Direction.up:
        newHead = Point(head.x, head.y - 1);
        break;
      case Direction.down:
        newHead = Point(head.x, head.y + 1);
        break;
      case Direction.left:
        newHead = Point(head.x - 1, head.y);
        break;
      case Direction.right:
        newHead = Point(head.x + 1, head.y);
        break;
      default:
        return;
    }

    snake.insert(0, newHead);
    if (newHead != food) {
      snake.removeLast();
    } else {
      generateFood();
      setState(() {
        score++;
        if (speed > minSpeed) {
          speed -= 5; // Reduz a velocidade em 5 a cada vez que a cobra come
        }
      });
    }
  }

  void checkCollisions() {
    final head = snake.first;
    if (head.x < 0 || head.x >= gridSize || head.y < 0 || head.y >= gridSize) {
      gameOver();
    }

    for (int i = 1; i < snake.length; i++) {
      if (snake[i] == head) {
        gameOver();
      }
    }
  }

  void gameOver() {
    setState(() {
      snake = [Point(10, 10)];
      food = Point(5, 5);
      direction = null;
      gameStarted = false;
      score = 0;
      speed = initialSpeed;
    });
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Game Over'),
        content: Text('Você bateu nas laterais!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Ok'),
          ),
        ],
      ),
    );
  }

  void generateFood() {
    final random = Random();
    food = Point(random.nextInt(gridSize), random.nextInt(gridSize));
  }

  void setDirection(Direction newDirection) {
    setState(() {
      direction = newDirection;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.red), // Alteração aqui
              color: Colors.green,
            ),
            child: Center(
              child: Stack(
                children: [
                  AspectRatio(
                    aspectRatio: 1,
                    child: GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: gridSize,
                      ),
                      itemCount: gridSize * gridSize,
                      itemBuilder: (context, index) {
                        final rowIndex = index ~/ gridSize;
                        final colIndex = index % gridSize;
                        final point = Point(colIndex, rowIndex);

                        if (snake.contains(point)) {
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              shape: BoxShape.circle,
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  top: 5,
                                  left: 5,
                                  child: CircleAvatar(
                                    radius: 2,
                                    backgroundColor: Colors.black,
                                  ),
                                ),
                                Positioned(
                                  top: 5,
                                  right: 5,
                                  child: CircleAvatar(
                                    radius: 2,
                                    backgroundColor: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else if (point == food) {
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ),
                  Positioned(
                    top: 16,
                    right: 16,
                    child: Text(
                      'Pontuação: $score',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            color: Colors.black,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: gameStarted ? null : startGame,
                child: Text(gameStarted ? 'Jogo em Andamento' : 'Iniciar Jogo'),
              ),
              IconButton(
                onPressed: () => setDirection(Direction.up),
                icon: Icon(Icons.keyboard_arrow_up),
                color: Colors.white,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () => setDirection(Direction.left),
                    icon: Icon(Icons.keyboard_arrow_left),
                    color: Colors.white,
                  ),
                  IconButton(
                    onPressed: () => setDirection(Direction.right),
                    icon: Icon(Icons.keyboard_arrow_right),
                    color: Colors.white,
                  ),
                ],
              ),
              IconButton(
                onPressed: () => setDirection(Direction.down),
                icon: Icon(Icons.keyboard_arrow_down),
                color: Colors.white,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

enum Direction { up, down, left, right }

class Point<T> {
  final T x;
  final T y;

  const Point(this.x, this.y);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Point && other.x == x && other.y == y;
  }

  @override
  int get hashCode => x.hashCode ^ y.hashCode;

  @override
  String toString() {
    return 'Point{x: $x, y: $y}';
  }
}
