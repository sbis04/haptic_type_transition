import 'package:flutter/material.dart';
import 'package:haptic_type_transition/constants.dart';

class MyText extends StatelessWidget {
  const MyText(
    this.text, {
    super.key,
    required this.color,
  });

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: firstLevelDuration,
      opacity: text.isEmpty ? 0 : 1,
      curve: Curves.easeInOut,
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 36,
          fontWeight: FontWeight.w600,
          letterSpacing: -1,
        ),
      ),
    );
  }
}
