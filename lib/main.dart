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
        title: 'UDrive - Grambling State University',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // Grambling State University Colors: Black and Gold
          primaryColor: const Color(0xFF000000), // Black
          primarySwatch: Colors.amber, // Gold/Amber
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFFFFD700), // Gold
            primary: const Color(0xFF000000), // Black
            secondary: const Color(0xFFFFD700), // Gold
            surface: Colors.white,
            onPrimary: Colors.white,
            onSecondary: Colors.black,
          ),
          useMaterial3: true,
          scaffoldBackgroundColor: Colors.grey[50],
          appBarTheme: AppBarTheme(
            backgroundColor: const Color(0xFF000000),
            foregroundColor: const Color(0xFFFFD700),
            elevation: 0,
            centerTitle: true,
            titleTextStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFFFFD700),
            ),
          ),
          cardTheme: CardTheme(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF000000),
              foregroundColor: const Color(0xFFFFD700),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 3,
            ),
          ),
          textTheme: const TextTheme(
            headlineLarge: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Color(0xFF000000),
            ),
            headlineMedium: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF000000),
            ),
            bodyLarge: TextStyle(
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
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
        Widget screen;
        switch (navigationService.currentScreen) {
          case AppScreen.onboarding:
            screen = const OnboardingScreen();
            break;
          case AppScreen.login:
            screen = const LoginScreen();
            break;
          case AppScreen.signupChoice:
            screen = const SignupChoiceScreen();
            break;
          case AppScreen.studentDashboard:
            screen = const StudentDashboardScreen();
            break;
          case AppScreen.driverDashboard:
            screen = const DriverDashboardScreen();
            break;
          case AppScreen.bookRide:
            screen = const BookRideScreen();
            break;
          case AppScreen.trackShuttle:
            screen = const TrackShuttleMapScreen();
            break;
          case AppScreen.driverRegistration:
            screen = const DriverRegistrationScreen();
            break;
          case AppScreen.emergencyRide:
            screen = const EmergencyRideRequestScreen();
            break;
        }

        // Add page transition animation
        return PageTransitionWrapper(
          child: screen,
          route: navigationService.currentScreen,
        );
      },
    );
  }
}

class PageTransitionWrapper extends StatelessWidget {
  final Widget child;
  final AppScreen route;

  const PageTransitionWrapper({
    super.key,
    required this.child,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.1, 0),
              end: Offset.zero,
            ).animate(CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutCubic,
            )),
            child: child,
          ),
        );
      },
      child: KeyedSubtree(
        key: ValueKey(route),
        child: child,
      ),
    );
  }
}
