# UDrive - Android Studio Setup Script

Write-Host "=== UDrive - Android Studio Setup ===" -ForegroundColor Cyan
Write-Host ""

# Check Flutter
Write-Host "Checking Flutter installation..." -ForegroundColor Green
try {
    $flutterPath = "C:\src\flutter\bin\flutter.bat"
    if (-not (Test-Path $flutterPath)) {
        Write-Host "✗ Flutter not found" -ForegroundColor Red
        exit 1
    }
    Write-Host "✓ Flutter found" -ForegroundColor Green
} catch {
    Write-Host "✗ Flutter is not installed" -ForegroundColor Red
    exit 1
}

# Check Android Studio
Write-Host ""
Write-Host "Checking Android Studio setup..." -ForegroundColor Green
& $flutterPath doctor

Write-Host ""
Write-Host "=== Next Steps ===" -ForegroundColor Cyan
Write-Host ""
Write-Host "1. Open Android Studio" -ForegroundColor Yellow
Write-Host "2. Go to: Tools → Device Manager" -ForegroundColor Yellow
Write-Host "3. Click Create Device" -ForegroundColor Yellow
Write-Host "4. Choose Phone → Pixel 5" -ForegroundColor Yellow
Write-Host "5. Download a system image (e.g., Tiramisu API 33)" -ForegroundColor Yellow
Write-Host "6. Click Finish" -ForegroundColor Yellow
Write-Host "7. Click the Play button to start emulator" -ForegroundColor Yellow
Write-Host ""
Write-Host "Once emulator is running, execute:" -ForegroundColor Green
Write-Host "C:\src\flutter\bin\flutter.bat run" -ForegroundColor Cyan
Write-Host ""
