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
    // GSU Students
    _users.addAll([
      User(
        id: '1',
        name: 'Marcus Johnson',
        email: 'mjohnson@gram.edu',
        userType: UserType.student,
        phoneNumber: '(318) 555-0101',
      ),
      User(
        id: '2',
        name: 'Keisha Williams',
        email: 'kwilliams@gram.edu',
        userType: UserType.student,
        phoneNumber: '(318) 555-0102',
      ),
      User(
        id: '3',
        name: 'David Thompson',
        email: 'dthompson@gram.edu',
        userType: UserType.student,
        phoneNumber: '(318) 555-0103',
      ),
    ]);

    // GSU Drivers (Students who also drive)
    _users.addAll([
      User(
        id: '4',
        name: 'James Wilson',
        email: 'jwilson@gram.edu',
        userType: UserType.driver,
        phoneNumber: '(318) 555-0201',
      ),
      User(
        id: '5',
        name: 'Sarah Davis',
        email: 'sdavis@gram.edu',
        userType: UserType.driver,
        phoneNumber: '(318) 555-0202',
      ),
    ]);

    // Vehicles (GSU student drivers)
    _vehicles.addAll([
      Vehicle(
        id: '1',
        make: 'Toyota',
        model: 'Camry',
        year: 2022,
        color: 'Black',
        licensePlate: 'GSU-2024',
        capacity: 4,
      ),
      Vehicle(
        id: '2',
        make: 'Honda',
        model: 'Accord',
        year: 2021,
        color: 'Gold',
        licensePlate: 'TIGER-1',
        capacity: 5,
      ),
      Vehicle(
        id: '3',
        make: 'Nissan',
        model: 'Altima',
        year: 2023,
        color: 'Black',
        licensePlate: 'GSU-TGR',
        capacity: 4,
      ),
    ]);

    // GSU Campus Locations
    final gsuMainCampus = Location(
      latitude: 32.5274,
      longitude: -92.7144,
      address: '403 Main Street, Grambling, LA 71245',
    );

    final studentHousing = Location(
      latitude: 32.5280,
      longitude: -92.7150,
      address: 'GSU Student Housing, Grambling, LA',
    );

    final library = Location(
      latitude: 32.5268,
      longitude: -92.7140,
      address: 'A.C. Lewis Memorial Library, GSU Campus',
    );

    final stadium = Location(
      latitude: 32.5290,
      longitude: -92.7160,
      address: 'Eddie G. Robinson Memorial Stadium, GSU',
    );

    final diningHall = Location(
      latitude: 32.5270,
      longitude: -92.7145,
      address: 'GSU Dining Hall, Main Campus',
    );

    final healthCenter = Location(
      latitude: 32.5265,
      longitude: -92.7135,
      address: 'GSU Health Center, Campus',
    );

    // Active rides on GSU campus
    _rides.addAll([
      Ride(
        id: '1',
        studentId: _users[0].id,
        driverId: _users[3].id,
        pickupLocation: studentHousing,
        dropoffLocation: library,
        status: RideStatus.inProgress,
        isEmergency: false,
      ),
      Ride(
        id: '2',
        studentId: _users[1].id,
        pickupLocation: diningHall,
        dropoffLocation: stadium,
        status: RideStatus.requested,
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

  // GSU Campus locations for quick selection
  static List<Location> getGSUCampusLocations() {
    return [
      Location(
        latitude: 32.5274,
        longitude: -92.7144,
        address: 'GSU Main Campus, 403 Main Street',
      ),
      Location(
        latitude: 32.5280,
        longitude: -92.7150,
        address: 'Student Housing Complex',
      ),
      Location(
        latitude: 32.5268,
        longitude: -92.7140,
        address: 'A.C. Lewis Memorial Library',
      ),
      Location(
        latitude: 32.5290,
        longitude: -92.7160,
        address: 'Eddie G. Robinson Memorial Stadium',
      ),
      Location(
        latitude: 32.5270,
        longitude: -92.7145,
        address: 'GSU Dining Hall',
      ),
      Location(
        latitude: 32.5265,
        longitude: -92.7135,
        address: 'GSU Health Center',
      ),
      Location(
        latitude: 32.5285,
        longitude: -92.7155,
        address: 'GSU Student Union',
      ),
      Location(
        latitude: 32.5275,
        longitude: -92.7148,
        address: 'GSU Science Building',
      ),
    ];
  }
}
