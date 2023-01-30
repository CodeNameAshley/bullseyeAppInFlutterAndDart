import 'package:bullseye/prompt.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';

import 'control.dart';
import 'score.dart';
import 'game_model.dart';

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
  late GameModel _model;

  @override
  void initState() {
    super.initState();
    _model = GameModel(Random().nextInt(100 + 1));
  }

  bool _alertIsVisible = false;
  int accumulatedRound = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Prompt(targetValue: _model.target),
          Control(model: _model),
          TextButton(
            onPressed: () {
              _alertIsVisible = true;
              _showAlert(context);
              accumulatedRound = accumulatedPoints + 1;
            },
            child: const Text(
              'Hit Me!',
              style: TextStyle(color: Colors.blue),
            ),
          ),
          Score(totalScore: _model.totalScore, round: _model.round)
        ],
      ),
    ));
  }

  int accumulatedPoints = 0;

  int _pointsForCurrentRound(int currentValue) {
    if (currentValue > _model.target) {
      accumulatedPoints = accumulatedPoints + (currentValue - _model.target);
      return currentValue - _model.target;
    } else if (_model.target > currentValue) {
      accumulatedPoints = accumulatedPoints + (_model.target - currentValue);
      return _model.target - currentValue;
    } else {
      accumulatedPoints = accumulatedPoints + 0;
      return 0;
    }
  }

  void _showAlert(BuildContext context) {
    var okButton = TextButton(
      onPressed: () {
        Navigator.of(context).pop();
        _alertIsVisible = false;
        print('Awesome pressed! $_alertIsVisible');
        Score(totalScore: accumulatedPoints, round: accumulatedRound);
      },
      child: const Text('Awesome!'),
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Hello there!'),
          content: Text('The slider\'s value is ${_model.current}.\n'
          'You scored ${_pointsForCurrentRound(_model.current)} points this round.'),
          actions: [
            okButton,
          ],
          elevation: 5,
        );
      },
    );
  }
}
