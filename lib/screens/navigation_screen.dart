import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ktracapplication/screens/home.dart';

import '../Theme/pallet.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NavigationScreen(),
    );
  }
}

class NavigationScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<NavigationScreen> {
  late GoogleMapController mapController;

  final LatLng _initialPosition = const LatLng(8.4795, 76.9468); // Replace with actual coordinates

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: Pallet.greenlight, width: 2),
                left: BorderSide(color: Pallet.greenlight, width: 2),
                right: BorderSide(color: Pallet.greenlight, width: 2),
                bottom: BorderSide(color: Pallet.greenlight, width: 2),
              ),
            ),
            child: GoogleMap(
              liteModeEnabled: true,
              mapType: MapType.normal,
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _initialPosition,
                zoom: 16.0,
              ),
              markers: {
                Marker(
                  markerId: MarkerId('currentLocation'),
                  position: _initialPosition,
                ),
              },
            ),
          ),
          Positioned(
            bottom: 30,
            right: 16,
            child: Column(
              children: [
                FloatingActionButton(
                  heroTag: "callButton",
                  onPressed: () {
                    // Implement call function
                  },
                  backgroundColor: Pallet.greenlight,
                  child: Icon(Icons.call,color: Colors.white,size: 35,),
                ),
                SizedBox(height: 10),
                FloatingActionButton(
                  heroTag: "sosButton",
                  onPressed: () {
                    // Implement SOS function
                  },
                  backgroundColor: Colors.red,
                  child: Text("SOS", style: TextStyle(color: Colors.white,fontSize: 18)),
                ),
                SizedBox(height: 10),
                FloatingActionButton(
                  heroTag: "menuButton",
                  onPressed: () {
                    showDetailOverLay(context);
                    // Implement menu function
                  },
                  backgroundColor: Pallet.primary,
                  child: Icon(Icons.menu,color: Colors.white,size: 35,),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 30,
           // right: 400,
            left: 10,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.8), // Shadow color with opacity
                    spreadRadius: 2, // Spread radius
                    blurRadius: 5, // Blur radius
                    offset: Offset(0, 4), // Shadow position (x, y)
                  ),
                ],
              ),
              child: Column(
                children: [
                  IconButton(
                    icon: Icon(Icons.add, size: 30, color: Colors.black),
                    onPressed: () {
                      mapController.animateCamera(CameraUpdate.zoomIn());
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.remove, size: 30, color: Colors.black),
                    onPressed: () {
                      mapController.animateCamera(CameraUpdate.zoomOut());
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}




void showDetailOverLay(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
    builder: (BuildContext context) {
      return SafeArea(
        child: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SingleChildScrollView(
              child: Container(
                width: 400,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: Column(
                    children: [
                      // Details Section (Location Information)
                      // Container(
                      //   width: 400,
                      //   padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      //   decoration: BoxDecoration(
                      //     color: Pallet.greenlight.withOpacity(.1),
                      //     borderRadius: BorderRadius.circular(30),
                      //   ),
                      //   child: const Row(children: [
                      //     Icon(Icons.location_pin, color: Pallet.greenlight, size: 25),
                      //     SizedBox(width: 10),
                      //     Expanded(
                      //       child: Text(
                      //         "", // Replace with location details if needed
                      //         style: TextStyle(
                      //             color: Pallet.primary, fontSize: 18, fontWeight: FontWeight.w600),
                      //         maxLines: 2,
                      //         overflow: TextOverflow.ellipsis,
                      //       ),
                      //     ),
                      //   ]),
                      // ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              // showDialog(
                              //   context: context,
                              //   builder: (BuildContext context) {
                              //     return buildStopAlert();
                              //   },
                              // );
                              // Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                              //onTripEnd();
                            },
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(Pallet.primary),
                              elevation: WidgetStateProperty.all(5),
                            ),
                            child: const Text(
                              'STOP',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
    },
  );
}

buildStopAlert() {
}

