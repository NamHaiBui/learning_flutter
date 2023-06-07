import 'package:flutter/material.dart';
import 'package:my_app/dice_roller.dart';

const startAlignment = Alignment.topLeft;
const Alignment endAlignment = Alignment.bottomRight;

class GradientContainer extends StatelessWidget {
  // GradientContainer({key}):super(key: key);
  final List<Color> colors;
  const GradientContainer({super.key, required this.colors});
  GradientContainer.purple({super.key})
      : colors = [Colors.deepPurple, Colors.indigo];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: colors, begin: startAlignment, end: endAlignment)),
      child: const Center(
        child: DiceRoller(),
      ),
    );
  }
}

class StyledText extends StatelessWidget {
  final String outputText;
  const StyledText(this.outputText, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(outputText,
        style: const TextStyle(
          color: Color.fromRGBO(255, 41, 41, 0.452),
          fontSize: 28,
        ));
  }
}
