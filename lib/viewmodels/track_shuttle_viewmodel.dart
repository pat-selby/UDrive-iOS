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
      driverId: '4',
      pickupLocation: Location(
        latitude: 32.5280,
        longitude: -92.7150,
        address: 'Student Housing Complex',
      ),
      dropoffLocation: Location(
        latitude: 32.5268,
        longitude: -92.7140,
        address: 'A.C. Lewis Memorial Library',
      ),
      status: RideStatus.inProgress,
    );
    notifyListeners();
  }
}
