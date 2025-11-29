# Android Studio Setup - Quick Guide

## ✅ Android Studio Installed!

Now let's set up the Android emulator so you can run the app.

## Step 1: Open Android Studio

1. Launch Android Studio
2. If it's your first time, it will set up the Android SDK automatically
3. Wait for the setup to complete

## Step 2: Create Android Emulator

1. **In Android Studio:**
   - Click **Tools** → **Device Manager**
   - (Or click the device icon in the toolbar)

2. **Create Device:**
   - Click **"Create Device"** button
   - Choose **"Phone"** category
   - Select **"Pixel 5"** (or any phone you prefer)
   - Click **"Next"**

3. **Download System Image:**
   - Click **"Download"** next to a system image
   - Recommended: **"Tiramisu" (API 33)** or **"UpsideDownCake" (API 34)**
   - Wait for download to complete (~1-2 GB)
   - Click **"Next"**

4. **Finish Setup:**
   - Review settings (defaults are fine)
   - Click **"Finish"**

## Step 3: Start Emulator

1. In Device Manager, you'll see your device
2. Click the **▶️ Play button** next to your device
3. Wait for emulator to start (takes 30-60 seconds)
4. You'll see an Android phone screen

## Step 4: Run the App!

Once the emulator is running:

```powershell
C:\src\flutter\bin\flutter.bat run
```

Or use the script:
```powershell
.\run_app.ps1
```

## What You'll See

1. **Flutter will detect the emulator**
2. **Build the app** (first time takes 2-3 minutes)
3. **Install on emulator**
4. **App launches automatically!**

## Troubleshooting

### "No devices found"
- Make sure emulator is running
- Check: `flutter devices` (should show emulator)

### "Android SDK not found"
- Open Android Studio
- Go to: **File → Settings → Appearance & Behavior → System Settings → Android SDK**
- Make sure SDK is installed
- Run: `flutter doctor --android-licenses` and accept all

### Emulator is slow
- Close other apps
- Increase emulator RAM in AVD settings
- Use a lighter system image (API 30 instead of 33)

### Build errors
```powershell
flutter clean
flutter pub get
flutter run
```

## Quick Commands

```powershell
# Check devices
flutter devices

# Run app
flutter run

# Hot reload (while app running)
# Press 'r' in terminal

# Hot restart
# Press 'R' in terminal

# Stop app
# Press 'q' in terminal
```

## Alternative: Use Physical Android Phone

1. **Enable Developer Options:**
   - Go to Settings → About Phone
   - Tap "Build Number" 7 times

2. **Enable USB Debugging:**
   - Settings → Developer Options
   - Turn on "USB Debugging"

3. **Connect Phone:**
   - Connect via USB
   - Accept "Allow USB Debugging" prompt on phone

4. **Run:**
   ```powershell
   flutter run
   ```

## 🎯 Quick Start

1. Open Android Studio
2. Tools → Device Manager → Create Device
3. Start emulator (▶️ button)
4. Run: `C:\src\flutter\bin\flutter.bat run`

That's it! The app will launch on the emulator! 🚀

