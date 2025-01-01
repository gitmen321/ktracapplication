import 'package:mongo_dart/mongo_dart.dart' as mongo;

class MongoServices {
  static const String mongoDbUri =
      'mongodb+srv://Whitematrix2024:upwGSSlVQ1lcV2Vr@cluster0.11vvw.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0';



  /// Fetch the ObjectId of a driver or conductor based on PEN
  Future<String?> fetchDriverOrConductorObjectId(String pen) async {
    try {
      final db = await mongo.Db.create(mongoDbUri);
      await db.open();

      // Check in the drivers collection
      final driversCollection = db.collection('drivers');
      final driver = await driversCollection.findOne(mongo.where.eq('PEN', pen));

      if (driver != null) {
        await db.close();
        return driver['_id'].toHexString(); // Return the ObjectId as a string
      }

      // Check in the conductors collection
      final conductorsCollection = db.collection('conductors');
      final conductor = await conductorsCollection.findOne(mongo.where.eq('PEN', pen));

      if (conductor != null) {
        await db.close();
        return conductor['_id'].toHexString(); // Return the ObjectId as a string
      }

      await db.close();
      return null; // No matching driver or conductor found
    } catch (e) {
      print('Error fetching ObjectId: $e');
      return null;
    }
  }

  /// Fetch pending trip for the given ObjectId
  Future<Map<String, dynamic>?> fetchPendingTrip(String objectId) async {
    try {
      final db = await mongo.Db.create(mongoDbUri);
      await db.open();

      final tripCollection = db.collection('trips');
      final trip = await tripCollection.findOne(
        mongo.where.eq('driver_id', mongo.ObjectId.parse(objectId)).eq('status', 'pending'),
      );

      if (trip != null) {
        trip['_id'] = trip['_id'].toHexString(); // Convert ObjectId to String
        await db.close();
        return trip;
      }

      await db.close();
      return null; // No pending trip found
    } catch (e) {
      print('Error fetching pending trip: $e');
      return null;
    }
  }

  /// Fetch upcoming trip for the given ObjectId
  Future<Map<String, dynamic>?> fetchUpcomingTrip(String objectId) async {
    try {
      final db = await mongo.Db.create(mongoDbUri);
      await db.open();

      final tripCollection = db.collection('trips');
      final trip = await tripCollection.findOne(
        mongo.where.eq('driver_id', mongo.ObjectId.parse(objectId)).eq('status', 'upcoming'),
      );

      if (trip != null) {
        trip['_id'] = trip['_id'].toHexString(); // Convert ObjectId to a readable string
        await db.close();
        return trip;
      }

      await db.close();
      return null; // No upcoming trip found
    } catch (e) {
      print('Error fetching upcoming trip: $e');
      return null;
    }
  }



  /// Update trip status
  Future<bool> updateTripStatus(String tripId, String newStatus) async {
    try {
      final db = await mongo.Db.create(mongoDbUri);
      await db.open();

      final tripCollection = db.collection('trips');
      final result = await tripCollection.updateOne(
        mongo.where.eq('_id', mongo.ObjectId.parse(tripId)),
        mongo.modify.set('status', newStatus),
      );

      await db.close();
      return result.isSuccess;
    } catch (e) {
      print('Error updating trip status: $e');
      return false;
    }
  }


  /// Standalone function to validate login
Future<String?> validateLogin(String pen) async {
  const String mongoUri = mongoDbUri;
  const String driversCollectionName = "drivers";
  const String conductorsCollectionName = "conductors";

  try {
    final db = await mongo.Db.create(mongoUri);
    await db.open();
    print("MongoDB Connected Successfully!");

    // Check in drivers collection
    final driversCollection = db.collection(driversCollectionName);
    final driver = await driversCollection.findOne(mongo.where.eq('PEN', pen));
    if (driver != null) {
      await db.close();
      print("MongoDB Connection Closed.");
      return pen; // Return PEN if found in drivers collection
    }

    // Check in conductors collection
    final conductorsCollection = db.collection(conductorsCollectionName);
    final conductor = await conductorsCollection.findOne(mongo.where.eq('PEN', pen));
    if (conductor != null) {
      await db.close();
      return pen; // Return PEN if found in conductors collection
    }

    await db.close();
    return null; // Return null if PEN is not found
  } catch (e) {
    print("Error during login validation: $e");
    return null;
  }
}


