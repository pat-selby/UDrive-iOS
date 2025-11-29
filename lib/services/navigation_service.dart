import 'package:flutter/foundation.dart';
import '../models/user.dart';

enum AppScreen {
  onboarding,
  login,
  signupChoice,
  studentDashboard,
  driverDashboard,
  bookRide,
  trackShuttle,
  driverRegistration,
  emergencyRide,
}

class NavigationService extends ChangeNotifier {
  AppScreen _currentScreen = AppScreen.onboarding;
  bool _isLoggedIn = false;
  User? _currentUser;

  AppScreen get currentScreen => _currentScreen;
  bool get isLoggedIn => _isLoggedIn;
  User? get currentUser => _currentUser;

  void navigate(AppScreen screen) {
    _currentScreen = screen;
    notifyListeners();
  }

  void login(User user) {
    _currentUser = user;
    _isLoggedIn = true;
    _currentScreen = user.userType == UserType.student
        ? AppScreen.studentDashboard
        : AppScreen.driverDashboard;
    notifyListeners();
  }

  void logout() {
    _currentUser = null;
    _isLoggedIn = false;
    _currentScreen = AppScreen.onboarding;
    notifyListeners();
  }
}

