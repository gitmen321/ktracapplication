import 'package:flutter/material.dart';
import 'package:ktracapplication/Theme/pallet.dart';
import 'package:ktracapplication/screens/login.dart';


class NavDrawer extends StatelessWidget {
  const NavDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Pallet.primary, Colors.black], // Replace with desired colors
        ),
      ),
      child: Drawer(
        backgroundColor: Colors.transparent,
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 110),
                  child: Image.asset('assets/logo/ktraclogo.png', height: 130),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Name',
                          style: TextStyle(color: Pallet.greenlight),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Binoy M P', // Static value
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white70,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Divider(
                          thickness: 1.5,
                          color: Colors.grey,
                          height: 10,
                        ),
                        SizedBox(height: 20),
                        Text(
                          'PEN',
                          style: TextStyle(color: Pallet.greenlight),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'T061026', // Static value
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white70,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Divider(
                          thickness: 1.5,
                          color: Colors.grey,
                          height: 10,
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Designation',
                          style: TextStyle(color: Pallet.greenlight),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'BADALI CONDUCTOR', // Static value
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white70,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Divider(
                          thickness: 1.5,
                          color: Colors.grey,
                          height: 10,
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Unit',
                          style: TextStyle(color: Pallet.greenlight),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'ALV', // Static value
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white70,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Divider(
                          thickness: 1.5,
                          color: Colors.grey,
                          height: 10,
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Status',
                          style: TextStyle(color: Pallet.greenlight),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Badali', // Static value
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white70,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Divider(
                          thickness: 1.5,
                          color: Colors.grey,
                          height: 10,
                        ),
                        SizedBox(height: 55),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              top: 270,
              right: 20,
              child: IconButton(
                icon: const Icon(Icons.edit_outlined, color: Colors.white),
                onPressed: () {
                  // Placeholder for edit action
                },
              ),
            ),
            SizedBox(height: 20,),
            Positioned(
              bottom: 20,
              left: 16,
              right: 16,
              child: Column(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white54,
                      minimumSize: const Size(250, 40),
                    ),
                    onPressed: () {
                      // Placeholder for attendance action
                    },
                    child: const Text(
                      'EARNINGS',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white54,
                        ),
                        onPressed: () {
                          // Placeholder for change pin
                        },
                        child: const Text(
                          'PASSWORD',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white54,
                        ),
                        onPressed: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                        },
                        child: const Text(
                          'LOGOUT',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
