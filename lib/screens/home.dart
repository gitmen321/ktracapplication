import 'package:flutter/material.dart';
import 'package:ktracapplication/widgets/nav_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home"),),
      drawer: NavDrawer(),
    );
  }
}
