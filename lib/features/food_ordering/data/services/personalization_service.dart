import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/user_profile.dart';
import '../../domain/entities/food_item.dart';

class PersonalizationService {
  static final PersonalizationService _instance = PersonalizationService._internal();
  factory PersonalizationService() => _instance;
  PersonalizationService._internal();

  static const String _userProfileKey = 'user_profile';
  static const String _orderHistoryKey = 'order_history';
  static const String _favoritesKey = 'favorites';
  static const String _preferencesKey = 'user_preferences';

  UserProfile? _currentProfile;

  Future<UserProfile?> getCurrentProfile() async {
    if (_currentProfile != null) return _currentProfile;
    
    final prefs = await SharedPreferences.getInstance();
    final profileJson = prefs.getString(_userProfileKey);
    
    if (profileJson != null) {
      final profileData = jsonDecode(profileJson);
      _currentProfile = _parseUserProfile(profileData);
    }
    
    return _currentProfile;
  }

  Future<void> saveUserProfile(UserProfile profile) async {
    final prefs = await SharedPreferences.getInstance();
    final profileJson = jsonEncode(_userProfileToJson(profile));
    await prefs.setString(_userProfileKey, profileJson);
    _currentProfile = profile;
  }

  Future<UserProfile> createDefaultProfile(String userId, String name, String email) async {
    final profile = UserProfile(
      id: userId,
      name: name,
      email: email,
      preferences: UserPreferences.defaultPreferences(),
      orderHistory: [],
      favoriteRestaurants: [],
      favoriteFoodItems: [],
      stats: UserStats.defaultStats(),
      createdAt: DateTime.now(),
      lastActiveAt: DateTime.now(),
    );
    
    await saveUserProfile(profile);
    return profile;
  }

  Future<void> updateUserPreferences(UserPreferences preferences) async {
    final currentProfile = await getCurrentProfile();
    if (currentProfile != null) {
      final updatedProfile = currentProfile.copyWith(
        preferences: preferences,
        lastActiveAt: DateTime.now(),
      );
      await saveUserProfile(updatedProfile);
    }
  }

  Future<void> addToOrderHistory(OrderHistory order) async {
    final currentProfile = await getCurrentProfile();
    if (currentProfile != null) {
      final updatedHistory = List<OrderHistory>.from(currentProfile.orderHistory)
        ..insert(0, order);
      
      // Keep only last 50 orders
      if (updatedHistory.length > 50) {
        updatedHistory.removeRange(50, updatedHistory.length);
      }

      final updatedStats = _calculateUpdatedStats(currentProfile.stats, order);
      final updatedPreferences = _updatePreferencesFromOrder(
        currentProfile.preferences,
        order,
      );

      final updatedProfile = currentProfile.copyWith(
        orderHistory: updatedHistory,
        stats: updatedStats,
        preferences: updatedPreferences,
        lastActiveAt: DateTime.now(),
      );

      await saveUserProfile(updatedProfile);
    }
  }

  Future<void> addToFavorites(String itemId, String type) async {
    final currentProfile = await getCurrentProfile();
    if (currentProfile != null) {
      List<String> favorites;
      UserProfile updatedProfile;

      if (type == 'restaurant') {
        favorites = List<String>.from(currentProfile.favoriteRestaurants);
        if (!favorites.contains(itemId)) {
          favorites.add(itemId);
          updatedProfile = currentProfile.copyWith(
            favoriteRestaurants: favorites,
            lastActiveAt: DateTime.now(),
          );
        } else {
          return;
        }
      } else {
        favorites = List<String>.from(currentProfile.favoriteFoodItems);
        if (!favorites.contains(itemId)) {
          favorites.add(itemId);
          updatedProfile = currentProfile.copyWith(
            favoriteFoodItems: favorites,
            lastActiveAt: DateTime.now(),
          );
        } else {
          return;
        }
      }

      await saveUserProfile(updatedProfile);
    }
  }

