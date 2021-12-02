import 'package:flutter/material.dart';

import 'common/constants.dart';
import 'widgets/common/splash_screen.dart';

class AppInit extends StatefulWidget {
  const AppInit({Key? key}) : super(key: key);

  @override
  _AppInitState createState() => _AppInitState();
}

class _AppInitState extends State<AppInit> {
  bool hasLoadedData = false;
  bool hasLoadedSplash = false;

  Map? appConfig;

  @override
  void initState() {
    super.initState();
    loadInitData();
  }

  Future<void> loadInitData() async {
    try {
      print('[AppState] Init Data 💫');

      Future.delayed(Duration.zero, () {
        hasLoadedData = true;
        if (hasLoadedSplash) {
          goToNextScreen();
        }
      });

      print('[AppState] InitData Finish');
    } catch (e, trace) {
      print(e.toString());
      print(trace.toString());
    }
  }

  void goToNextScreen() {
    Navigator.of(context).pushReplacementNamed(RouteList.pokedex);
    // Navigator.of(context).pushReplacementNamed(RouteList.dashboard);
  }

  void checkToShowNextScreen() {
    /// If the config was load complete then navigate to Dashboard
    hasLoadedSplash = true;
    if (hasLoadedData) {
      goToNextScreen();
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    var splashScreenType = kSplashScreenType;
    var splashScreenData = kSplashScreen;

    return SplashScreenIndex(
      imageUrl: splashScreenData,
      splashScreenType: splashScreenType,
      actionDone: checkToShowNextScreen,
    );
  }
}
