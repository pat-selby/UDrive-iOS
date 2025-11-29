# Automated Setup Guide

I've created PowerShell scripts to automate the setup process. Here's what you need to do:

## What the Scripts Do For You

✅ Check if Flutter is installed  
✅ Download Flutter SDK automatically  
✅ Add Flutter to PATH  
✅ Install project dependencies  
✅ Check for devices  
✅ Run the app  

## What You Still Need to Do Manually

1. **Download Android Studio** (one-time)
2. **Create Android Emulator** (one-time)
3. **Accept licenses** (one-time)

## Quick Start

### Step 1: Install Flutter (Automated)

Open PowerShell as Administrator and run:

```powershell
cd C:\Users\patri\OneDrive\Documents\UDrive
.\install_flutter.ps1
```

**What this does:**
- Checks if Flutter is installed
- Downloads Flutter SDK automatically
- Adds Flutter to your PATH
- Verifies installation

**What you need to do:**
- Run PowerShell as Administrator (Right-click → Run as Administrator)
- Restart terminal when prompted

### Step 2: Install Android Studio (Manual - Required)

1. Download: https://developer.android.com/studio
2. Install Android Studio
3. Open Android Studio → Standard Installation
4. Wait for SDK download to complete

### Step 3: Create Android Emulator (Manual - Required)

1. In Android Studio: **Tools → Device Manager**
2. Click **"Create Device"**
3. Choose **"Phone" → "Pixel 5"**
4. Click **"Next"**
5. Download a system image (e.g., "Tiramisu" API 33)
6. Click **"Finish"**
7. Click the **▶️ Play button** to start emulator

### Step 4: Setup Project (Automated)

```powershell
.\setup_project.ps1
```

**What this does:**
- Gets all Flutter dependencies
- Runs flutter doctor
- Checks for available devices

### Step 5: Run the App (Automated)

```powershell
.\run_app.ps1
```

**What this does:**
- Checks for devices
- Starts the app automatically
- Shows hot reload instructions

## Alternative: All-in-One

If you want to do everything at once:

```powershell
# 1. Install Flutter
.\install_flutter.ps1

# 2. (Manual) Install Android Studio and create emulator

# 3. Setup and run
.\setup_project.ps1
.\run_app.ps1
```

## Troubleshooting

### Script won't run
```powershell
# Allow scripts to run (one-time)
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### Flutter not found after installation
- **Restart your terminal** (PATH changes require restart)
- Or run: `refreshenv` (if Chocolatey is installed)

### No devices found
- Make sure Android emulator is running
- Or connect Android device with USB debugging

## Manual Steps Summary

You only need to do these 3 things manually:

1. ✅ **Install Android Studio** - Download and install
2. ✅ **Create Emulator** - In Android Studio Device Manager
3. ✅ **Start Emulator** - Click play button

Everything else is automated!

## After Setup

Once everything is set up, you can just run:

```powershell
.\run_app.ps1
```

And the app will start automatically!

