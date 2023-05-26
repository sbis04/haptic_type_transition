import 'package:flutter/material.dart';
import 'package:haptic_type_transition/constants.dart';

import 'widgets/animated_text.dart';
import 'widgets/auth_bottom_sheet.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color bgColor = bgColors.first;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: AnimatedContainer(
        duration: thirdLevelDuration,
        color: bgColor,
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedText(
                    texts,
                    onComplete: (index) => setState(
                      () => bgColor = bgColors[index],
                    ),
                  ),
                ],
              ),
            ),
            const AuthBottomSheet(),
          ],
        ),
      ),
    );
  }
}
