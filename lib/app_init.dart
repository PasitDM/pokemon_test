import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'common/constants.dart';
import 'models/app_model.dart';
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

      /// set the server config at first loading
      /// Load App model config
      // appConfig =
      //     await Provider.of<AppModel>(context, listen: false).loadAppConfig();

      Future.delayed(Duration.zero, () {
        /// Load more Category/Blog/Attribute Model beforehand
        // final lang = Provider.of<AppModel>(context, listen: false).langCode;

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
    Navigator.of(context).pushReplacementNamed(RouteList.home);
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
