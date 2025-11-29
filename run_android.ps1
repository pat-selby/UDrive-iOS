# UDrive - Run on Android Script

Write-Host "=== UDrive - Running on Android ===" -ForegroundColor Cyan
Write-Host ""

$flutterPath = "C:\src\flutter\bin\flutter.bat"

# Check Flutter
if (-not (Test-Path $flutterPath)) {
    Write-Host "✗ Flutter not found" -ForegroundColor Red
    exit 1
}

# Check for devices
Write-Host "Checking for Android devices..." -ForegroundColor Green
$devices = & $flutterPath devices 2>&1
Write-Host $devices

$androidDevice = $devices | Select-String -Pattern "android" -CaseSensitive:$false
if (-not $androidDevice) {
    Write-Host ""
    Write-Host "⚠ No Android device found!" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Please:" -ForegroundColor Yellow
    Write-Host "1. Start Android emulator from Android Studio" -ForegroundColor White
    Write-Host "   Tools → Device Manager → Click Play button" -ForegroundColor White
    Write-Host "2. OR connect Android phone with USB debugging" -ForegroundColor White
    Write-Host ""
    Write-Host "Then run this script again." -ForegroundColor Yellow
    exit 1
}

Write-Host ""
Write-Host "Starting app on Android..." -ForegroundColor Green
Write-Host "First build may take 2-3 minutes..." -ForegroundColor Yellow
Write-Host "Press 'r' for hot reload, 'R' for hot restart, 'q' to quit" -ForegroundColor Cyan
Write-Host ""

# Run the app
& $flutterPath run

