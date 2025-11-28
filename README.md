# UDrive iOS App

A SwiftUI-based ride-sharing application for students and drivers.

## Features

- **Onboarding**: Welcome screens for new users
- **Authentication**: Login and signup flows
- **Student Dashboard**: Book rides, view active/recent rides, emergency requests
- **Driver Dashboard**: Accept rides, manage active rides, go online/offline
- **Book Ride**: Request a ride with pickup and dropoff locations
- **Track Shuttle**: Real-time map tracking using MapKit
- **Driver Registration**: Complete driver onboarding with vehicle and photo uploads
- **Emergency Ride Request**: Priority ride requests for urgent situations

## Architecture

- **MVVM Pattern**: ViewModels handle business logic, Views are presentation-only
- **Services**: MockDataService for demo data, NavigationService for app navigation
- **Models**: User, Ride, Vehicle, Location data structures

## Project Structure

```
UDrive/
├── UDriveApp.swift          # Main app entry point
├── Models/                  # Data models
│   ├── User.swift
│   ├── Ride.swift
│   └── Vehicle.swift
├── Views/                   # SwiftUI views
│   ├── ContentView.swift
│   ├── OnboardingView.swift
│   ├── LoginView.swift
│   ├── SignupChoiceView.swift
│   ├── StudentDashboardView.swift
│   ├── DriverDashboardView.swift
│   ├── BookRideView.swift
│   ├── TrackShuttleMapView.swift
│   ├── DriverRegistrationView.swift
│   └── EmergencyRideRequestView.swift
├── ViewModels/              # View models
│   ├── OnboardingViewModel.swift
│   ├── LoginViewModel.swift
│   ├── SignupViewModel.swift
│   ├── StudentDashboardViewModel.swift
│   ├── DriverDashboardViewModel.swift
│   ├── BookRideViewModel.swift
│   ├── TrackShuttleViewModel.swift
│   └── DriverRegistrationViewModel.swift
├── Services/                # Business logic services
│   ├── NavigationService.swift
│   └── MockDataService.swift
└── Utils/                   # Utilities
    └── Extensions.swift
```

## Demo Credentials

For testing the login:
- **Student**: Use any email containing "student" (e.g., `student@test.com`)
- **Driver**: Use any email containing "driver" (e.g., `driver@test.com`)
- Password: Any (not validated in mock version)

## Requirements

- iOS 15.0+
- Xcode 14.0+
- Swift 5.7+

## Setup

1. Open the project in Xcode
2. Build and run on simulator or device
3. The app uses mock data, so no backend setup is required

## CI/CD Setup

The project includes a `codemagic.yaml` configuration file for automated builds with CodeMagic CI/CD.

### CodeMagic Configuration

Before using CodeMagic:

1. **Update `codemagic.yaml`**:
   - Set `XCODE_PROJECT` to your actual project file name
   - Set `XCODE_SCHEME` to your scheme name
   - Set `APP_ID` to your bundle identifier
   - Update email in the publishing section

2. **Update `export_options.plist`**:
   - Set `YOUR_TEAM_ID` to your Apple Developer Team ID
   - Adjust signing method if needed (development/ad-hoc/app-store/enterprise)

3. **Code Signing** (Optional):
   - For App Store distribution, set up App Store Connect API key in CodeMagic
   - Add certificates and provisioning profiles in CodeMagic dashboard
   - Uncomment the `app_store_connect` section in `codemagic.yaml`

### Building Locally

To build the project locally:
```bash
xcodebuild -project UDrive.xcodeproj -scheme UDrive -sdk iphoneos -configuration Release
```

## Notes

- All data is mock/demo data
- MapKit is used for the tracking screen
- Photo uploads use UIImagePickerController
- Navigation is handled through NavigationService

