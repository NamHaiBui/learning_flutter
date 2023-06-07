import 'dart:math';
import 'package:flutter/material.dart';

//dynamic widget
class DiceRoller extends StatefulWidget {
  const DiceRoller({super.key});
  @override
  State<DiceRoller> createState() {
    return _DiceRollerState();
  }
}

class _DiceRollerState extends State<DiceRoller> {
  final roll = Random();
  var activeDiceImage = 'assets/images/dice-2.png';
  var randomDiceRoll = 1;
  void rollDice() {
    setState(() {
      randomDiceRoll = roll.nextInt(6) + 1;
    });
  }

  @override
  Widget build(context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'assets/images/dice-$randomDiceRoll.png',
          width: 200,
        ),
        TextButton(
          onPressed: rollDice,
          style: TextButton.styleFrom(
              padding: const EdgeInsets.only(
                top: 20,
              ),
              foregroundColor: Colors.white,
              textStyle: const TextStyle(fontSize: 28)),
          child: const Text('Roll Dice'),
        )
      ],
    );
  }
}
