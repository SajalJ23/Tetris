import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tetris/board.dart';

class StartGame extends StatefulWidget {
  const StartGame({super.key});

  @override
  State<StartGame> createState() => _StartGameState();
}

class _StartGameState extends State<StartGame> {
  void startMyGame() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const GameBoard()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 100,
              child: Image.asset('assets/icons/tetris_logo.png'),
            ),
            SizedBox(
              height: 20,
            ),
            const Text(
              "START GAME",
              style: TextStyle(color: Colors.white),
              textScaler: TextScaler.linear(2),
            ),
            IconButton(
              onPressed: startMyGame,
              icon: const Icon(
                CupertinoIcons.play_circle,
                color: Colors.white,
                size: 70,
              ),
            )
          ],
        ),
      ),
    );
  }
}
