import 'dart:async';

import 'package:flutter/cupertino.dart';

class AnimationSplash extends StatefulWidget {
  const AnimationSplash({super.key});

  @override
  State<StatefulWidget> createState() => _AnimationSplash();
}

class _AnimationSplash extends State<AnimationSplash> {
  double startSize = 100;
  double finishSize = 100;

  @override
  Widget build(BuildContext context) {
    return Flexible(
        child: AnimatedContainer(
      curve: Curves.bounceOut,
      duration: const Duration(seconds: 1),
      width: startSize,
      height: finishSize,
      child: Image.asset('assets/onboarding.png'),
    ));
  }

  startSplashScreen() async {
    var duration = const Duration(milliseconds: 500);
    return Timer(duration, () {
      setState(() {
        startSize *= 1.5;
        finishSize *= 1.5;
      });
      Timer(const Duration(milliseconds: 1500), () {
        Navigator.pushReplacementNamed(context, '/home_page');
      });
    });
  }

  @override
  void initState() {
    startSplashScreen();
    super.initState();
  }
}
