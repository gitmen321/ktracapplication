import 'dart:async';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ktracapplication/Theme/color.dart';
import 'package:ktracapplication/screens/navigation_screen.dart';
import 'package:ktracapplication/widgets/nav_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late DateTime now;
  late DateTime today;
  // final currentTrip = 0;
  bool isTripAssigned = false; // Determines if a trip is accepted
  bool currentTrip = false; // Indicates whether the trip is in progress
  final tripComplete = 0;
  int _index = 2;
  List<FlSpot> spots = [];
  bool isOnline = false;

  void _showCustomDialog(BuildContext context) {
    int timerValue = 1800; // 30 minutes in seconds
    Timer? countdownTimer;

    void handleAction(String action) {
      countdownTimer?.cancel(); // Stop the timer
      Navigator.of(context).pop(); // Close the dialog
      if (action == "Accept" || action == "Reject") {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text(
                "Are you sure?",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              content:
                  const Text("Do you really want to proceed with this action?"),
              actions: [
                TextButton(
                  onPressed: () =>
                      Navigator.of(context).pop(), // Cancel confirmation
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close confirmation dialog
                    if (action == "Accept") {
                      setState(() {
                        isTripAssigned = true; // Accept trip
                      });
                    } else if (action == "Reject") {
                      setState(() {
                        isTripAssigned = false; // Reject trip
                      });
                    }
                  },
                  child: const Text("Yes"),
                ),
              ],
            );
          },
        );
      }
    }

    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timerValue <= 0) {
        countdownTimer?.cancel();
        Navigator.of(context).pop();
        setState(() {
          isTripAssigned = true;
        });
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text(
              "Trip Accepted",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content: const Text(
              "Time expired. Trip has been accepted automatically.",
              style: TextStyle(fontSize: 16),
            ),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                child: const Text("OK"),
              ),
            ],
          ),
        );
      } else {
        timerValue--;
      }
    });

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Container(
                padding: const EdgeInsets.all(22.0),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Trip Scheduled",
                      style: GoogleFonts.lato(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 24),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Kannur to Eranakulam",
                      style: GoogleFonts.lato(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 18),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Start Time: 10:00 AM",
                      style:
                          GoogleFonts.lato(color: Colors.black54, fontSize: 16),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Time Remaining: ${timerValue ~/ 60}:${(timerValue % 60).toString().padLeft(2, '0')}",
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () => handleAction("Accept"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 12,
                            ),
                          ),
                          child: Text(
                            "Accept",
                            style: GoogleFonts.lato(
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () => handleAction("Reject"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 12,
                            ),
                          ),
                          child: Text(
                            "Reject",
                            style: GoogleFonts.lato(
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    ).then((_) {
      countdownTimer?.cancel();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        title: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  isOnline ? 'Online' : 'Offline',
                  style: GoogleFonts.lato(
                    color: isOnline ? primary : Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 30),
            Align(
              alignment: Alignment.topRight,
              child: Switch(
                value: isOnline,
                onChanged: (value) {
                  setState(() {
                    isOnline = value;
                    if (value) {
                      _showNotification(context);
                      _showCustomDialog(context);

                    } else {
                      setState(() {
                        isTripAssigned = false;
                      });
                    }
                  });
                },
                activeColor: Colors.white,
                activeTrackColor: Colors.green,
                inactiveThumbColor: const Color.fromARGB(182, 255, 255, 255),
                inactiveTrackColor: const Color.fromARGB(43, 0, 0, 0),
              ),
            ),
          ],
        ),
        leading: Builder(
          builder: (context) => Padding(
            padding: const EdgeInsets.all(6.0),
            child: IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon:
                  const Icon(Icons.menu_rounded, color: greenlight, size: 40.0),
            ),
          ),
        ),
        backgroundColor: secondary,
      ),
      drawer: const NavDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 50),
            isTripAssigned ? buildCurrentTrip() : buildTripNotAssigned(),
            buildWorkChart(),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.only(bottom: 20, left: 30, right: 30),
              child: Divider(color: greenlight.withOpacity(.3), thickness: 1),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                isTripAssigned?
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => 
                             NavigationScreen()));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: greenlight,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text("START JOURNEY",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w700)),
                    ),
                  ),
                )
                : Container(),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _showNotification(BuildContext context) {
    OverlayEntry overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).size.height *
            0.1, // Adjust vertical position
        left: MediaQuery.of(context).size.width * 0.1, // Horizontal padding
        right: MediaQuery.of(context).size.width * 0.1,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "You have a notification",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "You have been scheduled a trip",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    // Insert the overlay entry
    Overlay.of(context).insert(overlayEntry);

    // Remove the overlay entry after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      overlayEntry.remove();
    });
  }

