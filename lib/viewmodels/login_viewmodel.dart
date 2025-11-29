import 'package:flutter/foundation.dart';
import '../models/user.dart';

class LoginViewModel extends ChangeNotifier {
  String _email = '';
  String _password = '';
  bool _isLoading = false;
  String? _errorMessage;

  String get email => _email;
  String get password => _password;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  set email(String value) {
    _email = value;
    _errorMessage = null;
    notifyListeners();
  }

  set password(String value) {
    _password = value;
    _errorMessage = null;
    notifyListeners();
  }

  Future<User?> login() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    _isLoading = false;

    // Mock login logic
    if (_email.toLowerCase().contains('student')) {
      final user = User(
        id: '1',
        name: 'John Student',
        email: _email,
        userType: UserType.student,
      );
      notifyListeners();
      return user;
    } else if (_email.toLowerCase().contains('driver')) {
      final user = User(
        id: '2',
        name: 'Sarah Driver',
        email: _email,
        userType: UserType.driver,
      );
      notifyListeners();
      return user;
    } else {
      _errorMessage = 'Invalid credentials. Try \'student@test.com\' or \'driver@test.com\'';
      notifyListeners();
      return null;
    }
  }
}

