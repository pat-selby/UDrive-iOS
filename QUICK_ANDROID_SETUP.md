# 🚀 Quick Android Setup - Run UDrive App

## ✅ Android Studio is Installed!

Now you just need to create an emulator and run the app.

## Step 1: Complete Android Studio Setup (If Needed)

1. **Open Android Studio**
2. **If prompted:**
   - Let it download SDK components
   - Accept licenses
   - Wait for setup to complete

## Step 2: Create Android Emulator (5 minutes)

1. **In Android Studio:**
   - Click **Tools** → **Device Manager** (top menu)
   - Or click the **device icon** in the toolbar

2. **Create Device:**
   - Click **"Create Device"** button (top left)
   - **Category:** Select **"Phone"**
   - **Device:** Choose **"Pixel 5"** (or any phone)
   - Click **"Next"**

3. **Download System Image:**
   - You'll see a list of system images
   - Click **"Download"** next to one (recommended: **"Tiramisu" API 33**)
   - Wait for download (~1-2 GB, takes a few minutes)
   - Once downloaded, select it
   - Click **"Next"**

4. **Finish:**
   - Review settings (defaults are fine)
   - Click **"Finish"**

5. **Start Emulator:**
   - You'll see your device in the list
   - Click the **▶️ Play button** next to it
   - Wait 30-60 seconds for emulator to start
   - You'll see an Android phone screen!

## Step 3: Run the App! 🎉

Once the emulator is running (you see the Android home screen):

```powershell
C:\src\flutter\bin\flutter.bat run
```

**That's it!** The app will:
1. Build automatically
2. Install on emulator
3. Launch the UDrive app!

## What You'll See

- **Onboarding** with GSU branding
- **Login** screen (use `student@gram.edu`)
- **Student Dashboard** with GSU campus locations
- **All animations** and polished UI!

## Troubleshooting

### "No devices found"
- Make sure emulator is fully started (Android home screen visible)
- Run: `flutter devices` to check

### "Android SDK not found"
- Open Android Studio
- Let it complete setup
- Go to: **File → Settings → Android SDK**
- Make sure SDK is installed

### Emulator won't start
- Close Android Studio and reopen
- Try creating a different device (Pixel 4 instead of Pixel 5)
- Check if virtualization is enabled in BIOS (if needed)

### Build takes too long
- First build takes 2-3 minutes (normal!)
- Subsequent builds are faster

## Quick Commands

```powershell
# Check if emulator is running
flutter devices

# Run app
flutter run

# Hot reload (while app running)
# Press 'r' in terminal

# Stop app
# Press 'q' in terminal
```

## Alternative: Use Your Phone

If you have an Android phone:

1. **Enable Developer Options:**
   - Settings → About Phone
   - Tap "Build Number" 7 times

2. **Enable USB Debugging:**
   - Settings → Developer Options
   - Turn on "USB Debugging"

3. **Connect Phone:**
   - Connect via USB
   - Accept "Allow USB Debugging" on phone

4. **Run:**
   ```powershell
   flutter run
   ```

## 🎯 Summary

1. ✅ Android Studio installed
2. ⏳ Create emulator (Tools → Device Manager → Create Device)
3. ⏳ Start emulator (▶️ button)
4. ⏳ Run: `flutter run`

**The app will launch on Android!** 🚀

