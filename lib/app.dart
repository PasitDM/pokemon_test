import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_init.dart';
import 'models/index.dart';
import 'routes/route.dart';

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PokemonModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const Scaffold(
          body: AppInit(),
        ),
        routes: Routes.getAll(),
      ),
    );
  }
}
