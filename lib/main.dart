import 'package:beehive/splash.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const BeehiveApp());
}

class BeehiveApp extends StatelessWidget {
  const BeehiveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Beehive',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: const SplashScreen(),
    );
  }
}
