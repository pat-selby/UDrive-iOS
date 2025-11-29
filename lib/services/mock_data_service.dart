import 'package:flutter/foundation.dart';
import '../models/user.dart';
import '../models/ride.dart';
import '../models/vehicle.dart';
import '../models/location.dart';

class MockDataService extends ChangeNotifier {
  static final MockDataService _instance = MockDataService._internal();
  factory MockDataService() => _instance;
  MockDataService._internal() {
    _loadMockData();
  }

  final List<User> _users = [];
  final List<Ride> _rides = [];
  final List<Vehicle> _vehicles = [];

  List<User> get users => List.unmodifiable(_users);
  List<Ride> get rides => List.unmodifiable(_rides);
  List<Vehicle> get vehicles => List.unmodifiable(_vehicles);

  void _loadMockData() {
    _users.addAll([
      User(
        id: '1',
        name: 'John Student',
        email: 'john@student.edu',
        userType: UserType.student,
        phoneNumber: '555-0101',
      ),
      User(
        id: '2',
        name: 'Sarah Driver',
        email: 'sarah@driver.com',
        userType: UserType.driver,
        phoneNumber: '555-0202',
      ),
    ]);

    _vehicles.addAll([
      Vehicle(
        id: '1',
        make: 'Toyota',
        model: 'Camry',
        year: 2022,
        color: 'Blue',
        licensePlate: 'ABC-1234',
        capacity: 4,
      ),
      Vehicle(
        id: '2',
        make: 'Honda',
        model: 'Accord',
        year: 2021,
        color: 'Red',
        licensePlate: 'XYZ-5678',
        capacity: 5,
      ),
    ]);

    _rides.addAll([
      Ride(
        id: '1',
        studentId: _users[0].id,
        driverId: _users[1].id,
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
        isEmergency: false,
      ),
    ]);
  }

  Ride createRide({
    required Location pickup,
    required Location dropoff,
    bool isEmergency = false,
  }) {
    final ride = Ride(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      studentId: '1', // In real app, use current user ID
      pickupLocation: pickup,
      dropoffLocation: dropoff,
      status: RideStatus.requested,
      isEmergency: isEmergency,
    );
    _rides.add(ride);
    notifyListeners();
    return ride;
  }

  List<Ride> getActiveRides(String userId) {
    return _rides.where((ride) {
      return (ride.studentId == userId || ride.driverId == userId) &&
          (ride.status == RideStatus.requested ||
              ride.status == RideStatus.accepted ||
              ride.status == RideStatus.inProgress);
    }).toList();
  }
}

