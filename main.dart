import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() {
  runApp(SnakeGame());
}

class SnakeGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Snake Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SnakeGamePage(),
    );
  }
}

class SnakeGamePage extends StatefulWidget {
  @override
  _SnakeGamePageState createState() => _SnakeGamePageState();
}

class _SnakeGamePageState extends State<SnakeGamePage> {
  static const int numRows = 20;
  static const int numColumns = 20;
  static const int tileSize = 20;

  List<int> snake = [];
  Direction direction = Direction.right;
  Timer? timer;
  int food = 0;
  bool isPlaying = false;
  int score = 0;
  int highScore = 0;

  @override
  void initState() {
    super.initState();
    _loadHighScore().then((_) {
      startGame();
    });
  }

  Future<void> _loadHighScore() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      highScore = prefs.getInt('highScore') ?? 0;
    });
  }

  Future<void> _updateHighScore() async {
    final prefs = await SharedPreferences.getInstance();
    if (score > highScore) {
      setState(() {
        highScore = score;
      });
      await prefs.setInt('highScore', highScore);
    }
  }
  

  void startGame() {
    snake = [45, 44, 43];
    food = _generateFood();
    isPlaying = true;
    score = 0; // Reset score when starting a new game
    timer = Timer.periodic(Duration(milliseconds: 300), (timer) {
      setState(() {
        _moveSnake();
      });
    });
  }

  int _generateFood() {
    final random = Random();
    int randomNumber;
    do {
      randomNumber = random.nextInt(numRows * numColumns);
    } while (snake.contains(randomNumber));
    return randomNumber;
  }

  void _moveSnake() {
    final snakeHead = snake.first;
    int newHead;
    switch (direction) {
      case Direction.up:
        newHead = snakeHead - numColumns;
        break;
      case Direction.down:
        newHead = snakeHead + numColumns;
        break;
      case Direction.left:
        newHead = snakeHead - 1;
        break;
      case Direction.right:
        newHead = snakeHead + 1;
        break;
    }

    if (_isGameOver(newHead)) {
      timer?.cancel();
      isPlaying = false;
      return;
    }

    snake.insert(0, newHead);

    if (newHead == food) {
      food = _generateFood();
      score++; // Increase score when the snake eats food
    } else {
      snake.removeLast();
    }
    _updateHighScore();
  }

 bool _isGameOver(int newHead) {
    if (snake.contains(newHead) ||
        newHead < 0 ||
        newHead >= numRows * numColumns) {
      return true;
    }
    // Add logic to check for boundary conditions if required
    return false;
  }

  @override
  Widget build(BuildContext context) {
    // Modify the build method to include displaying the high score.
    // For example, add another Text widget in the Padding widget to display the high score:
    return Scaffold(
      appBar: AppBar(
        title: Text('Snake Game'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Score: $score', style: TextStyle(fontSize: 20)),
                Spacer(),
                Text('High Score: $highScore', style: TextStyle(fontSize: 20)),
              ],
            ),
          ),
          // Rest of your build method...
        ],
      ),
    );
  }
}

// Continue with the rest of your code...
