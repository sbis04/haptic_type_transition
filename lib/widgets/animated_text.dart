import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:haptic_type_transition/constants.dart';
import 'package:haptic_type_transition/widgets/my_text.dart';

class AnimatedText extends StatefulWidget {
  const AnimatedText(
    this.texts, {
    super.key,
    required this.onComplete,
  });

  final List<String> texts;
  final Function(int index) onComplete;

  @override
  State<AnimatedText> createState() => _AnimatedTextState();
}

class _AnimatedTextState extends State<AnimatedText> {
  final List<MyText> _eachText = [];
  var _currentTextColor = textColors.first;

  _typeText(String wholeText, Color color) async {
    for (int i = 0; i < wholeText.length; i++) {
      await Future.delayed(typeDuration);
      setState(
        () => _eachText.add(
          MyText(
            wholeText[i],
            color: color,
          ),
        ),
      );
      HapticFeedback.selectionClick();
    }
  }

  _unTypeText(String wholeText) async {
    for (int i = wholeText.length - 1; i >= 0; i--) {
      await Future.delayed(unTypeDuration);
      setState(() => _eachText.removeAt(i));
      HapticFeedback.selectionClick();
    }
  }

  _animateText(String text, int index) async {
    await Future.delayed(secondLevelDuration);
    await _typeText(text, _currentTextColor);
    await Future.delayed(secondLevelDuration);
    widget.onComplete(index);
    setState(() => _currentTextColor = textColors[index]);
    await _unTypeText(text);
  }

  _startAnimation(List<String> texts) async {
    for (int i = 0; i < texts.length; i++) {
      await _animateText(texts[i], i);
    }
  }

  _loopAnimation() async {
    while (true) {
      await _startAnimation(widget.texts);
    }
  }

  @override
  void initState() {
    super.initState();
    _loopAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        Container(
          height: 36,
          width: 36,
          decoration: BoxDecoration(
            color: _currentTextColor,
            shape: BoxShape.circle,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 40.0),
          child: AnimatedSize(
            clipBehavior: Clip.none,
            duration: typeDuration,
            curve: Curves.easeInOut,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: _eachText,
            ),
          ),
        ),
      ],
    );
  }
}
