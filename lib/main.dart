import 'dart:math';

import 'package:bullseye/prompt.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'control.dart';
import 'game_model.dart';
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
  late GameModel _model;

  @override
  void initState() {
    super.initState();
    _model = GameModel(Random().nextInt(100 + 1));
  }

  bool _alertIsVisible = false;

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

  int _pointsForCurrentRound() {
    const maximumScore = 100;
    var difference = _differentAmount();
    return maximumScore - difference;
  }

  String _alertTitle() {
    var difference = _differentAmount();
    String title;
    if (difference == 0) {
      title = '🎯 Bullseye ';
    } else if (difference < 5) {
      title = '😄 Almost had it!';
    } else if (difference <= 10) {
      title = '🤔 Not bad';
    } else {
      title = '😑 You are way off!';
    }

    return title;
  }

  int _differentAmount() => (_model.target - _model.current).abs();


  void _showAlert(BuildContext context) {
    var okButton = TextButton(
      onPressed: () {
        Navigator.of(context).pop();
        _alertIsVisible = false;
        setState(() {
          _model.totalScore += _pointsForCurrentRound();
          _model.target = Random().nextInt(100) + 1;
          _model.round += 1;
        });
      },
      child: const Text('Awesome!'),
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(_alertTitle()),
          content: Text('The slider\'s value is ${_model.current}.\n'
              'You scored ${_pointsForCurrentRound()} points this round.'),
          actions: [
            okButton,
          ],
          elevation: 5,
        );
      },
    );
  }
}
