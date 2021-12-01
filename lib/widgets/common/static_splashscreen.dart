// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';

class StaticSplashScreen extends StatefulWidget {
  final String? imagePath;
  final Function? onNextScreen;
  final int duration;

  const StaticSplashScreen({
    Key? key,
    this.imagePath,
    this.onNextScreen,
    this.duration = 1000,
  }) : super(key: key);

  @override
  _StaticSplashScreenState createState() => _StaticSplashScreenState();
}

class _StaticSplashScreenState extends State<StaticSplashScreen> {
//   @override
//   void afterFirstLayout(BuildContext context) {
//     Future.delayed(Duration(milliseconds: widget.duration), () {
//       widget.onNextScreen!();
// //      Navigator.of(context).pushReplacement(
// //          MaterialPageRoute(builder: (context) => widget.onNextScreen));
//     });
//   }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: widget.duration), () {
      widget.onNextScreen!();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: widget.imagePath!.startsWith('http')
            ? Image.network(
                widget.imagePath!,
                fit: BoxFit.cover,
              )
            : Image.asset(
                widget.imagePath!,
                gaplessPlayback: true,
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}
