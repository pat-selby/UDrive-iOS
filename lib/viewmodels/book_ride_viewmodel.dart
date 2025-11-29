import 'package:flutter/foundation.dart';
import '../services/mock_data_service.dart';
import '../models/ride.dart';
import '../models/location.dart';

class BookRideViewModel extends ChangeNotifier {
  final MockDataService _mockService = MockDataService();
  Location? _pickupLocation;
  Location? _dropoffLocation;
  String _pickupAddress = '';
  String _dropoffAddress = '';
  bool _isEmergency = false;
  bool _isLoading = false;
  String? _errorMessage;

  Location? get pickupLocation => _pickupLocation;
  Location? get dropoffLocation => _dropoffLocation;
  String get pickupAddress => _pickupAddress;
  String get dropoffAddress => _dropoffAddress;
  bool get isEmergency => _isEmergency;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  set isEmergency(bool value) {
    _isEmergency = value;
    notifyListeners();
  }

  void setPickupAddress(String address) {
    _pickupAddress = address;
    // Find matching GSU location
    final locations = MockDataService.getGSUCampusLocations();
    final location = locations.firstWhere(
      (loc) => loc.address == address,
      orElse: () => Location(
        latitude: 32.5274,
        longitude: -92.7144,
        address: address,
      ),
    );
    _pickupLocation = location;
    notifyListeners();
  }

  void setDropoffAddress(String address) {
    _dropoffAddress = address;
    // Find matching GSU location
    final locations = MockDataService.getGSUCampusLocations();
    final location = locations.firstWhere(
      (loc) => loc.address == address,
      orElse: () => Location(
        latitude: 32.5274,
        longitude: -92.7144,
        address: address,
      ),
    );
    _dropoffLocation = location;
    notifyListeners();
  }

  Future<Ride?> bookRide() async {
    if (_pickupLocation == null || _dropoffLocation == null) {
      _errorMessage = 'Please select both pickup and dropoff locations';
      notifyListeners();
      return null;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1));

    _isLoading = false;
    final ride = _mockService.createRide(
      pickup: _pickupLocation!,
      dropoff: _dropoffLocation!,
      isEmergency: _isEmergency,
    );
    notifyListeners();
    return ride;
  }
}