  Future<void> removeFromFavorites(String itemId, String type) async {
    final currentProfile = await getCurrentProfile();
    if (currentProfile != null) {
      UserProfile updatedProfile;

      if (type == 'restaurant') {
        final favorites = List<String>.from(currentProfile.favoriteRestaurants)
          ..remove(itemId);
        updatedProfile = currentProfile.copyWith(
          favoriteRestaurants: favorites,
          lastActiveAt: DateTime.now(),
        );
      } else {
        final favorites = List<String>.from(currentProfile.favoriteFoodItems)
          ..remove(itemId);
        updatedProfile = currentProfile.copyWith(
          favoriteFoodItems: favorites,
          lastActiveAt: DateTime.now(),
        );
      }

      await saveUserProfile(updatedProfile);
    }
  }

  Future<bool> isFavorite(String itemId, String type) async {
    final currentProfile = await getCurrentProfile();
    if (currentProfile == null) return false;

    if (type == 'restaurant') {
      return currentProfile.favoriteRestaurants.contains(itemId);
    } else {
      return currentProfile.favoriteFoodItems.contains(itemId);
    }
  }

  Future<List<OrderHistory>> getOrderHistory({int? limit}) async {
    final currentProfile = await getCurrentProfile();
    if (currentProfile == null) return [];

    final history = currentProfile.orderHistory;
    if (limit != null && limit < history.length) {
      return history.take(limit).toList();
    }
    return history;
  }

  Future<Map<String, dynamic>> getUserInsights() async {
    final currentProfile = await getCurrentProfile();
    if (currentProfile == null) return {};

    final stats = currentProfile.stats;
    final preferences = currentProfile.preferences;
    final orderHistory = currentProfile.orderHistory;

    return {
      'totalOrders': stats.totalOrders,
      'totalSpent': stats.totalSpent,
      'averageOrderValue': stats.averageOrderValue,
      'favoriteRestaurant': stats.favoriteRestaurant,
      'favoriteCuisine': stats.favoriteCuisine,
      'favoriteCategory': stats.favoriteCategory,
      'loyaltyPoints': stats.loyaltyPoints,
      'membershipTier': stats.membershipTier,
      'monthlySpending': _calculateMonthlySpending(orderHistory),
      'orderFrequency': _calculateOrderFrequency(orderHistory),
      'topCuisines': _getTopCuisines(orderHistory),
      'spendingTrend': _getSpendingTrend(orderHistory),
    };
  }

  UserStats _calculateUpdatedStats(UserStats currentStats, OrderHistory newOrder) {
    final newTotalOrders = currentStats.totalOrders + 1;
    final newTotalSpent = currentStats.totalSpent + newOrder.totalAmount;
    final newAverageOrderValue = newTotalSpent / newTotalOrders;
    
    // Calculate loyalty points (1 point per dollar spent)
    final newLoyaltyPoints = currentStats.loyaltyPoints + newOrder.totalAmount.round();
    
    // Determine membership tier based on total spent
    String membershipTier = 'bronze';
    if (newTotalSpent >= 1000) {
      membershipTier = 'platinum';
    } else if (newTotalSpent >= 500) {
      membershipTier = 'gold';
    } else if (newTotalSpent >= 200) {
      membershipTier = 'silver';
    }

    return currentStats.copyWith(
      totalOrders: newTotalOrders,
      totalSpent: newTotalSpent,
      averageOrderValue: newAverageOrderValue,
      loyaltyPoints: newLoyaltyPoints,
      membershipTier: membershipTier,
      favoriteRestaurant: newOrder.restaurantName,
    );
  }

  UserPreferences _updatePreferencesFromOrder(
    UserPreferences currentPreferences,
    OrderHistory order,
  ) {
    // Update cuisine preferences based on order
    final updatedCuisinePreferences = Map<String, double>.from(
      currentPreferences.cuisinePreferences,
    );
    
    // This would be more sophisticated in a real app
    // For now, just increment the preference for the ordered cuisine
    final restaurantCuisine = 'Italian'; // This would come from restaurant data
    updatedCuisinePreferences[restaurantCuisine] = 
        (updatedCuisinePreferences[restaurantCuisine] ?? 0.0) + 0.1;

    // Update category preferences
    final updatedCategoryPreferences = Map<String, double>.from(
      currentPreferences.categoryPreferences,
    );
    
    for (final item in order.items) {
      updatedCategoryPreferences[item.category] = 
          (updatedCategoryPreferences[item.category] ?? 0.0) + 0.1;
    }

    return currentPreferences.copyWith(
      cuisinePreferences: updatedCuisinePreferences,
      categoryPreferences: updatedCategoryPreferences,
    );
  }

