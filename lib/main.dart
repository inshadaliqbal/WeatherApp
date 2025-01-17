import 'package:flutter/material.dart';
import 'loadingscreen.dart';
import 'locationscreen.dart';

void main() => runApp(
      myApp(),
    );

class myApp extends StatelessWidget {
  const myApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoadingScreen(),
    );
  }
}
