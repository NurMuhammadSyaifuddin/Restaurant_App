import 'package:flutter/material.dart';
import 'package:submission_3/theme.dart';

import '../widgets/animation_splash_widget.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: orangeColor,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const AnimationSplash(),
              const SizedBox(height: 16.0),
              Flexible(
                  child: Text('Restaurant App',
                      style: whiteTextStyle.copyWith(fontSize: 24)))
            ],
          ),
        ),
      );
}
