#!/bin/bash

echo "🍕 FlavorFinder Premium - Starting App..."
echo "=================================="

# Check if Flutter is installed
if ! command -v flutter &> /dev/null; then
    echo "❌ Flutter is not installed or not in PATH"
    echo "Please install Flutter from https://flutter.dev"
    exit 1
fi

# Get dependencies
echo "📦 Getting dependencies..."
flutter pub get

# Check for any issues
echo "🔍 Running flutter doctor..."
flutter doctor

# Run the premium app
echo "🚀 Starting FlavorFinder Premium..."
flutter run lib/main_premium.dart

echo "✅ App started successfully!"