//trip is not assigned
  Widget buildTripNotAssigned() {
    return Column(
      children: [
        Text(
          "NO TRIP ASSIGNED",
          style: GoogleFonts.lato(
            color: primary,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: greenlight.withOpacity(.1),
            borderRadius: BorderRadius.circular(20),
          ),
          margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          padding:
              const EdgeInsets.only(top: 22, bottom: 10, right: 20, left: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Trip No: 00",
                      style: TextStyle(
                          color: primary, fontWeight: FontWeight.w400)),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.35,
                    child: const Text(' ',
                        // overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                            fontSize: 16,
                            color: greenlight,
                            fontWeight: FontWeight.w800)),
                  ),
                  const Text(('00/00/00'),
                      style: TextStyle(
                          color: primary,
                          fontWeight: FontWeight.w400,
                          fontSize: 13)),
                  const Text(
                    ('00:00 '),
                    style: TextStyle(
                        color: primary,
                        fontWeight: FontWeight.w400,
                        fontSize: 13),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.35,
                    child: const Text('',
                        // overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                            fontSize: 16,
                            color: greenlight,
                            fontWeight: FontWeight.w800)),
                  ),
                  const Text(('00/00/00'),
                      style: TextStyle(
                          color: primary, fontWeight: FontWeight.w400)),
                  const Text(
                    ('00:00'),
                    style:
                        TextStyle(color: primary, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 10),
                  const Text('Not Scheduled',
                      style: TextStyle(
                          fontSize: 12,
                          color: primary,
                          fontWeight: FontWeight.w400)),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.35,
                    child: const Text(" ",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 13,
                            fontWeight: FontWeight.w400)),
                  ),
                ],
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.40,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        // ignore: unnecessary_null_comparison

                        "Not Assigned",
                        style: TextStyle(
                            color: greenlight, fontWeight: FontWeight.w500)),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildCurrentTrip() {
    return Column(
      children: [
        Text("CURRENT TRIP",
            style: GoogleFonts.lato(
                color: primary, fontSize: 16, fontWeight: FontWeight.w700)),
        Container(
          decoration: BoxDecoration(
            color: greenlight.withOpacity(.1),
            borderRadius: BorderRadius.circular(20),
          ),
          margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          padding:
              const EdgeInsets.only(top: 10, bottom: 10, right: 20, left: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Trip No: 123456",
                      style: TextStyle(
                          color: primary, fontWeight: FontWeight.w400)),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.35,
                    child: const Text('Kannur',
                        // overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                            fontSize: 16,
                            color: greenlight,
                            fontWeight: FontWeight.w800)),
                  ),
                  const Text(('10/11/2024'),
                      style: TextStyle(
                          color: primary,
                          fontWeight: FontWeight.w400,
                          fontSize: 13)),
                  const Text(
                    ('10:00 am'),
                    style: TextStyle(
                        color: primary,
                        fontWeight: FontWeight.w400,
                        fontSize: 13),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.35,
                    child: const Text('Eranakulam',
                        // overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                            fontSize: 16,
                            color: greenlight,
                            fontWeight: FontWeight.w800)),
                  ),
                  const Text(('10/11/2024'),
                      style: TextStyle(
                          color: primary, fontWeight: FontWeight.w400)),
                  const Text(
                    ('05:00 pm'),
                    style:
                        TextStyle(color: primary, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 10),
                  const Text('Trip Scheduled',
                      style: TextStyle(
                          fontSize: 12,
                          color: primary,
                          fontWeight: FontWeight.w400)),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.35,
                    child: const Text(" ",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 13,
                            fontWeight: FontWeight.w400)),
                  ),
                ],
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.40,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        // ignore: unnecessary_null_comparison

                        "In Progress",
                        style: TextStyle(
                            color: greenlight, fontWeight: FontWeight.w500)),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
            margin:
                const EdgeInsets.only(top: 5, bottom: 10, left: 30, right: 30),
            child: Divider(color: greenlight.withOpacity(.3), thickness: 1)),
      ],
    );
  }

  // Widget buildTripCard() {
  //   return Container(
  //     margin: const EdgeInsets.only(top: 20, bottom: 30, left: 5, right: 5),
  //     child: SizedBox(
  //       height: MediaQuery.of(context).size.width / 2.7, // Card height
  //       child: PageView.builder(
  //         itemCount: 1,
  //         controller: PageController(viewportFraction: 0.36, initialPage: 2),
  //         onPageChanged: (index) => setState(() => _index = index),
  //         itemBuilder: (context, index) {
  //           double scale =
  //               _index == index ? 1 : .7; // Scale up if it's the middle card
  //           return AnimatedContainer(
  //             duration: const Duration(milliseconds: 400),
  //             curve: Curves.fastOutSlowIn,
  //             child: Transform.scale(
  //               scale: scale,
  //               child: Container(
  //                 //width: MediaQuery.of(context).size.width / 2.5,
  //                 decoration: BoxDecoration(
  //                   borderRadius: BorderRadius.circular(10),
  //                   image: DecorationImage(
  //                     image: MemoryImage(base64Decode(('vehicle photo'))),
  //                     fit: BoxFit.fill, // Make the image fill the container
  //                   ),
  //                 ),
  //                 child: Stack(
  //                   fit: StackFit.expand,
  //                   children: [
  //                     DecoratedBox(
  //                       decoration: BoxDecoration(
  //                         borderRadius: BorderRadius.circular(10),
  //                         color: _index == index
  //                             ? primary.withOpacity(.3)
  //                             : Colors.black.withOpacity(.2),
  //                       ),
  //                       child: Padding(
  //                         padding: const EdgeInsets.only(
  //                             left: 20.0, right: 10.0, top: 15, bottom: 10.0),
  //                         child: Column(
  //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                           children: [
  //                             const Row(
  //                               mainAxisAlignment:
  //                                   MainAxisAlignment.spaceBetween,
  //                               children: [
  //                                 Icon(
  //                                   Icons.circle_outlined,
  //                                   color: Colors.white,
  //                                   size: 15,
  //                                 ),
  //                               ],
  //                             ),
  //                             Column(
  //                               mainAxisAlignment: MainAxisAlignment.start,
  //                               crossAxisAlignment: CrossAxisAlignment.start,
  //                               children: [
  //                                 // Text("${loginController.trips[index].tripStartLocation} - ${loginController.trips[index].tripDestination.}", style: const TextStyle(color:Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
  //                                 const Text("Kannur - Eranakulam",
  //                                     style: TextStyle(
  //                                         color: Colors.white,
  //                                         fontSize: 12,
  //                                         fontWeight: FontWeight.bold)),
  //                                 Container(
  //                                   width: MediaQuery.of(context).size.width *
  //                                       0.20,
  //                                   color: greenlight,
  //                                   child: const Padding(
  //                                     padding:
  //                                         EdgeInsets.symmetric(horizontal: 3.0),
  //                                     child: Row(
  //                                       children: [
  //                                         Icon(
  //                                           Icons.calendar_today,
  //                                           color: Colors.white,
  //                                           size: 10,
  //                                         ),
  //                                         SizedBox(width: 3),
  //                                         //Text(loginController.trips[index].tripDate, style: const TextStyle(color:Colors.white, fontSize: 10, fontWeight: FontWeight.w400)),
  //                                         Text(('10/11/2024'),
  //                                             style: TextStyle(
  //                                                 color: Colors.white,
  //                                                 fontSize: 10,
  //                                                 fontWeight: FontWeight.w400)),
  //                                       ],
  //                                     ),
  //                                   ),
  //                                 ),
  //                                 const SizedBox(height: 2),
  //                                 Container(
  //                                   width: MediaQuery.of(context).size.width *
  //                                       0.28,
  //                                   color: greenlight,
  //                                   child: const Padding(
  //                                     padding:
  //                                         EdgeInsets.symmetric(horizontal: 3.0),
  //                                     child: Row(
  //                                       children: [
  //                                         Icon(
  //                                           Icons.access_time_rounded,
  //                                           color: Colors.white,
  //                                           size: 10,
  //                                         ),
  //                                         SizedBox(width: 3),
  //                                         Text("12:00AM- 6:00PM",
  //                                             style: TextStyle(
  //                                                 color: Colors.white,
  //                                                 fontSize: 10,
  //                                                 fontWeight: FontWeight.w400)),
  //                                       ],
  //                                     ),
  //                                   ),
  //                                 ),
  //                               ],
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           );
  //         },
  //       ),
  //     ),
  //   );
  // }

  Widget buildWorkChart() {
    // List<FlSpot> spots = List.generate(12, (index) => FlSpot(index + 1, getTripsForMonth(index + 1).toDouble()));

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 30),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text("WORK CHART",
                        style: GoogleFonts.lato(
                            color: primary,
                            fontSize: 16,
                            fontWeight: FontWeight.w700)),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 65,
                    decoration: BoxDecoration(
                      color: secondary,
                      border: Border.all(color: greenlight, width: .25),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 5.0),
                          child: Text("Total Hours",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 8,
                                  fontWeight: FontWeight.w400)),
                        ),
                        const Text('0',
                            style: TextStyle(
                                color: greenlight,
                                fontSize: 12,
                                fontWeight: FontWeight.w900)),
                        Image.asset('assets/graph/graph1.png', width: 100),
                      ],
                    ),
                  ),
                  Container(
                    height: 65,
                    decoration: BoxDecoration(
                      color: secondary,
                      border: Border.all(color: greenlight, width: .25),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 5.0),
                          child: Text("Total Trips",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 8,
                                  fontWeight: FontWeight.w400)),
                        ),
                        const Text('0',
                            style: TextStyle(
                                color: greenlight,
                                fontSize: 12,
                                fontWeight: FontWeight.w900)),
                        Image.asset('assets/graph/graph1.png', width: 100),
                      ],
                    ),
                  ),
                  Container(
                    height: 65,
                    decoration: BoxDecoration(
                      color: secondary,
                      border: Border.all(color: greenlight, width: .25),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 5.0),
                          child: Text("This Week",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 8,
                                  fontWeight: FontWeight.w400)),
                        ),
                        const Text('0',
                            style: TextStyle(
                                color: greenlight,
                                fontSize: 12,
                                fontWeight: FontWeight.w900)),
                        Image.asset('assets/graph/graph1.png', width: 100),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 30),
        Container(
          margin: const EdgeInsets.only(top: 20, right: 30, left: 20),
          height: 120,
          width: MediaQuery.of(context).size.width * 0.9,
          child: LineChart(
            LineChartData(
              minY: 0,
              gridData: FlGridData(
                show: true,
                getDrawingHorizontalLine: (value) {
                  return const FlLine(
                    color: greenlight,
                    strokeWidth: 0.3,
                    dashArray: [2, 5],
                  );
                },
                drawVerticalLine: false,
              ),
              borderData: FlBorderData(show: false),
              titlesData: FlTitlesData(
                show: true,
                topTitles:
                    const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles:
                    const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 30,
                    interval: 1,
                    getTitlesWidget: bottomTitleWidgets,
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: 1000,
                    getTitlesWidget: leftTitleWidgets,
                    reservedSize: 28,
                  ),
                ),
              ),
              backgroundColor: secondary,
              lineBarsData: [
                LineChartBarData(
                  spots: spots,
                  dotData: FlDotData(
                    getDotPainter: (spot, percent, barData, index) {
                      return FlDotCirclePainter(
                        color: greenlight,
                        radius: 4,
                      );
                    },
                  ),
                  color: primary,
                  barWidth: 2,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.w300,
      color: Colors.grey,
      fontSize: 6,
    );
    Widget text;
    switch (value.toInt()) {
      case 1:
        text = const Text('JAN', style: style);
        break;
      case 2:
        text = const Text('FEB', style: style);
        break;
      case 3:
        text = const Text('MAR', style: style);
        break;
      case 4:
        text = const Text('APR', style: style);
        break;
      case 5:
        text = const Text('MAY', style: style);
        break;
      case 6:
        text = const Text('JUN', style: style);
        break;
      case 7:
        text = const Text('JUL', style: style);
        break;
      case 8:
        text = const Text('AUG', style: style);
        break;
      case 9:
        text = const Text('SEP', style: style);
        break;
      case 10:
        text = const Text('OCT', style: style);
        break;
      case 11:
        text = const Text('NOV', style: style);
        break;
      case 12:
        text = const Text('DEC', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.w300,
      color: Colors.grey,
      fontSize: 6,
    );
    String text;
    switch (value.toInt()) {
      case 1000:
        text = '1000';
        break;
      case 2000:
        text = '2000';
        break;
      case 3000:
        text = '3000';
        break;
      case 4000:
        text = '4000';
        break;
      case 5000:
        text = '5000';
        break;
      case 6000:
        text = '6000';
        break;
      case 7000:
        text = '7000';
        break;
      case 8000:
        text = '8000';
        break;
      case 9000:
        text = '9000';
        break;
      case 10000:
        text = '10000';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }
}
