# UDrive - Run App Script

Write-Host "=== UDrive - Running App ===" -ForegroundColor Cyan
Write-Host ""

# Check Flutter
try {
    flutter --version | Out-Null
} catch {
    Write-Host "✗ Flutter is not installed or not in PATH" -ForegroundColor Red
    Write-Host "Please run install_flutter.ps1 first" -ForegroundColor Yellow
    exit 1
}

# Check dependencies
if (-not (Test-Path "pubspec.lock")) {
    Write-Host "Getting dependencies..." -ForegroundColor Yellow
    flutter pub get
}

# Check for devices
Write-Host "Checking for devices..." -ForegroundColor Green
$devices = flutter devices
Write-Host $devices

$deviceCount = ($devices | Select-String "•" | Measure-Object).Count
if ($deviceCount -eq 0) {
    Write-Host ""
    Write-Host "⚠ No devices found!" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Please:" -ForegroundColor Yellow
    Write-Host "1. Start Android emulator from Android Studio" -ForegroundColor White
    Write-Host "   OR" -ForegroundColor White
    Write-Host "2. Connect Android device with USB debugging enabled" -ForegroundColor White
    Write-Host ""
    Write-Host "Then run this script again." -ForegroundColor Yellow
    exit 1
}

Write-Host ""
Write-Host "Starting app..." -ForegroundColor Green
Write-Host "Press 'r' for hot reload, 'R' for hot restart, 'q' to quit" -ForegroundColor Cyan
Write-Host ""

# Run the app
flutter run

