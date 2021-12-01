import 'package:flutter/material.dart';
import '../../common/constants.dart';
import 'static_splashscreen.dart';

class SplashScreenIndex extends StatelessWidget {
  final Function actionDone;
  final String splashScreenType;
  final String imageUrl;

  const SplashScreenIndex({
    Key? key,
    required this.actionDone,
    required this.imageUrl,
    this.splashScreenType = SplashScreenTypeConstants.static,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (splashScreenType) {
      case SplashScreenTypeConstants.static:
      default:
        return StaticSplashScreen(
          imagePath: imageUrl,
          onNextScreen: actionDone,
        );
    }
  }
}
