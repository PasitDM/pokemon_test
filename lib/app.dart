import 'package:flutter/material.dart';

import 'app_init.dart';
import 'routes/route_observer.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Scaffold(
        body: AppInit(),
      ),
      routes: Routes.getAll(),
    );
  }
}
