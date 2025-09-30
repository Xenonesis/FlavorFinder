class AppConstants {
  // App Information
  static const String appName = 'Food Delivery';
  static const String appVersion = '1.0.0';
  
  // API Configuration (for future use)
  static const String baseUrl = 'https://api.fooddelivery.com';
  static const int connectionTimeout = 30000; // 30 seconds
  static const int receiveTimeout = 30000; // 30 seconds
  
  // Order Configuration
  static const double taxRate = 0.08; // 8%
  static const double defaultDeliveryFee = 3.99;
  static const double minimumOrderAmount = 10.0;
  static const int maxCartItemQuantity = 10;
  
  // UI Constants
  static const double defaultPadding = 16.0;
  static const double defaultRadius = 12.0;
  static const double cardElevation = 2.0;
  
  // Animation Durations
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 400);
  static const Duration longAnimation = Duration(milliseconds: 800);
  
  // Mock Data Configuration
  static const Duration mockNetworkDelay = Duration(milliseconds: 1500);
  static const double mockFailureRate = 0.05; // 5% failure rate for testing
}