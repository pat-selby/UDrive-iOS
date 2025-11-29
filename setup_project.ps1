# UDrive - Project Setup Script
# Run this after Flutter is installed

Write-Host "=== UDrive Project Setup ===" -ForegroundColor Cyan
Write-Host ""

# Check if Flutter is installed
Write-Host "Checking Flutter installation..." -ForegroundColor Green
try {
    $flutterVersion = flutter --version 2>&1
    if ($LASTEXITCODE -ne 0) {
        Write-Host "✗ Flutter is not installed or not in PATH" -ForegroundColor Red
        Write-Host "Please run install_flutter.ps1 first" -ForegroundColor Yellow
        exit 1
    }
    Write-Host "✓ Flutter is installed" -ForegroundColor Green
    flutter --version | Select-Object -First 1
} catch {
    Write-Host "✗ Flutter is not installed or not in PATH" -ForegroundColor Red
    Write-Host "Please run install_flutter.ps1 first" -ForegroundColor Yellow
    exit 1
}

# Get project directory
$projectDir = $PSScriptRoot
if (-not $projectDir) {
    $projectDir = Get-Location
}

Write-Host ""
Write-Host "Project directory: $projectDir" -ForegroundColor Cyan
Write-Host ""

# Step 1: Get Flutter dependencies
Write-Host "Step 1: Getting Flutter dependencies..." -ForegroundColor Green
Set-Location $projectDir
flutter pub get

if ($LASTEXITCODE -ne 0) {
    Write-Host "✗ Failed to get dependencies" -ForegroundColor Red
    exit 1
}
Write-Host "✓ Dependencies installed" -ForegroundColor Green

# Step 2: Check Flutter doctor
Write-Host ""
Write-Host "Step 2: Running Flutter doctor..." -ForegroundColor Green
flutter doctor

# Step 3: Check for devices
Write-Host ""
Write-Host "Step 3: Checking for available devices..." -ForegroundColor Green
flutter devices

Write-Host ""
Write-Host "=== Setup Complete ===" -ForegroundColor Cyan
Write-Host ""
Write-Host "To run the app:" -ForegroundColor Yellow
Write-Host "1. Start Android emulator (from Android Studio)" -ForegroundColor White
Write-Host "2. Or connect Android device with USB debugging" -ForegroundColor White
Write-Host "3. Run: flutter run" -ForegroundColor White
Write-Host ""

