import 'package:bullseye/prompt.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'control.dart';
import 'score.dart';

void main() {
  runApp(const BullsEyeApp());
}

class BullsEyeApp extends StatelessWidget {
  const BullsEyeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    return const MaterialApp(
      title: 'Bullseye',
      home: GamePage(),
    );
  }
}

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  bool _alertIsVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Prompt(targetValue: 100),
          const Control(),
          TextButton(
            onPressed: () {
              _alertIsVisible = true;
              _showAlert(context);
            },
            child: const Text(
              'Hit Me!',
              style: TextStyle(color: Colors.blue),
            ),
          ),
          const Score(totalScore: 0, round: 1)
        ],
      ),
    ));
  }

  void _showAlert(BuildContext context) {
    var okButton = TextButton(
      onPressed: () {
        Navigator.of(context).pop();
        _alertIsVisible = false;
        print('Awesome pressed! $_alertIsVisible');
      },
      child: const Text('Awesome!'),
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Hello there!'),
          content: const Text('This is my first pop-up!'),
          actions: [
            okButton,
          ],
          elevation: 5,
        );
      },
    );
  }
}