  Map<String, double> _calculateMonthlySpending(List<OrderHistory> orderHistory) {
    final monthlySpending = <String, double>{};
    
    for (final order in orderHistory) {
      final monthKey = '${order.orderDate.year}-${order.orderDate.month.toString().padLeft(2, '0')}';
      monthlySpending[monthKey] = (monthlySpending[monthKey] ?? 0.0) + order.totalAmount;
    }
    
    return monthlySpending;
  }

  double _calculateOrderFrequency(List<OrderHistory> orderHistory) {
    if (orderHistory.isEmpty) return 0.0;
    
    final now = DateTime.now();
    final thirtyDaysAgo = now.subtract(Duration(days: 30));
    
    final recentOrders = orderHistory.where(
      (order) => order.orderDate.isAfter(thirtyDaysAgo),
    ).length;
    
    return recentOrders / 30.0; // Orders per day
  }

  List<Map<String, dynamic>> _getTopCuisines(List<OrderHistory> orderHistory) {
    final cuisineCount = <String, int>{};
    
    for (final order in orderHistory) {
      // This would use actual restaurant cuisine data
      final cuisine = 'Italian'; // Placeholder
      cuisineCount[cuisine] = (cuisineCount[cuisine] ?? 0) + 1;
    }
    
    final sortedCuisines = cuisineCount.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    
    return sortedCuisines.take(5).map((entry) => {
      'cuisine': entry.key,
      'count': entry.value,
    }).toList();
  }

  List<Map<String, dynamic>> _getSpendingTrend(List<OrderHistory> orderHistory) {
    final last6Months = <String, double>{};
    final now = DateTime.now();
    
    for (int i = 0; i < 6; i++) {
      final month = DateTime(now.year, now.month - i, 1);
      final monthKey = '${month.year}-${month.month.toString().padLeft(2, '0')}';
      last6Months[monthKey] = 0.0;
    }
    
    for (final order in orderHistory) {
      final monthKey = '${order.orderDate.year}-${order.orderDate.month.toString().padLeft(2, '0')}';
      if (last6Months.containsKey(monthKey)) {
        last6Months[monthKey] = last6Months[monthKey]! + order.totalAmount;
      }
    }
    
    return last6Months.entries.map((entry) => {
      'month': entry.key,
      'amount': entry.value,
    }).toList();
  }

  Map<String, dynamic> _userProfileToJson(UserProfile profile) {
    return {
      'id': profile.id,
      'name': profile.name,
      'email': profile.email,
      'phoneNumber': profile.phoneNumber,
      'profileImageUrl': profile.profileImageUrl,
      'preferences': _preferencesToJson(profile.preferences),
      'orderHistory': profile.orderHistory.map(_orderHistoryToJson).toList(),
      'favoriteRestaurants': profile.favoriteRestaurants,
      'favoriteFoodItems': profile.favoriteFoodItems,
      'stats': _statsToJson(profile.stats),
      'createdAt': profile.createdAt.toIso8601String(),
      'lastActiveAt': profile.lastActiveAt.toIso8601String(),
    };
  }

