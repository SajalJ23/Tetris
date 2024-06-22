import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tetris/piece.dart';
import 'package:tetris/pixel.dart';
import 'package:tetris/values.dart';

/*
GAME BOARD
this is a 2X2 grid with null representing an empty space.
a non empty place have color to represent landed pieces
*/
List<List<Tetromino?>> gameBoard =
    List.generate(colLength, (i) => List.generate(rowLength, (j) => null));

class GameBoard extends StatefulWidget {
  const GameBoard({super.key});

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  Piece currentPiece = Piece(type: Tetromino.L);
  int currentScore = 0;
  bool gameOver = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startGame();
  }

  void startGame() {
    currentPiece.initializePiece();

    //Frame refresh rate
    Duration duration = const Duration(milliseconds: 400);
    gameLoop(duration);
  }

  void gameLoop(Duration frameRate) {
    Timer.periodic(frameRate, (timer) {
      setState(() {
        clearLine();
        checkLanding();
        if (gameOver == true) {
          timer.cancel();
          showGameOverDialog();
        }
        currentPiece.movePiece(Directions.down);
      });
    });
  }

  void showGameOverDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.black,
        title: Text(
          "GAME OVER",
          style: TextStyle(color: Colors.white),
        ),
        content: Text(
          "Your Score is : $currentScore",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          TextButton(
              onPressed: () {
                resetGame();
                Navigator.pop(context);
              },
              child: Text(
                "Play Again",
                style: TextStyle(color: Colors.orange),
              ))
        ],
      ),
    );
  }

  void resetGame() {
    gameBoard =
        List.generate(colLength, (i) => List.generate(rowLength, (j) => null));

    gameOver = false;
    currentScore = 0;
    createNewPiece();
    startGame();
  }

  bool checkCollision(Directions direction) {
    for (int i = 0; i < currentPiece.position.length; i++) {
      int row = (currentPiece.position[i] / rowLength).floor();
      int col = currentPiece.position[i] % rowLength;
      if (direction == Directions.left) {
        col -= 1;
      } else if (direction == Directions.right) {
        col += 1;
      } else if (direction == Directions.down) {
        row += 1;
      }

      if (row >= colLength || col < 0 || col >= rowLength) return true;
      if (row >= 0 && gameBoard[row][col] != null) return true;
    }
    return false;
  }

  void checkLanding() {
    // if going down is occupied
    if (checkCollision(Directions.down)) {
      for (int i = 0; i < currentPiece.position.length; i++) {
        int row = (currentPiece.position[i] / rowLength).floor();
        int col = currentPiece.position[i] % rowLength;
        if (row >= 0 && col >= 0) {
          gameBoard[row][col] = currentPiece.type;
        }
      }
      createNewPiece();
    }
  }

  void createNewPiece() {
    Random rand = Random();
    Tetromino randomType =
        Tetromino.values[rand.nextInt(Tetromino.values.length)];
    currentPiece = Piece(type: randomType);
    currentPiece.initializePiece();
    if (isGameOverr()) {
      gameOver = true;
    }
  }

  void moveLeft() {
    if (!checkCollision(Directions.left)) {
      setState(() {
        currentPiece.movePiece(Directions.left);
      });
    }
  }

  void moveRight() {
    if (!checkCollision(Directions.right)) {
      setState(() {
        currentPiece.movePiece(Directions.right);
      });
    }
  }

  void rotatrPiece() {
    if (gameOver == true) {
      resetGame();
    }
    setState(() {
      currentPiece.rotatePiece();
    });
  }

  void clearLine() {
    int linesCleared = 0;
    for (int row = colLength - 1; row >= 0; row--) {
      bool rowIsFull = true;

      for (int col = 0; col < rowLength; col++) {
        if (gameBoard[row][col] == null) {
          rowIsFull = false;
          break;
        }
      }
      if (rowIsFull) {
        for (int r = row; r > 0; r--) {
          gameBoard[r] = List.from(gameBoard[r - 1]);
        }
        gameBoard[0] = List.generate(rowLength, (index) => null);
        // Update the positions of the falling piece
        for (int i = 0; i < currentPiece.position.length; i++) {
          currentPiece.position[i] += rowLength;
        }
        linesCleared++;
      }
    }

    if (linesCleared > 0) {
      // Update score for each cleared line
      currentScore++;
    }
  }

  bool isGameOverr() {
    // check any column of the top row are filled
    for (int col = 0; col < rowLength; col++) {
      if (gameBoard[0][col] != null) return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        title: Container(
          height: 35,
          child: Image.asset('assets/icons/tetris_logo.png'),
        ),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
                itemCount: rowLength * colLength,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: rowLength),
                itemBuilder: (context, index) {
                  int row = (index / rowLength).floor();
                  int col = index % rowLength;
                  if (currentPiece.position.contains(index)) {
                    return Pixel(
                      color: currentPiece.color,
                    );
                  } else if (gameBoard[row][col] != null) {
                    final tetrominoType = gameBoard[row][col];
                    return Pixel(color: tetrominoColor[tetrominoType]);
                  } else {
                    return Pixel(
                      color: Colors.grey[900],
                    );
                  }
                }),
          ),
          Text(
            "Score : " + currentScore.toString(),
            style: TextStyle(color: Colors.white),
            textScaler: TextScaler.linear(1.2),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 30, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //left
                IconButton(
                    onPressed: moveLeft,
                    color: Colors.white,
                    iconSize: 40,
                    icon: Icon(CupertinoIcons.arrow_left)),
                //rotate
                IconButton(
                    onPressed: rotatrPiece,
                    color: Colors.white,
                    iconSize: 50,
                    icon: Icon(CupertinoIcons.arrow_2_circlepath)),
                // right
                IconButton(
                    onPressed: moveRight,
                    color: Colors.white,
                    iconSize: 50,
                    icon: Icon(CupertinoIcons.arrow_right)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
