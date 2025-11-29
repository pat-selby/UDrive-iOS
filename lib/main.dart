import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/navigation_service.dart';
import 'screens/onboarding_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_choice_screen.dart';
import 'screens/student_dashboard_screen.dart';
import 'screens/driver_dashboard_screen.dart';
import 'screens/book_ride_screen.dart';
import 'screens/track_shuttle_map_screen.dart';
import 'screens/driver_registration_screen.dart';
import 'screens/emergency_ride_request_screen.dart';

void main() {
  runApp(const UDriveApp());
}

class UDriveApp extends StatelessWidget {
  const UDriveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NavigationService(),
      child: MaterialApp(
        title: 'UDrive',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
        ),
        home: const ContentView(),
      ),
    );
  }
}

class ContentView extends StatelessWidget {
  const ContentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationService>(
      builder: (context, navigationService, _) {
        switch (navigationService.currentScreen) {
          case AppScreen.onboarding:
            return const OnboardingScreen();
          case AppScreen.login:
            return const LoginScreen();
          case AppScreen.signupChoice:
            return const SignupChoiceScreen();
          case AppScreen.studentDashboard:
            return const StudentDashboardScreen();
          case AppScreen.driverDashboard:
            return const DriverDashboardScreen();
          case AppScreen.bookRide:
            return const BookRideScreen();
          case AppScreen.trackShuttle:
            return const TrackShuttleMapScreen();
          case AppScreen.driverRegistration:
            return const DriverRegistrationScreen();
          case AppScreen.emergencyRide:
            return const EmergencyRideRequestScreen();
        }
      },
    );
  }
}

