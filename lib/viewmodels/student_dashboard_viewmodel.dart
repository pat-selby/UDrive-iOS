import 'package:flutter/foundation.dart';
import '../services/mock_data_service.dart';
import '../models/ride.dart';

class StudentDashboardViewModel extends ChangeNotifier {
  final MockDataService _mockService = MockDataService();
  List<Ride> _activeRides = [];
  List<Ride> _recentRides = [];

  List<Ride> get activeRides => List.unmodifiable(_activeRides);
  List<Ride> get recentRides => List.unmodifiable(_recentRides);

  void loadRides(String userId) {
    _activeRides = _mockService.getActiveRides(userId);
    _recentRides = _mockService.rides
        .where((ride) =>
            ride.studentId == userId && ride.status == RideStatus.completed)
        .toList();
    notifyListeners();
  }
}

