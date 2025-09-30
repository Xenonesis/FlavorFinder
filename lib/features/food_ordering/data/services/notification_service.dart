import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationService {
  static const String _notificationsEnabledKey = 'notifications_enabled';
  static const String _orderUpdatesKey = 'order_updates_enabled';
  static const String _promotionsKey = 'promotions_enabled';
  static const String _newRestaurantsKey = 'new_restaurants_enabled';

  // Initialize notification service
  Future<void> initialize() async {
    // In a real app, you would initialize Firebase Cloud Messaging here
    // await FirebaseMessaging.instance.requestPermission();
    // await _setupMessageHandlers();
  }

  // Request notification permissions
  Future<bool> requestPermissions() async {
    // In a real app, you would request actual permissions
    // For now, we'll simulate the permission request
    return true;
  }

  // Get notification settings
  Future<NotificationSettings> getNotificationSettings() async {
    final prefs = await SharedPreferences.getInstance();
    
    return NotificationSettings(
      notificationsEnabled: prefs.getBool(_notificationsEnabledKey) ?? true,
      orderUpdates: prefs.getBool(_orderUpdatesKey) ?? true,
      promotions: prefs.getBool(_promotionsKey) ?? true,
      newRestaurants: prefs.getBool(_newRestaurantsKey) ?? false,
    );
  }

  // Update notification settings
  Future<void> updateNotificationSettings(NotificationSettings settings) async {
    final prefs = await SharedPreferences.getInstance();
    
    await prefs.setBool(_notificationsEnabledKey, settings.notificationsEnabled);
    await prefs.setBool(_orderUpdatesKey, settings.orderUpdates);
    await prefs.setBool(_promotionsKey, settings.promotions);
    await prefs.setBool(_newRestaurantsKey, settings.newRestaurants);
  }

  // Send local notification (for demo purposes)
  Future<void> showLocalNotification({
    required String title,
    required String body,
    String? payload,
  }) async {
    // In a real app, you would use flutter_local_notifications
    // For now, we'll just print to console
    debugPrint('Notification: $title - $body');
  }

  // Simulate order status notifications
  Future<void> sendOrderStatusNotification(String orderId, OrderStatus status) async {
    String title;
    String body;

    switch (status) {
      case OrderStatus.confirmed:
        title = 'Order Confirmed!';
        body = 'Your order #$orderId has been confirmed and is being prepared.';
        break;
      case OrderStatus.preparing:
        title = 'Order Being Prepared';
        body = 'Your order #$orderId is being prepared by the restaurant.';
        break;
      case OrderStatus.onTheWay:
        title = 'Order On The Way!';
        body = 'Your order #$orderId is on its way to you.';
        break;
      case OrderStatus.delivered:
        title = 'Order Delivered!';
        body = 'Your order #$orderId has been delivered. Enjoy your meal!';
        break;
      case OrderStatus.cancelled:
        title = 'Order Cancelled';
        body = 'Your order #$orderId has been cancelled.';
        break;
    }

    await showLocalNotification(
      title: title,
      body: body,
      payload: 'order_$orderId',
    );
  }

  // Send promotional notifications
  Future<void> sendPromotionalNotification({
    required String title,
    required String message,
    String? restaurantId,
  }) async {
    final settings = await getNotificationSettings();
    
    if (settings.notificationsEnabled && settings.promotions) {
      await showLocalNotification(
        title: title,
        body: message,
        payload: restaurantId != null ? 'restaurant_$restaurantId' : 'promotion',
      );
    }
  }

  // Send new restaurant notification
  Future<void> sendNewRestaurantNotification(String restaurantName) async {
    final settings = await getNotificationSettings();
    
    if (settings.notificationsEnabled && settings.newRestaurants) {
      await showLocalNotification(
        title: 'New Restaurant Available!',
        body: '$restaurantName is now available for delivery in your area.',
        payload: 'new_restaurant',
      );
    }
  }

  // Schedule promotional notifications (demo)
  Future<void> schedulePromotionalNotifications() async {
    // In a real app, you would schedule these with the system
    await Future.delayed(const Duration(seconds: 5));
    await sendPromotionalNotification(
      title: '🍕 Special Offer!',
      message: 'Get 20% off on your next pizza order. Use code: PIZZA20',
    );

    await Future.delayed(const Duration(seconds: 10));
    await sendPromotionalNotification(
      title: '🚚 Free Delivery!',
      message: 'Free delivery on orders over \$25 today only!',
    );
  }
}

class NotificationSettings {
  final bool notificationsEnabled;
  final bool orderUpdates;
  final bool promotions;
  final bool newRestaurants;

  NotificationSettings({
    required this.notificationsEnabled,
    required this.orderUpdates,
    required this.promotions,
    required this.newRestaurants,
  });

  NotificationSettings copyWith({
    bool? notificationsEnabled,
    bool? orderUpdates,
    bool? promotions,
    bool? newRestaurants,
  }) {
    return NotificationSettings(
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      orderUpdates: orderUpdates ?? this.orderUpdates,
      promotions: promotions ?? this.promotions,
      newRestaurants: newRestaurants ?? this.newRestaurants,
    );
  }
}

enum OrderStatus {
  confirmed,
  preparing,
  onTheWay,
  delivered,
  cancelled,
}
