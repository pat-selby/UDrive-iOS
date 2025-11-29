import 'package:flutter/foundation.dart';
import '../models/ride.dart';
import '../models/location.dart';

class TrackShuttleViewModel extends ChangeNotifier {
  Ride? _ride;

  Ride? get ride => _ride;

  void loadMockRide() {
    _ride = Ride(
      id: '1',
      studentId: '1',
      driverId: '2',
      pickupLocation: Location(
        latitude: 37.7749,
        longitude: -122.4194,
        address: '123 Main St',
      ),
      dropoffLocation: Location(
        latitude: 37.7849,
        longitude: -122.4094,
        address: '456 Oak Ave',
      ),
      status: RideStatus.inProgress,
    );
    notifyListeners();
  }
}

