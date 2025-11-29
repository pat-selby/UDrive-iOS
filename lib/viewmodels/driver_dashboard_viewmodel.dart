import 'package:flutter/foundation.dart';
import '../services/mock_data_service.dart';
import '../models/ride.dart';

class DriverDashboardViewModel extends ChangeNotifier {
  final MockDataService _mockService = MockDataService();
  List<Ride> _availableRides = [];
  List<Ride> _activeRides = [];
  bool _isOnline = false;

  List<Ride> get availableRides => List.unmodifiable(_availableRides);
  List<Ride> get activeRides => List.unmodifiable(_activeRides);
  bool get isOnline => _isOnline;

  void loadRides(String driverId) {
    _activeRides = _mockService.rides
        .where((ride) =>
            ride.driverId == driverId &&
            (ride.status == RideStatus.accepted ||
                ride.status == RideStatus.inProgress))
        .toList();
    _availableRides = _mockService.rides
        .where((ride) =>
            ride.status == RideStatus.requested && ride.driverId == null)
        .toList();
    notifyListeners();
  }

  void toggleOnlineStatus() {
    _isOnline = !_isOnline;
    notifyListeners();
  }

  void acceptRide(Ride ride) {
    // In real app, this would update the ride status
    loadRides('2'); // Mock driver ID
  }
}

