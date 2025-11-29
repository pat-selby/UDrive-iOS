# Quick Start - Run UDrive App

## Step 1: Install Flutter (5-10 minutes)

1. **Download Flutter:**
   - Go to: https://docs.flutter.dev/get-started/install/windows
   - Click "Download Flutter SDK"
   - Download the ZIP file (about 1.5 GB)

2. **Extract Flutter:**
   - Extract to `C:\src\flutter` (or any location without spaces)
   - **Important:** Don't extract to `C:\Program Files\` (has spaces)

3. **Add Flutter to PATH:**
   - Press `Win + X` → "System"
   - Click "Advanced system settings"
   - Click "Environment Variables"
   - Under "User variables", select "Path" → "Edit"
   - Click "New" → Add: `C:\src\flutter\bin` (or your path)
   - Click "OK" on all windows

4. **Restart PowerShell/Terminal:**
   - Close and reopen your terminal

5. **Verify Installation:**
   ```bash
   flutter doctor
   ```
   This will show what else you need (Android Studio, etc.)

## Step 2: Install Android Studio (15-20 minutes)

1. **Download Android Studio:**
   - Go to: https://developer.android.com/studio
   - Download and install

2. **First Launch Setup:**
   - Open Android Studio
   - Choose "Standard" installation
   - Let it download Android SDK components

3. **Create Android Emulator:**
   - In Android Studio: Tools → Device Manager
   - Click "Create Device"
   - Choose "Phone" → "Pixel 5" (or any phone)
   - Click "Next"
   - Download a system image (e.g., "Tiramisu" API 33)
   - Click "Finish"
   - Click the ▶️ Play button to start the emulator

## Step 3: Get Project Dependencies

```bash
# Navigate to your project
cd C:\Users\patri\OneDrive\Documents\UDrive

# Get Flutter packages
flutter pub get
```

## Step 4: Run the App

### Option A: Using Command Line

```bash
# Make sure Android emulator is running (from Android Studio)
# Then run:
flutter run
```

### Option B: Using VS Code (Easier)

1. **Install VS Code:**
   - Download: https://code.visualstudio.com/

2. **Install Flutter Extension:**
   - Open VS Code
   - Extensions (Ctrl+Shift+X)
   - Search "Flutter"
   - Install "Flutter" extension (by Dart Code)
   - Also install "Dart" extension

3. **Open Project:**
   - File → Open Folder → Select `UDrive` folder
   - Press `F5` or click "Run and Debug"
   - Select your Android emulator

## What You'll See

1. **Onboarding Screen:**
   - 3 pages with car icons
   - "Get Started" button

2. **Login Screen:**
   - Email and password fields
   - Try: `student@test.com` (any password)

3. **Student Dashboard:**
   - "Book Ride" and "Emergency" buttons
   - Active/Recent rides list

4. **Test Navigation:**
   - Click "Book Ride" → Enter locations
   - Click "Emergency" → Emergency ride request
   - Logout → Back to login

## Troubleshooting

### "flutter: command not found"
- Flutter not in PATH
- Restart terminal after adding to PATH
- Check: `echo $env:PATH` (should include flutter\bin)

### "No devices found"
- Start Android emulator first
- Check: `flutter devices` (should show emulator)

### Build Errors
```bash
flutter clean
flutter pub get
flutter run
```

### Android License Issues
```bash
flutter doctor --android-licenses
# Press 'y' to accept all licenses
```

## Quick Commands Reference

```bash
# Check Flutter installation
flutter doctor

# List available devices
flutter devices

# Run app
flutter run

# Hot reload (while app is running)
# Press 'r' in terminal

# Hot restart (while app is running)
# Press 'R' in terminal

# Stop app
# Press 'q' in terminal

# Build APK
flutter build apk --release
```

## Demo Credentials

- **Student:** `student@test.com` (any password)
- **Driver:** `driver@test.com` (any password)

## Need Help?

- Flutter Docs: https://docs.flutter.dev
- Flutter Issues: Check `flutter doctor` output
- Common Issues: See SETUP_GUIDE.md

