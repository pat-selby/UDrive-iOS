import 'package:flutter/foundation.dart';

class DriverRegistrationViewModel extends ChangeNotifier {
  String _name = '';
  String _email = '';
  String _phoneNumber = '';
  String _licenseNumber = '';
  String _vehicleMake = '';
  String _vehicleModel = '';
  String _vehicleYear = '';
  String _vehicleColor = '';
  String _licensePlate = '';
  String _vehicleCapacity = '4';
  String? _driverPhoto;
  String? _vehiclePhoto;
  bool _isLoading = false;
  String? _errorMessage;

  String get name => _name;
  String get email => _email;
  String get phoneNumber => _phoneNumber;
  String get licenseNumber => _licenseNumber;
  String get vehicleMake => _vehicleMake;
  String get vehicleModel => _vehicleModel;
  String get vehicleYear => _vehicleYear;
  String get vehicleColor => _vehicleColor;
  String get licensePlate => _licensePlate;
  String get vehicleCapacity => _vehicleCapacity;
  String? get driverPhoto => _driverPhoto;
  String? get vehiclePhoto => _vehiclePhoto;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  set name(String value) {
    _name = value;
    notifyListeners();
  }

  set email(String value) {
    _email = value;
    notifyListeners();
  }

  set phoneNumber(String value) {
    _phoneNumber = value;
    notifyListeners();
  }

  set licenseNumber(String value) {
    _licenseNumber = value;
    notifyListeners();
  }

  set vehicleMake(String value) {
    _vehicleMake = value;
    notifyListeners();
  }

  set vehicleModel(String value) {
    _vehicleModel = value;
    notifyListeners();
  }

  set vehicleYear(String value) {
    _vehicleYear = value;
    notifyListeners();
  }

  set vehicleColor(String value) {
    _vehicleColor = value;
    notifyListeners();
  }

  set licensePlate(String value) {
    _licensePlate = value;
    notifyListeners();
  }

  set vehicleCapacity(String value) {
    _vehicleCapacity = value;
    notifyListeners();
  }

  set driverPhoto(String? value) {
    _driverPhoto = value;
    notifyListeners();
  }

  set vehiclePhoto(String? value) {
    _vehiclePhoto = value;
    notifyListeners();
  }

  Future<bool> registerDriver() async {
    if (_name.isEmpty ||
        _email.isEmpty ||
        _phoneNumber.isEmpty ||
        _licenseNumber.isEmpty ||
        _vehicleMake.isEmpty ||
        _vehicleModel.isEmpty ||
        _vehicleYear.isEmpty ||
        _vehicleColor.isEmpty ||
        _licensePlate.isEmpty) {
      _errorMessage = 'Please fill in all required fields';
      notifyListeners();
      return false;
    }

    if (_driverPhoto == null || _vehiclePhoto == null) {
      _errorMessage = 'Please upload both driver and vehicle photos';
      notifyListeners();
      return false;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));

    _isLoading = false;
    notifyListeners();
    return true;
  }
}

