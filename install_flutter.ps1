# UDrive - Flutter Installation Script
# Run this script as Administrator for best results

Write-Host "=== UDrive Flutter Installation Script ===" -ForegroundColor Cyan
Write-Host ""

# Check if running as admin
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $isAdmin) {
    Write-Host "Warning: Not running as Administrator. Some steps may require elevation." -ForegroundColor Yellow
    Write-Host ""
}

# Step 1: Check if Flutter is already installed
Write-Host "Step 1: Checking if Flutter is installed..." -ForegroundColor Green
try {
    $flutterVersion = flutter --version 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✓ Flutter is already installed!" -ForegroundColor Green
        flutter --version
        Write-Host ""
        Write-Host "Running flutter doctor..." -ForegroundColor Yellow
        flutter doctor
        exit 0
    }
} catch {
    Write-Host "✗ Flutter is not installed" -ForegroundColor Red
}

# Step 2: Check if Git is installed
Write-Host ""
Write-Host "Step 2: Checking if Git is installed..." -ForegroundColor Green
try {
    $gitVersion = git --version 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✓ Git is installed: $gitVersion" -ForegroundColor Green
    }
} catch {
    Write-Host "✗ Git is not installed" -ForegroundColor Red
    Write-Host "Please install Git from: https://git-scm.com/download/win" -ForegroundColor Yellow
    Write-Host "Or we can install it using winget (if available)..." -ForegroundColor Yellow
    
    # Try to install Git using winget
    try {
        winget install --id Git.Git -e --source winget
        Write-Host "✓ Git installation started" -ForegroundColor Green
    } catch {
        Write-Host "Please install Git manually and run this script again" -ForegroundColor Red
        exit 1
    }
}

# Step 3: Set Flutter installation path
$flutterPath = "C:\src\flutter"
$flutterBinPath = "$flutterPath\bin"

Write-Host ""
Write-Host "Step 3: Setting up Flutter installation..." -ForegroundColor Green
Write-Host "Flutter will be installed to: $flutterPath" -ForegroundColor Cyan

# Create directory if it doesn't exist
if (-not (Test-Path "C:\src")) {
    Write-Host "Creating C:\src directory..." -ForegroundColor Yellow
    New-Item -ItemType Directory -Path "C:\src" -Force | Out-Null
}

# Step 4: Download Flutter (using Git)
Write-Host ""
Write-Host "Step 4: Downloading Flutter SDK..." -ForegroundColor Green
Write-Host "This may take a few minutes (downloading ~1.5 GB)..." -ForegroundColor Yellow

if (Test-Path $flutterPath) {
    Write-Host "Flutter directory already exists. Updating..." -ForegroundColor Yellow
    Set-Location $flutterPath
    git pull
} else {
    Write-Host "Cloning Flutter repository..." -ForegroundColor Yellow
    Set-Location "C:\src"
    git clone https://github.com/flutter/flutter.git -b stable
}

if (-not (Test-Path "$flutterBinPath\flutter.bat")) {
    Write-Host "✗ Flutter download failed" -ForegroundColor Red
    Write-Host "Please download manually from: https://docs.flutter.dev/get-started/install/windows" -ForegroundColor Yellow
    exit 1
}

Write-Host "✓ Flutter downloaded successfully" -ForegroundColor Green

# Step 5: Add Flutter to PATH
Write-Host ""
Write-Host "Step 5: Adding Flutter to PATH..." -ForegroundColor Green

$currentPath = [Environment]::GetEnvironmentVariable("Path", "User")
if ($currentPath -notlike "*$flutterBinPath*") {
    Write-Host "Adding Flutter to user PATH..." -ForegroundColor Yellow
    [Environment]::SetEnvironmentVariable("Path", "$currentPath;$flutterBinPath", "User")
    Write-Host "✓ Flutter added to PATH" -ForegroundColor Green
    Write-Host ""
    Write-Host "IMPORTANT: Please restart your terminal/PowerShell for PATH changes to take effect!" -ForegroundColor Yellow
    Write-Host ""
} else {
    Write-Host "✓ Flutter is already in PATH" -ForegroundColor Green
}

# Step 6: Verify installation
Write-Host ""
Write-Host "Step 6: Verifying Flutter installation..." -ForegroundColor Green
Write-Host "Refreshing PATH in current session..." -ForegroundColor Yellow
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

try {
    $flutterCheck = & "$flutterBinPath\flutter.bat" --version 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✓ Flutter is working!" -ForegroundColor Green
        & "$flutterBinPath\flutter.bat" --version
    }
} catch {
    Write-Host "⚠ Flutter installed but not in PATH yet. Restart terminal and run: flutter doctor" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "=== Installation Complete ===" -ForegroundColor Cyan
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Yellow
Write-Host "1. RESTART your terminal/PowerShell" -ForegroundColor White
Write-Host "2. Run: flutter doctor" -ForegroundColor White
Write-Host "3. Install Android Studio if needed" -ForegroundColor White
Write-Host "4. Run: flutter pub get (in project directory)" -ForegroundColor White
Write-Host "5. Run: flutter run" -ForegroundColor White
Write-Host ""

