# UDrive - Setup and Testing Guide

## Prerequisites

### For Android (Windows/Linux/Mac)
- Flutter SDK
- Android Studio
- Android SDK
- Android Emulator or Physical Device

### For iOS (Mac only)
- Flutter SDK
- Xcode
- iOS Simulator or Physical Device
- CocoaPods

## Step 1: Install Flutter

### Windows
1. Download Flutter SDK from: https://docs.flutter.dev/get-started/install/windows
2. Extract the zip file to a location (e.g., `C:\src\flutter`)
3. Add Flutter to your PATH:
   - Search for "Environment Variables" in Windows
   - Edit "Path" variable
   - Add: `C:\src\flutter\bin`
4. Verify installation:
   ```bash
   flutter doctor
   ```

### Mac
1. Download Flutter SDK from: https://docs.flutter.dev/get-started/install/macos
2. Extract and add to PATH:
   ```bash
   export PATH="$PATH:`pwd`/flutter/bin"
   ```
3. Verify installation:
   ```bash
   flutter doctor
   ```

## Step 2: Install Android Studio (for Android)

1. Download from: https://developer.android.com/studio
2. Install Android Studio
3. Open Android Studio → Configure → SDK Manager
4. Install:
   - Android SDK Platform-Tools
   - Android SDK Build-Tools
   - Android SDK (API 21 or higher)
5. Create an Android Virtual Device (AVD):
   - Tools → Device Manager → Create Device
   - Choose a device (e.g., Pixel 5)
   - Download a system image (e.g., Android 11)
   - Finish

## Step 3: Install Xcode (for iOS - Mac only)

1. Install Xcode from Mac App Store
2. Open Xcode and accept license
3. Install CocoaPods:
   ```bash
   sudo gem install cocoapods
   ```

## Step 4: Clone and Setup Project

```bash
# If not already cloned
git clone https://github.com/pat-selby/UDrive-iOS.git
cd UDrive-iOS

# Get Flutter dependencies
flutter pub get

# For iOS (Mac only)
cd ios
pod install
cd ..
```

## Step 5: Run the App

### On Android Emulator/Device

1. **Start Android Emulator:**
   - Open Android Studio
   - Tools → Device Manager
   - Click Play button on your AVD

2. **Or connect physical Android device:**
   - Enable Developer Options on your phone
   - Enable USB Debugging
   - Connect via USB

3. **Run the app:**
   ```bash
   flutter run
   ```

### On iOS Simulator/Device (Mac only)

1. **Start iOS Simulator:**
   ```bash
   open -a Simulator
   ```

2. **Run the app:**
   ```bash
   flutter run
   ```

## Step 6: Testing the App

### Demo Credentials

**Student Login:**
- Email: `student@test.com` (or any email containing "student")
- Password: Any (not validated)

**Driver Login:**
- Email: `driver@test.com` (or any email containing "driver")
- Password: Any (not validated)

### Test Flow

1. **Onboarding:**
   - Swipe through 3 onboarding pages
   - Click "Get Started" or "Already have an account? Login"

2. **Login:**
   - Enter `student@test.com` → Goes to Student Dashboard
   - Enter `driver@test.com` → Goes to Driver Dashboard

3. **Student Dashboard:**
   - Click "Book Ride" → Enter pickup/dropoff locations
   - Click "Emergency" → Request emergency ride
   - View active/recent rides

4. **Driver Dashboard:**
   - Toggle "Go Online"
   - View available rides
   - Accept rides
   - View active rides

5. **Driver Registration:**
   - Sign Up → Choose Driver
   - Fill in personal and vehicle information
   - Upload photos (mock for now)

## Step 7: Build for Production

### Android APK
```bash
flutter build apk --release
```
Output: `build/app/outputs/flutter-apk/app-release.apk`

### Android App Bundle (for Play Store)
```bash
flutter build appbundle --release
```
Output: `build/app/outputs/bundle/release/app-release.aab`

### iOS IPA (Mac only)
```bash
flutter build ipa --release
```
Output: `build/ios/ipa/`

## Troubleshooting

### Flutter Doctor Issues

```bash
# Check what's missing
flutter doctor -v

# Common fixes:
# - Install Android Studio and SDK
# - Install Xcode (Mac)
# - Accept Android licenses: flutter doctor --android-licenses
```

### Android Issues

**"No devices found":**
- Start Android Emulator first
- Or connect physical device with USB debugging enabled

**Build errors:**
```bash
flutter clean
flutter pub get
flutter run
```

### iOS Issues (Mac)

**CocoaPods errors:**
```bash
cd ios
pod deintegrate
pod install
cd ..
```

**Xcode errors:**
- Open `ios/Runner.xcworkspace` in Xcode
- Select a development team in Signing & Capabilities
- Build from Xcode first, then use `flutter run`

### Dependencies Issues

```bash
# Clear cache and reinstall
flutter clean
flutter pub cache repair
flutter pub get
```

## Development Tips

### Hot Reload
- Press `r` in terminal while app is running
- Or click the reload button in VS Code/Android Studio

### Hot Restart
- Press `R` in terminal (capital R)
- Or click the restart button

### Debug Mode
- App runs in debug mode by default
- Use `flutter run --release` for release mode

### View Logs
```bash
flutter logs
```

## VS Code Setup (Optional)

1. Install Flutter extension
2. Install Dart extension
3. Open project folder
4. Press F5 to run/debug

## Android Studio Setup (Optional)

1. Install Flutter plugin
2. Install Dart plugin
3. Open project folder
4. Click Run button

## Next Steps

1. **Add Google Maps:**
   - Get API key from Google Cloud Console
   - Add to `android/app/src/main/AndroidManifest.xml`
   - Update `lib/screens/track_shuttle_map_screen.dart`

2. **Add Real Backend:**
   - Replace `MockDataService` with API calls
   - Add authentication service
   - Add real-time location tracking

3. **Customize UI:**
   - Update colors in `lib/main.dart` theme
   - Add custom fonts
   - Improve animations

4. **Add Tests:**
   - Unit tests for ViewModels
   - Widget tests for screens
   - Integration tests

## Quick Start (TL;DR)

```bash
# 1. Install Flutter
# 2. Install Android Studio
# 3. Create Android Emulator
# 4. Run:
git clone https://github.com/pat-selby/UDrive-iOS.git
cd UDrive-iOS
flutter pub get
flutter run
```

## Need Help?

- Flutter Docs: https://docs.flutter.dev
- Flutter Community: https://flutter.dev/community
- Stack Overflow: Tag `flutter`

