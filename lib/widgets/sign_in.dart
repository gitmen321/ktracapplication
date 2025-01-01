import 'package:flutter/material.dart';
import 'package:ktracapplication/Theme/pallet.dart';
import 'package:ktracapplication/screens/home.dart';
import 'package:ktracapplication/services/mongo_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatefulWidget {
  final usernameController;
  const SignIn({super.key, required this.usernameController});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  MongoServices databaseService = MongoServices();

  Future<void> saveLoginPEN(String pen) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('loggedInPen', pen);
    } catch (e) {
      print("Error saving PEN to SharedPreferences: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 15),

          // Sign In Title
          const Center(
            child: Text(
              'Sign In',
              style: TextStyle(
                color: Pallet.primary,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Username Field
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: TextFormField(
              controller: widget.usernameController,
              decoration: InputDecoration(
                labelText: 'PEN',
                hintText: 'Enter your PEN',
                contentPadding: const EdgeInsets.only(left: 25),
                labelStyle: const TextStyle(
                  color: Pallet.primary,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(
                    color: Pallet.primary,
                    width: 1.5,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(
                    color: Pallet.primary,
                    width: 1.5,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Login Button
          Padding(
            padding: const EdgeInsets.only(left: 130, right: 130),
            child: MaterialButton(
              onPressed: () async {
                // Get the entered username
                final username = widget.usernameController.text.trim();

                // Validate login using the MongoServices function
                final pen = await databaseService.validateLogin(username);

                if (pen != null) {
                  // Save the PEN to SharedPreferences
                  await saveLoginPEN(pen);

                  // If login is successful, navigate to the dashboard
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(pen: pen),
                    ),
                  );
                } else {
                  // Show an error message if login fails
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Invalid Pen")),
                  );
                }
              },
              color: Pallet.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.symmetric(vertical: 12),
              minWidth: 150,
              height: 20,
              child: const Text(
                'Login',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            // MaterialButton(
            //   onPressed: () async {
            //     // Get the entered username
            //     final username = widget.usernameController.text.trim();

            //     // Validate login using the MongoServices function
            //     final pen = await databaseService.validateLogin(username);

            //     if (pen != null) {
            //       // Save the PEN to SharedPreferences
            //       // await saveLoginPEN(pen);

            //       // If login is successful, navigate to the dashboard
            //       Navigator.pushReplacement(
            //         context,
            //         MaterialPageRoute(
            //           builder: (context) => HomeScreen(pen: pen),
            //         ),
            //       );
            //     } else {
            //       // Show an error message if login fails
            //       ScaffoldMessenger.of(context).showSnackBar(
            //         const SnackBar(content: Text("Invalid Pen")),
            //       );
            //     }
            //   },
            //   color: Pallet.primary, // Background color
            //   shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.circular(30),
            //   ),
            //   padding: const EdgeInsets.symmetric(
            //     vertical: 12,
            //   ),
            //   minWidth: 150, // Minimum width
            //   height: 20, // Minimum height
            //   child: const Text(
            //     'Login',
            //     style: TextStyle(
            //       color: Colors.white,
            //       fontSize: 16,
            //       fontWeight: FontWeight.w500,
            //     ),
            //   ),
            // ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