    ///stand alone function to fetch profile details
  Future<Map<String, dynamic>?> fetchDriverDetails(String pen) async {

    const String mongoUri = mongoDbUri; // Replace with your URI
    const String driversCollectionName = "drivers";
    const String conductorsCollectionName = "conductors";

    try {
      final db = await mongo.Db.create(mongoUri);
      await db.open();

      final collection = db.collection(driversCollectionName);
      final driver = await collection.findOne(mongo.where.eq('PEN', pen));
      //print(driver);
      if (driver != null) {
        driver['_id'] =
            driver['_id'].toHexString(); // Convert ObjectId to String if needed
        //}

        await db.close();
        return driver;
      }

      // If not found in drivers, check in the conductors collection

      final conductorsCollection = db.collection(conductorsCollectionName);
      final conductor = await conductorsCollection.findOne(mongo.where.eq('PEN', pen));

      if (conductor != null) {
        // If found in conductors, add the role and convert ObjectId to String
        conductor['_id'] = conductor['_id'].toHexString();
        print(conductor);
        conductor['role'] = 'Conductor';
        await db.close();
        return conductor;
      }


    } catch (e) {
      print('Error fetching driver details: $e');
      return null;
    }
    return null;
  }


  // /// Trip details
  // Future<List<Map<String, dynamic>>?> fetchTripDetailsByPEN(String pen) async {
  //   String mongoUri = mongoDbUri;
  //   const String driversCollectionName = 'drivers';
  //   const String conductorsCollectionName = 'conductors';
  //   const String tripsCollectionName = 'trips';
  //   const String vehiclesCollectionName = 'vehicles';

  //   try {
  //     // Connect to the database
  //     final db = await mongo.Db.create(mongoUri);
  //     await db.open();

  //     // Check for the ObjectId corresponding to the PEN in the drivers or conductors collection
  //     final driversCollection = db.collection(driversCollectionName);
  //     final conductorsCollection = db.collection(conductorsCollectionName);

  //     final driver = await driversCollection.findOne(mongo.where.eq('PEN', pen));
  //     print(driver);
  //     final conductor = await conductorsCollection.findOne(mongo.where.eq('PEN', pen));
  //     print(conductor);

  //     String? personId;
  //     String role; // To identify if the person is a driver or conductor.

  //     if (driver != null) {
  //       personId = driver['_id']?.toHexString();
  //       role = 'driver';
  //     } else if (conductor != null) {
  //       personId = conductor['_id']?.toHexString();
  //       role = 'conductor';
  //     } else {
  //       await db.close();
  //       return null; // No matching PEN found in either collection
  //     }

  //     // Fetch trips based on the role and personId
  //     final tripsCollection = db.collection(tripsCollectionName);
  //     final trips = await tripsCollection.find(
  //         mongo.where.eq('${role}_id', mongo.ObjectId.fromHexString(personId!))
  //     ).toList();

  //     print(trips);

  //     // If no trips are found, return an empty list
  //     if (trips.isEmpty) {
  //       await db.close();
  //       return [];
  //     }

  //     // Convert ObjectIds to Strings and add bus number details
  //     for (var trip in trips) {
  //       trip['_id'] = trip['_id']?.toHexString();
  //       trip['vehicle_id'] = trip['vehicle_id']?.toHexString();
  //       trip['driver_id'] = trip['driver_id']?.toHexString();
  //       trip['conductor_id'] = trip['conductor_id']?.toHexString();

  //       // Fetch bus number from vehicles collection
  //       if (trip['vehicle_id'] != null) {
  //         final vehiclesCollection = db.collection(vehiclesCollectionName);
  //         final vehicle = await vehiclesCollection
  //             .findOne(mongo.where.eq('_id', mongo.ObjectId.parse(trip['vehicle_id'])));
  //         trip['bus_number'] = vehicle?['BUSNO'] ?? 'N/A';
  //       }
  //     }

  //     await db.close();
  //     return trips; // Return the list of trip details
  //   } catch (e) {
  //     print('Error fetching trip details by PEN: $e');
  //     return null;
  //   }
  // }


}
