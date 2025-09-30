@echo off
echo 🍕 Food Delivery App Runner 🍕
echo ===============================

REM Check if Flutter is installed
flutter --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Flutter is not installed. Please install Flutter first:
    echo    https://docs.flutter.dev/get-started/install
    pause
    exit /b 1
)

echo ✅ Flutter found

REM Get dependencies
echo 📦 Getting dependencies...
flutter pub get

REM Run the app
echo 🚀 Starting the app...
flutter run

pause