  UserProfile _parseUserProfile(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      profileImageUrl: json['profileImageUrl'],
      preferences: _parsePreferences(json['preferences']),
      orderHistory: (json['orderHistory'] as List)
          .map((item) => _parseOrderHistory(item))
          .toList(),
      favoriteRestaurants: List<String>.from(json['favoriteRestaurants'] ?? []),
      favoriteFoodItems: List<String>.from(json['favoriteFoodItems'] ?? []),
      stats: _parseStats(json['stats']),
      createdAt: DateTime.parse(json['createdAt']),
      lastActiveAt: DateTime.parse(json['lastActiveAt']),
    );
  }

  Map<String, dynamic> _preferencesToJson(UserPreferences preferences) {
    return {
      'cuisinePreferences': preferences.cuisinePreferences,
      'categoryPreferences': preferences.categoryPreferences,
      'spicyTolerance': preferences.spicyTolerance,
      'isVegetarian': preferences.isVegetarian,
      'isVegan': preferences.isVegan,
      'isGlutenFree': preferences.isGlutenFree,
      'budgetPreference': preferences.budgetPreference,
      'preferredDeliveryTime': preferences.preferredDeliveryTime,
      'enableNotifications': preferences.enableNotifications,
      'enableLocationTracking': preferences.enableLocationTracking,
      'preferredLanguage': preferences.preferredLanguage,
      'theme': preferences.theme,
    };
  }

  UserPreferences _parsePreferences(Map<String, dynamic> json) {
    return UserPreferences(
      cuisinePreferences: Map<String, double>.from(json['cuisinePreferences'] ?? {}),
      categoryPreferences: Map<String, double>.from(json['categoryPreferences'] ?? {}),
      spicyTolerance: json['spicyTolerance']?.toDouble() ?? 0.5,
      isVegetarian: json['isVegetarian'] ?? false,
      isVegan: json['isVegan'] ?? false,
      isGlutenFree: json['isGlutenFree'] ?? false,
      budgetPreference: json['budgetPreference']?.toDouble() ?? 0.5,
      preferredDeliveryTime: json['preferredDeliveryTime'] ?? 30,
      enableNotifications: json['enableNotifications'] ?? true,
      enableLocationTracking: json['enableLocationTracking'] ?? true,
      preferredLanguage: json['preferredLanguage'] ?? 'en',
      theme: json['theme'] ?? 'system',
    );
  }

  Map<String, dynamic> _orderHistoryToJson(OrderHistory order) {
    return {
      'orderId': order.orderId,
      'orderDate': order.orderDate.toIso8601String(),
      'restaurantId': order.restaurantId,
      'restaurantName': order.restaurantName,
      'items': order.items.map((item) => {
        'id': item.id,
        'name': item.name,
        'price': item.price,
        'category': item.category,
      }).toList(),
      'totalAmount': order.totalAmount,
      'status': order.status,
      'rating': order.rating,
      'review': order.review,
    };
  }

  OrderHistory _parseOrderHistory(Map<String, dynamic> json) {
    return OrderHistory(
      orderId: json['orderId'],
      orderDate: DateTime.parse(json['orderDate']),
      restaurantId: json['restaurantId'],
      restaurantName: json['restaurantName'],
      items: (json['items'] as List).map((item) => FoodItem(
        id: item['id'],
        name: item['name'],
        description: '',
        price: item['price']?.toDouble() ?? 0.0,
        imageUrl: '',
        category: item['category'],
        rating: 0.0,
        isVegetarian: false,
        allergens: [],
      )).toList(),
      totalAmount: json['totalAmount']?.toDouble() ?? 0.0,
      status: json['status'],
      rating: json['rating']?.toDouble(),
      review: json['review'],
    );
  }

  Map<String, dynamic> _statsToJson(UserStats stats) {
    return {
      'totalOrders': stats.totalOrders,
      'totalSpent': stats.totalSpent,
      'favoriteRestaurant': stats.favoriteRestaurant,
      'favoriteCuisine': stats.favoriteCuisine,
      'favoriteCategory': stats.favoriteCategory,
      'averageOrderValue': stats.averageOrderValue,
      'loyaltyPoints': stats.loyaltyPoints,
      'membershipTier': stats.membershipTier,
    };
  }

  UserStats _parseStats(Map<String, dynamic> json) {
    return UserStats(
      totalOrders: json['totalOrders'] ?? 0,
      totalSpent: json['totalSpent']?.toDouble() ?? 0.0,
      favoriteRestaurant: json['favoriteRestaurant'] ?? '',
      favoriteCuisine: json['favoriteCuisine'] ?? '',
      favoriteCategory: json['favoriteCategory'] ?? '',
      averageOrderValue: json['averageOrderValue']?.toDouble() ?? 0.0,
      loyaltyPoints: json['loyaltyPoints'] ?? 0,
      membershipTier: json['membershipTier'] ?? 'bronze',
    );
  }
}
