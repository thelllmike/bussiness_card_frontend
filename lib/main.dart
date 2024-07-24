import 'package:beehive/screen/home_screen.dart';
import 'package:beehive/screen/login_screen.dart';
import 'package:beehive/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(BeehiveApp());
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
      home:  LoginScreen(),
    );
  }
}
