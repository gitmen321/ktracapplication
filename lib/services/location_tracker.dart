import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

import 'mongo_service.dart';

String mongoDbUri = MongoServices.mongoDbUri;

class LocationTracker {
  static Timer? _locationUpdateTimer; // Timer object to manage periodic updates

  // Check permissions and update location periodically
  static Future<void> trackDeviceLocation(String tripId) async {
    // Check permissions
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        print("Location permission not granted");
        return;
      }
    }
    // Immediate location update
    try {
      await updateLocationData(tripId: tripId);
    } catch (e) {
      print("Error fetching location immediately: $e");
    }
    // Start periodic location tracking every 5 minutes
    const updateInterval = Duration(minutes: 5);

    _locationUpdateTimer =  Timer.periodic(updateInterval, (timer) async {
      try {
        // Call the updateLocationData function to fetch and update location
        await updateLocationData(tripId: tripId);
      } catch (e) {
        print("Error fetching location: $e");
      }
    });
  }

  // Function to stop location updates
  static void stopTrackingLocation() {
    if (_locationUpdateTimer?.isActive ?? false) {
      _locationUpdateTimer?.cancel();
      print("Location tracking stopped.");
    } else {
      print("Location tracking was not started.");
    }
  }

  static Future<void> updateLocationData({required String tripId}) async {
    const String tripsCollectionName = "trips";

    try {
      // Get the current location of the device
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // Get the current timestamp
      DateTime timestamp = DateTime.now();

      // Create a connection to MongoDB
      final db = await mongo.Db.create(mongoDbUri);
      await db.open();

      // Reference the trips collection
      final tripsCollection = db.collection(tripsCollectionName);

      // Prepare location data to be added
      final locationData = {
        'latitude': position.latitude,
        'longitude': position.longitude,
        'timestamp': timestamp.toIso8601String(),
      };

      // Define the filter to find the document with the given trip_id
      final filter = {'trip_id': tripId};

      // Check if the document exists
      final existingDocument = await tripsCollection.findOne(filter);

      if (existingDocument != null)  {
        // Document exists; check if the 'location' field exists
        if (!existingDocument.containsKey('location')) {
          // 'location' field doesn't exist; create it and add the location data
          final update = {
            '\$set': {
              'location': locationData, // Initialize location array with the first entry
            },
          };
          await tripsCollection.updateOne(filter, update);
          print("Created 'location' field and added data for Trip ID: $tripId");
        } else {
          // Replace the location field with the new location data (overwrite)
          final update = {
            '\$set': {
              'location': locationData, // Replace the location array with the new data
            },
          };
          final result = await tripsCollection.updateOne(filter, update);

          if (result.nModified > 0) {
            print("Location data replaced for Trip ID: $tripId");
          } else {
            print("No changes made to the document for Trip ID: $tripId.");
          }
        }
      }

      // Close the MongoDB connection
      await db.close();
    } catch (e) {
      print("Error updating location data: $e");
    }
  }



}
