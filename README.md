# UDrive - Cross-Platform Ride-Sharing App

A Flutter-based cross-platform ride-sharing application for students and drivers, available on both iOS and Android.

## Features

- **Onboarding**: Welcome screens for new users
- **Authentication**: Login and signup flows
- **Student Dashboard**: Book rides, view active/recent rides, emergency requests
- **Driver Dashboard**: Accept rides, manage active rides, go online/offline
- **Book Ride**: Request a ride with pickup and dropoff locations
- **Track Shuttle**: Real-time map tracking (Google Maps integration ready)
- **Driver Registration**: Complete driver onboarding with vehicle and photo uploads
- **Emergency Ride Request**: Priority ride requests for urgent situations

## Architecture

- **MVVM Pattern**: ViewModels handle business logic, Views are presentation-only
- **Provider**: State management using Flutter Provider package
- **Services**: MockDataService for demo data, NavigationService for app navigation
- **Models**: User, Ride, Vehicle, Location data structures

## Project Structure

```
UDrive/
├── lib/
│   ├── main.dart                    # App entry point
│   ├── models/                      # Data models
│   │   ├── user.dart
│   │   ├── ride.dart
│   │   ├── vehicle.dart
│   │   └── location.dart
│   ├── screens/                     # Flutter screens
│   │   ├── onboarding_screen.dart
│   │   ├── login_screen.dart
│   │   ├── signup_choice_screen.dart
│   │   ├── student_dashboard_screen.dart
│   │   ├── driver_dashboard_screen.dart
│   │   ├── book_ride_screen.dart
│   │   ├── track_shuttle_map_screen.dart
│   │   ├── driver_registration_screen.dart
│   │   └── emergency_ride_request_screen.dart
│   ├── viewmodels/                  # View models
│   │   ├── login_viewmodel.dart
│   │   ├── student_dashboard_viewmodel.dart
│   │   ├── driver_dashboard_viewmodel.dart
│   │   ├── book_ride_viewmodel.dart
│   │   ├── track_shuttle_viewmodel.dart
│   │   └── driver_registration_viewmodel.dart
│   └── services/                    # Business logic services
│       ├── navigation_service.dart
│       └── mock_data_service.dart
├── android/                         # Android configuration
├── ios/                             # iOS configuration (will be generated)
├── pubspec.yaml                     # Flutter dependencies
└── codemagic.yaml                   # CI/CD configuration

# Legacy iOS SwiftUI files (kept for reference)
├── Models/                          # Swift models
├── Views/                           # SwiftUI views
├── ViewModels/                      # Swift view models
└── Services/                        # Swift services
```

## Demo Credentials

For testing the login:
- **Student**: Use any email containing "student" (e.g., `student@test.com`)
- **Driver**: Use any email containing "driver" (e.g., `driver@test.com`)
- Password: Any (not validated in mock version)

## Requirements

- Flutter SDK 3.0.0 or higher
- Dart 3.0.0 or higher
- Android Studio / VS Code with Flutter extensions
- For iOS: Xcode 14.0+ (macOS only)
- For Android: Android SDK 21+

## Setup

### 1. Install Flutter

```bash
# Download Flutter from https://flutter.dev/docs/get-started/install
# Add Flutter to your PATH
```

### 2. Get Dependencies

```bash
flutter pub get
```

### 3. Run on Android

```bash
flutter run
```

### 4. Run on iOS (macOS only)

```bash
flutter run
```

## Building for Production

### Android APK
```bash
flutter build apk --release
```

### Android App Bundle (for Play Store)
```bash
flutter build appbundle --release
```

### iOS (macOS only)
```bash
flutter build ipa --release
```

## CI/CD Setup

The project includes CodeMagic configuration for automated builds of both iOS and Android.

### CodeMagic Workflow

The `codemagic.yaml` includes:
- **flutter-ios-android**: Builds both iOS and Android apps
- **ios-workflow**: Legacy iOS-only workflow for SwiftUI version

### Building Both Platforms

CodeMagic will automatically:
1. Install Flutter dependencies
2. Run tests and analysis
3. Build iOS IPA
4. Build Android APK and App Bundle
5. Publish artifacts

## Notes

- All data is mock/demo data
- Google Maps integration is ready (add API key in `android/app/src/main/AndroidManifest.xml` and `ios/Runner/AppDelegate.swift`)
- Photo uploads use image_picker package
- Navigation is handled through NavigationService
- The app uses Provider for state management

## Platform-Specific Notes

### Android
- Minimum SDK: 21 (Android 5.0)
- Permissions: Location, Camera, Storage

### iOS
- Minimum iOS: 15.0
- Permissions: Location, Camera, Photo Library

## Development

### Adding New Screens

1. Create screen in `lib/screens/`
2. Create ViewModel in `lib/viewmodels/`
3. Add route in `lib/services/navigation_service.dart`
4. Update `lib/main.dart` ContentView

### State Management

The app uses Provider pattern:
- ViewModels extend `ChangeNotifier`
- Screens use `Provider.of<T>()` or `Consumer<T>`
- Services can also extend `ChangeNotifier` for reactive updates
