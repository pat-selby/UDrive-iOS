# UDrive Web App - Quick Guide

## ✅ Web Support Enabled!

Your Flutter app can now run in the browser! No Android Studio needed.

## 🚀 How to Run Web App

### Option 1: Simple Command
```powershell
C:\src\flutter\bin\flutter.bat run -d chrome
```

### Option 2: Use the Script
```powershell
.\run_web.ps1
```

### Option 3: After Restarting Terminal
```powershell
flutter run -d chrome
```

## 🌐 What Happens

1. Flutter builds the web version
2. Starts a local web server (usually on port 8080)
3. Opens Chrome automatically with your app
4. You'll see the UDrive app running in the browser!

## 📱 Testing the App

### Demo Login Credentials:
- **Student:** `student@test.com` (any password)
- **Driver:** `driver@test.com` (any password)

### Test Flow:
1. **Onboarding** - Swipe through 3 pages
2. **Login** - Use `student@test.com`
3. **Student Dashboard** - See all features
4. **Navigation** - Click buttons to navigate

## 🛠️ Available Web Browsers

You can run on:
- Chrome: `flutter run -d chrome`
- Edge: `flutter run -d edge`
- Windows Desktop: `flutter run -d windows`

## 📝 Web-Specific Notes

- **Hot Reload:** Works! Press `r` in terminal
- **Hot Restart:** Press `R` in terminal
- **Stop:** Press `q` in terminal
- **URL:** Usually `http://localhost:8080`

## 🎨 What You'll See

The app looks and works exactly like the mobile version:
- Same screens
- Same navigation
- Same functionality
- Responsive design (works on any screen size)

## ⚡ Quick Commands

```powershell
# Run in Chrome
flutter run -d chrome

# Run in Edge
flutter run -d edge

# Build for web (production)
flutter build web

# The built files will be in: build/web/
```

## 🚀 Build for Production Web

To create a production web build:

```powershell
flutter build web
```

Then you can:
- Deploy `build/web/` folder to any web server
- Host on GitHub Pages, Netlify, Firebase Hosting, etc.

## 🎯 Advantages of Web Version

✅ **No Android Studio needed**  
✅ **No emulator needed**  
✅ **Runs in any browser**  
✅ **Fast development cycle**  
✅ **Easy to share** (just send the URL)  
✅ **Works on any device with a browser**

## 🆘 Troubleshooting

### "Chrome not found"
- Install Google Chrome
- Or use Edge: `flutter run -d edge`

### Port already in use
```powershell
flutter run -d chrome --web-port=8081
```

### Build errors
```powershell
flutter clean
flutter pub get
flutter run -d chrome
```

## 📦 Deploy Web App

### Option 1: GitHub Pages
1. Build: `flutter build web`
2. Copy `build/web/` to `docs/` folder
3. Push to GitHub
4. Enable GitHub Pages in repo settings

### Option 2: Netlify
1. Build: `flutter build web`
2. Drag `build/web/` folder to Netlify
3. Done!

### Option 3: Firebase Hosting
1. Install Firebase CLI
2. `firebase init hosting`
3. `flutter build web`
4. `firebase deploy`

## 🎉 Enjoy!

You can now see and test your app in the browser without any mobile setup!

