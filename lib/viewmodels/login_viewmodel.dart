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

    // Mock login logic - GSU email format
    final emailLower = _email.toLowerCase();
    
    if (emailLower.contains('@gram.edu') || emailLower.contains('student')) {
      final user = User(
        id: '1',
        name: 'Marcus Johnson',
        email: _email,
        userType: UserType.student,
        phoneNumber: '(318) 555-0101',
      );
      notifyListeners();
      return user;
    } else if (emailLower.contains('driver') || emailLower.contains('@gram.edu')) {
      final user = User(
        id: '4',
        name: 'James Wilson',
        email: _email,
        userType: UserType.driver,
        phoneNumber: '(318) 555-0201',
      );
      notifyListeners();
      return user;
    } else {
      _errorMessage = 'Invalid GSU credentials. Use your @gram.edu email or try "student@gram.edu" / "driver@gram.edu"';
      notifyListeners();
      return null;
    }
  }
}
