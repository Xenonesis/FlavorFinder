#!/bin/bash

echo "🍕 Food Delivery App Setup Script 🍕"
echo "=================================="

# Check if Flutter is installed
if ! command -v flutter &> /dev/null; then
    echo "❌ Flutter is not installed. Please install Flutter first:"
    echo "   https://docs.flutter.dev/get-started/install"
    exit 1
fi

echo "✅ Flutter found"

# Check Flutter doctor
echo "🔧 Running flutter doctor..."
flutter doctor

# Get dependencies
echo "📦 Getting dependencies..."
flutter pub get

# Run code generation if needed
echo "🏗️  Running code generation..."
flutter packages pub run build_runner build --delete-conflicting-outputs || echo "⚠️  No code generation needed"

# Run tests
echo "🧪 Running tests..."
flutter test

# Check for any analysis issues
echo "🔍 Running static analysis..."
flutter analyze

echo ""
echo "🎉 Setup complete! You can now run the app with:"
echo "   flutter run"
echo ""
echo "📱 Available commands:"
echo "   flutter run                    # Run in debug mode"
echo "   flutter run --release          # Run in release mode"
echo "   flutter test                   # Run unit tests"
echo "   flutter test --coverage        # Run tests with coverage"
echo "   flutter analyze                # Run static analysis"
echo ""