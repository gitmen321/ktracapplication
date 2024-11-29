import 'package:flutter/material.dart';
import 'package:ktracapplication/screens/home.dart';
import 'package:ktracapplication/screens/login.dart';
import 'package:ktracapplication/widgets/nav_drawer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
      //home: NavDrawer(),
     // home: HomeScreen(),
    );
  }
}

