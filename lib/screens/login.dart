import 'package:flutter/material.dart';
import 'package:ktracapplication/Theme/pallet.dart';
import 'package:ktracapplication/screens/home.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final ValueNotifier<bool> obscureText = ValueNotifier<bool>(true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200], // Background color
      body: Stack(
        children: [
          // Background image with overlay
          Center(
            child: Column(
              children: [
                ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.3), // Adjust for dim effect
                    BlendMode.srcOver,
                  ),
                  child: Image.asset(
                    'assets/images/faris-mohammed-vNeB9rkPLQ4-unsplash.jpg',
                   // 'assets/images/intro.jpeg',
                    fit: BoxFit.cover,
                   // width: double.infinity,
                    height: 650,
                  ),
                ),
              ],
            ),
          ),

          // Logo at the top
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Image.asset(
                'assets/logo/ktraclogo.png',
                height: 120,
                width: 120,
              ),
            ),
          ),

          // Login form at the bottom
          Align(
            alignment: Alignment.bottomCenter,
            child: SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white, // Card background color
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, -3),
                    ),
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(3, 0),
                    ),
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(-3, 0),
                    ),
                  ],
                ),
                child: Padding(
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
                          controller: usernameController,
                          decoration: InputDecoration(
                            labelText: 'Username',
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
                              borderSide:  BorderSide(
                                color: Pallet.primary,
                                width: 1.5,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Password Field with toggle visibility
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: ValueListenableBuilder<bool>(
                          valueListenable: obscureText,
                          builder: (context, value, child) {
                            return TextFormField(
                              controller: passwordController,
                              obscureText: value,
                              decoration: InputDecoration(
                                labelText: 'Password',
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
                                  borderSide:  BorderSide(
                                    color: Pallet.primary,
                                    width: 1.5,
                                  ),
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    value
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Pallet.primary,
                                  ),
                                  onPressed: () {
                                    obscureText.value = !value;
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Login Button
                      Padding(
                        padding: const EdgeInsets.only(left: 130,right: 130,),
                        child: MaterialButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                          },
                          color: Pallet.primary, // Background color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                          ),
                          minWidth: 150, // Minimum width
                          height: 20, // Minimum height
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
