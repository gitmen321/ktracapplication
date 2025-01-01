import 'package:flutter/material.dart';
import 'package:ktracapplication/screens/get_started.dart';
import 'package:ktracapplication/screens/home.dart';
import 'package:ktracapplication/screens/lang_choos.dart';
import 'package:ktracapplication/screens/login.dart';
import 'package:ktracapplication/widgets/nav_drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

  
//   @override
//   Widget build(BuildContext context) {
//     return  MaterialApp(
//       debugShowCheckedModeBanner: false,
//       // home: GetStarted(),
//       home: LoginScreen(),
//       //home: NavDrawer(),
//      // home: HomeScreen(),
//     );
//   }
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Check if the user is already logged in
  final prefs = await SharedPreferences.getInstance();
  final loggedInPen = prefs.getString('loggedInPen');
  print(loggedInPen);

  runApp(MyApp(loggedInPen: loggedInPen));
}

class MyApp extends StatelessWidget {
  final String? loggedInPen;

  const MyApp({super.key, this.loggedInPen});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: loggedInPen != null
          ? HomeScreen(pen: loggedInPen!) // Navigate to Home if PEN exists
          : LoginScreen(), // Otherwise, show Login
    );
  }
}
