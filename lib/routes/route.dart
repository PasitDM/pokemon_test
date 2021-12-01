import 'package:flutter/material.dart';

import '../common/constants.dart';
import '../screens/index.dart';
import '../tabbar.dart';

class Routes {
  static Map<String, WidgetBuilder> getAll() => _routes;

  static final Map<String, WidgetBuilder> _routes = {
    RouteList.dashboard: (context) => const MainTabs(),
    RouteList.home: (context) => const HomeScreen()
  };
}
