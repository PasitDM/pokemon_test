import 'package:flutter/material.dart';

import '../common/constants.dart';
import '../screens/index.dart';

class Routes {
  static Map<String, WidgetBuilder> getAll() => _routes;

  static final Map<String, WidgetBuilder> _routes = {
    RouteList.pokedex: (context) => const PokedexScreen()
  };
}
