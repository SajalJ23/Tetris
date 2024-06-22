import 'package:flutter/material.dart';
import 'package:tetris/board.dart';

import 'values.dart';

class Piece {
  // type of tetris piece
  Tetromino type;
  Piece({required this.type});

  // piece is just list of numbers
  List<int> position = [];

  //color of tetris piece
  Color get color {
    return tetrominoColor[type] ?? Colors.white;
  }

  void initializePiece() {
    switch (type) {
      case Tetromino.L:
        position = [-26, -16, -6, -5];
        break;
      case Tetromino.J:
        position = [-25, -15, -5, -6];
        break;
      case Tetromino.I:
        position = [-4, -5, -6, -7];
        break;
      case Tetromino.O:
        position = [-15, -16, -5, -6];
        break;
      case Tetromino.S:
        position = [-15, -14, -6, -5];
        break;
      case Tetromino.Z:
        position = [-17, -16, -6, -5];
        break;
      case Tetromino.T:
        position = [-26, -16, -6, -15];
        break;
      default:
    }
  }

  void movePiece(Directions direction) {
    switch (direction) {
      case Directions.down:
        for (int i = 0; i < position.length; i++) {
          position[i] += rowLength;
        }
        break;
      case Directions.left:
        for (int i = 0; i < position.length; i++) {
          position[i] -= 1;
        }
        break;
      case Directions.right:
        for (int i = 0; i < position.length; i++) {
          position[i] += 1;
        }
        break;
      default:
    }
  }

  // rotate piece
  int rotateState = 1;
  void rotatePiece() {
    // new position
    List<int> newPositions = [];
    // rotate the piece based on its type
    switch (type) {
      case Tetromino.L:
        switch (rotateState) {
          case 0:
            // get new position
            newPositions = [
              position[1] - rowLength,
              position[1],
              position[1] + rowLength,
              position[1] + rowLength + 1
            ];
            if (piecePositionIsValid(newPositions)) {
              position = newPositions;
              rotateState = (rotateState + 1) % 4;
            }
            break;

          case 1:
            newPositions = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + rowLength - 1,
            ];
            if (piecePositionIsValid(newPositions)) {
              position = newPositions;
              rotateState = (rotateState + 1) % 4;
            }
            break;

          case 2:
            newPositions = [
              position[1] + rowLength,
              position[1],
              position[1] - rowLength,
              position[1] - rowLength - 1,
            ];
            if (piecePositionIsValid(newPositions)) {
              position = newPositions;
              rotateState = (rotateState + 1) % 4;
            }
            break;

          case 3:
            newPositions = [
              position[1] - rowLength + 1,
              position[1],
              position[1] + 1,
              position[1] - 1,
            ];
            if (piecePositionIsValid(newPositions)) {
              position = newPositions;
              rotateState = (rotateState + 1) % 4;
            }
            break;
        }
        break;

      case Tetromino.J:
        switch (rotateState) {
          case 0:
            // get new position
            newPositions = [
              position[1] - rowLength,
              position[1],
              position[1] + rowLength,
              position[1] + rowLength - 1
            ];
            if (piecePositionIsValid(newPositions)) {
              position = newPositions;
              rotateState = (rotateState + 1) % 4;
            }
            break;

          case 1:
            newPositions = [
              position[1] - rowLength - 1,
              position[1],
              position[1] - 1,
              position[1] + 1,
            ];
            if (piecePositionIsValid(newPositions)) {
              position = newPositions;
              rotateState = (rotateState + 1) % 4;
            }
            break;

          case 2:
            newPositions = [
              position[1] + rowLength,
              position[1],
              position[1] - rowLength,
              position[1] - rowLength + 1,
            ];
            if (piecePositionIsValid(newPositions)) {
              position = newPositions;
              rotateState = (rotateState + 1) % 4;
            }
            break;

          case 3:
            newPositions = [
              position[1] + 1,
              position[1],
              position[1] - 1,
              position[1] + rowLength + 1,
            ];
            if (piecePositionIsValid(newPositions)) {
              position = newPositions;
              rotateState = (rotateState + 1) % 4;
            }
            break;
        }
        break;

      case Tetromino.I:
        switch (rotateState) {
          case 0:
            // get new position
            newPositions = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + 2,
            ];
            if (piecePositionIsValid(newPositions)) {
              position = newPositions;
              rotateState = (rotateState + 1) % 4;
            }
            break;

          case 1:
            newPositions = [
              position[1] - rowLength,
              position[1],
              position[1] + rowLength,
              position[1] + 2 * rowLength,
            ];
            if (piecePositionIsValid(newPositions)) {
              position = newPositions;
              rotateState = (rotateState + 1) % 4;
            }
            break;

          case 2:
            newPositions = [
              position[1] + 1,
              position[1],
              position[1] - 1,
              position[1] - 2,
            ];
            if (piecePositionIsValid(newPositions)) {
              position = newPositions;
              rotateState = (rotateState + 1) % 4;
            }
            break;

          case 3:
            newPositions = [
              position[1] + rowLength,
              position[1],
              position[1] - rowLength,
              position[1] - 2 * rowLength,
            ];
            if (piecePositionIsValid(newPositions)) {
              position = newPositions;
              rotateState = (rotateState + 1) % 4;
            }
            break;
        }

