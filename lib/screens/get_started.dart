import 'dart:math' as math;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ktracapplication/screens/lang_choos.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({super.key});

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Offset> slideAnimation;

  bool removeAnim1 = false;
  bool removeAnim2 = false;
  final PageController pgcontroller = PageController(initialPage: 0);
  int page = 0;

  ValueNotifier<double> valueListener = ValueNotifier(.0);

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(0.15, 0))
            .animate(controller);

    controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment(1, 1),
          children: [
            PageView(
              onPageChanged: (value) => setState(() {
                page = value;
              }),
              controller: pgcontroller,
              children: [
                // First Page
                LayoutBuilder(builder: (context, constraints) {
                  return Image(
                    height: constraints.maxHeight,
                    fit: BoxFit.cover,
                    image: const AssetImage(
                      'assets/images/faris-mohammed-8BlRtjLEvrw-unsplash.jpg',
                    ),
                  );
                }),
                // Second Page with Slide Button
                LayoutBuilder(builder: (context, constraints) {
                  return Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Image(
                        height: constraints.maxHeight,
                        fit: BoxFit.cover,
                        image: const AssetImage(
                          'assets/images/moody-cinematics-VzWbb-yztzg-unsplash.jpg',
                        ),
                      ),
                      Positioned(
                        top: 100,
                        child: Column(
                          children: [
                            Transform.rotate(
                              angle: -math.pi / 36,
                              child: Text(
                                'START JOURNEY WITH US',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.dancingScript(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 50,
                        child: Stack(
                          children: [
                            Container(
                              height: 70,
                              width: 250,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                color: Colors.black26,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  removeAnim1 == false
                                      ? SlideTransition(
                                          position: slideAnimation,
                                          child: const Icon(
                                            CupertinoIcons.chevron_right_2,
                                            color: Colors.white,
                                            size: 35,
                                          ),
                                        )
                                      : const SizedBox(),
                                  removeAnim2 == false
                                      ? SlideTransition(
                                          position: slideAnimation,
                                          child: const Icon(
                                            CupertinoIcons.chevron_right_2,
                                            color: Colors.white,
                                            size: 35,
                                          ),
                                        )
                                      : const SizedBox(),
                                ],
                              ),
                            ),
                            Container(
                              width: 250,
                              height: 70,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 0.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                color: Colors.black54,
                              ),
                              child: Builder(
                                builder: (context) {
                                  final handle = GestureDetector(
                                    onHorizontalDragUpdate: (details) async {
                                      valueListener.value = (valueListener.value +
                                              details.delta.dx /
                                                  (context.size!.width / 2))
                                          .clamp(.0, 1.0);
                                      if (valueListener.value > 0.3) {
                                        setState(() {
                                          removeAnim1 = true;
                                        });
                                      } else {
                                        setState(() {
                                          removeAnim1 = false;
                                        });
                                      }
                                      if (valueListener.value > 0.6) {
                                        setState(() {
                                          removeAnim2 = true;
                                        });
                                      } else {
                                        setState(() {
                                          removeAnim2 = false;
                                        });
                                      }
                                      if (valueListener.value == 1.0) {
                                        // Navigate to Login Page
                                        // Uncomment this line and update with your login page
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => SelectLanguageScreen()));
                                      }
                                    },
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        shape: const CircleBorder(),
                                        padding: const EdgeInsets.all(10),
                                        backgroundColor: Colors.white,
                                      ),
                                      onPressed: () {
                                        pgcontroller.nextPage(
                                          duration:
                                              const Duration(milliseconds: 500),
                                          curve: Curves.ease,
                                        );
                                      },
                                      child: const Icon(
                                        CupertinoIcons.checkmark_alt,
                                        size: 35,
                                        color: Colors.black,
                                      ),
                                    ),
                                  );

                                  return AnimatedBuilder(
                                    animation: valueListener,
                                    builder: (context, child) {
                                      return Align(
                                        alignment: Alignment(
                                            valueListener.value * 2 - 1, 0),
                                        child: child,
                                      );
                                    },
                                    child: handle,
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }),
              ],
            ),
            // Navigation Buttons
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Previous Button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(10),
                      backgroundColor: Colors.black54,
                    ),
                    onPressed: page == 0
                        ? null
                        : () {
                            pgcontroller.previousPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.ease,
                            );
                          },
                    child: const Icon(
                      CupertinoIcons.arrow_left,
                      size: 35,
                      color: Colors.white,
                    ),
                  ),
                  // Page Indicator
                  Row(
                    children: List<Widget>.generate(
                      2, // Two dots for two pages
                      (index) => AnimatedContainer(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        duration: const Duration(milliseconds: 300),
                        width: page == index ? 25 : 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: page == index ? Colors.white : Colors.grey,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ),
                  // Next Button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(10),
                      backgroundColor: Colors.black54,
                    ),
                    onPressed: page == 1
                        ? null
                        : () {
                            pgcontroller.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.ease,
                            );
                          },
                    child: const Icon(
                      CupertinoIcons.arrow_right,
                      size: 35,
                      color: Colors.white,
                    ),
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
