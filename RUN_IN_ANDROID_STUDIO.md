# 🚀 How to Run UDrive App in Android Studio

## Step-by-Step Guide

### Step 1: Open Project in Android Studio

1. **Open Android Studio**
2. **Click:** "Open" or "File → Open"
3. **Navigate to:** `C:\Users\patri\OneDrive\Documents\UDrive`
4. **Select the folder** and click "OK"
5. **Wait** for Android Studio to index the project (may take 1-2 minutes)

### Step 2: Install Flutter Plugin (If Needed)

1. **File → Settings** (or `Ctrl + Alt + S`)
2. **Plugins** → Search for "Flutter"
3. **Install** "Flutter" plugin (this also installs Dart plugin)
4. **Restart** Android Studio when prompted

### Step 3: Start Android Emulator

1. **Click:** Tools → Device Manager (top menu)
   - OR click the **device icon** in the toolbar
2. **Find your emulator** in the list (e.g., "Medium Phone API 36.1")
3. **Click the ▶️ Play button** next to it
4. **Wait** for emulator to start (30-60 seconds)
   - You'll see the Android home screen when ready

### Step 4: Run the App

**Option A: Using Run Button (Easiest)**
1. **Look at the top toolbar** in Android Studio
2. **Find the device dropdown** (should show your emulator name)
3. **Click the green ▶️ Run button** (or press `Shift + F10`)
4. **Wait** for build to complete (2-3 minutes first time)
5. **App launches automatically!**

**Option B: Using Run Menu**
1. **Click:** Run → Run 'main.dart'
2. **Or press:** `Shift + F10`
3. **Select device** if prompted (choose your emulator)
4. **Wait** for build and launch

**Option C: Right-Click Method**
1. **Open:** `lib/main.dart` in the editor
2. **Right-click** anywhere in the file
3. **Click:** "Run 'main.dart'"
4. **Select device** if prompted

### Step 5: Enjoy the App! 🎉

The app will:
- Build automatically
- Install on emulator
- Launch with GSU branding
- Show all animations and features

## Hot Reload (While App is Running)

- **Click the 🔄 Hot Reload button** in the toolbar
- **Or press:** `Ctrl + \` (backslash)
- Changes apply instantly!

## Hot Restart

- **Click the 🔄 Restart button** (next to Hot Reload)
- **Or press:** `Ctrl + Shift + \`
- Restarts the app with changes

## Stop the App

- **Click the ⏹️ Stop button** in the toolbar
- **Or press:** `Ctrl + F2`

## Troubleshooting

### "No Flutter SDK found"
1. **File → Settings → Languages & Frameworks → Flutter**
2. **Set Flutter SDK path:** `C:\src\flutter`
3. **Click OK**

### "No devices found"
- Make sure emulator is running (Android home screen visible)
- Check: **Tools → Device Manager** → Start emulator

### Build Errors
1. **File → Invalidate Caches → Invalidate and Restart**
2. **Build → Clean Project**
3. **Build → Rebuild Project**

### Gradle Sync Issues
- **File → Sync Project with Gradle Files**
- Wait for sync to complete

## Quick Reference

| Action | Shortcut |
|--------|----------|
| Run App | `Shift + F10` |
| Hot Reload | `Ctrl + \` |
| Hot Restart | `Ctrl + Shift + \` |
| Stop App | `Ctrl + F2` |
| Debug | `Shift + F9` |

## What You'll See

1. **Build Progress** - Bottom status bar shows build progress
2. **Run Tab** - Shows app logs and output
3. **Emulator** - App launches automatically
4. **GSU Branding** - Black and Gold theme throughout

## Tips

- **First build takes 2-3 minutes** (normal!)
- **Subsequent builds are faster** (30-60 seconds)
- **Hot reload is instant** - Make changes and see them immediately
- **Check Run tab** for any errors or logs

## 🎯 Summary

1. ✅ Open project in Android Studio
2. ✅ Start emulator (Tools → Device Manager)
3. ✅ Click Run button (▶️) or press `Shift + F10`
4. ✅ App launches automatically!

That's it! The easiest way to run your app! 🚀