      case Tetromino.O:
        break;

      case Tetromino.S:
        switch (rotateState) {
          case 0:
            // get new position
            newPositions = [
              position[1],
              position[1] + 1,
              position[1] + rowLength - 1,
              position[1] + rowLength,
            ];
            if (piecePositionIsValid(newPositions)) {
              position = newPositions;
              rotateState = (rotateState + 1) % 4;
            }
            break;

          case 1:
            newPositions = [
              position[0] - rowLength,
              position[0],
              position[0] + 1,
              position[0] + rowLength + 1,
            ];
            if (piecePositionIsValid(newPositions)) {
              position = newPositions;
              rotateState = (rotateState + 1) % 4;
            }
            break;

          case 2:
            newPositions = [
              position[1],
              position[1] + 1,
              position[1] + rowLength - 1,
              position[1] + rowLength,
            ];
            if (piecePositionIsValid(newPositions)) {
              position = newPositions;
              rotateState = (rotateState + 1) % 4;
            }
            break;

          case 3:
            newPositions = [
              position[0] - rowLength,
              position[0],
              position[0] + 1,
              position[0] + rowLength + 1,
            ];
            if (piecePositionIsValid(newPositions)) {
              position = newPositions;
              rotateState = (rotateState + 1) % 4;
            }
            break;
        }
        break;

      case Tetromino.Z:
        switch (rotateState) {
          case 0:
            // get new position
            newPositions = [
              position[0] + rowLength - 2,
              position[1],
              position[2] + rowLength - 1,
              position[3] + 1,
            ];
            if (piecePositionIsValid(newPositions)) {
              position = newPositions;
              rotateState = (rotateState + 1) % 4;
            }
            break;

          case 1:
            newPositions = [
              position[0] - rowLength + 2,
              position[1],
              position[2] - rowLength + 1,
              position[3] - 1,
            ];
            if (piecePositionIsValid(newPositions)) {
              position = newPositions;
              rotateState = (rotateState + 1) % 4;
            }
            break;

          case 2:
            newPositions = [
              position[0] + rowLength - 2,
              position[1],
              position[2] + rowLength - 1,
              position[3] + 1,
            ];
            if (piecePositionIsValid(newPositions)) {
              position = newPositions;
              rotateState = (rotateState + 1) % 4;
            }
            break;

          case 3:
            newPositions = [
              position[0] - rowLength + 2,
              position[1],
              position[2] - rowLength + 1,
              position[3] - 1,
            ];
            if (piecePositionIsValid(newPositions)) {
              position = newPositions;
              rotateState = (rotateState + 1) % 4;
            }
            break;
        }
        break;

      case Tetromino.T:
        switch (rotateState) {
          case 0:
            // get new position
            newPositions = [
              position[2] - rowLength,
              position[2],
              position[2] + 1,
              position[2] + rowLength,
            ];
            if (piecePositionIsValid(newPositions)) {
              position = newPositions;
              rotateState = (rotateState + 1) % 4;
            }
            break;

          case 1:
            newPositions = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + rowLength,
            ];
            if (piecePositionIsValid(newPositions)) {
              position = newPositions;
              rotateState = (rotateState + 1) % 4;
            }
            break;

          case 2:
            newPositions = [
              position[1] - rowLength,
              position[1] - 1,
              position[1],
              position[1] + rowLength,
            ];
            if (piecePositionIsValid(newPositions)) {
              position = newPositions;
              rotateState = (rotateState + 1) % 4;
            }
            break;

          case 3:
            newPositions = [
              position[2] - rowLength,
              position[2] - 1,
              position[2],
              position[2] + 1,
            ];
            if (piecePositionIsValid(newPositions)) {
              position = newPositions;
              rotateState = (rotateState + 1) % 4;
            }
            break;
        }
        break;
      default:
    }
  }

  bool positionIsValid(int position) {
    int row = (position / rowLength).floor();
    int col = position % rowLength;
    if (row <= 0 || col <= 0 || gameBoard[row][col] != null) {
      return false;
    } else {
      return true;
    }
  }

  bool piecePositionIsValid(List<int> piecePosition) {
    bool firstOccupied = false;
    bool lastOccupied = false;
    for (int pos in piecePosition) {
      if (!positionIsValid(pos)) {
        return false;
      }
      int col = pos % rowLength;
      if (col == 0) {
        firstOccupied = true;
      }
      if (col == rowLength - 1) {
        lastOccupied = true;
      }
    }
    return !(firstOccupied && lastOccupied);
  }
}
