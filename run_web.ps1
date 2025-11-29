# UDrive - Run Web App Script

Write-Host "=== UDrive - Running Web App ===" -ForegroundColor Cyan
Write-Host ""

# Check Flutter
try {
    $flutterPath = "C:\src\flutter\bin\flutter.bat"
    if (-not (Test-Path $flutterPath)) {
        Write-Host "✗ Flutter not found at $flutterPath" -ForegroundColor Red
        exit 1
    }
} catch {
    Write-Host "✗ Flutter is not installed" -ForegroundColor Red
    exit 1
}

# Enable web support
Write-Host "Enabling web support..." -ForegroundColor Green
& $flutterPath config --enable-web

# Get dependencies
Write-Host "Checking dependencies..." -ForegroundColor Green
& $flutterPath pub get

# Run web app
Write-Host ""
Write-Host "Starting web app..." -ForegroundColor Green
Write-Host "The app will open in your default browser" -ForegroundColor Cyan
Write-Host "Press Ctrl+C to stop the server" -ForegroundColor Yellow
Write-Host ""

& $flutterPath run -d chrome --web-port=8080

