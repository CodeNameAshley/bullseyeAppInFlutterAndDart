import 'package:flutter/material.dart';

class Score extends StatelessWidget {
  const Score({Key? key, required this.totalScore, required this.round})
      : super(key: key);

  final int totalScore;
  final int round;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextButton(
          onPressed: () {},
          child: const Text('Start Over'),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              const Text('Score: '),
              Text('$totalScore'),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              const Text(' Round: '),
              Text('$round'),
            ],
          ),
        ),
        TextButton(
          onPressed: () {},
          child: const Text('Info'),
        ),
      ],
    );
  }
}
