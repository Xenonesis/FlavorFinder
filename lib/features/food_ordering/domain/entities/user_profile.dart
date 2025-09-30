import 'package:equatable/equatable.dart';
import 'food_item.dart';

class UserProfile extends Equatable {
  final String id;
  final String name;
  final String email;
  final String? phoneNumber;
  final String? profileImageUrl;
  final UserPreferences preferences;
  final List<OrderHistory> orderHistory;
  final List<String> favoriteRestaurants;
  final List<String> favoriteFoodItems;
  final UserStats stats;
  final DateTime createdAt;
  final DateTime lastActiveAt;

  const UserProfile({
    required this.id,
    required this.name,
    required this.email,
    this.phoneNumber,
    this.profileImageUrl,
    required this.preferences,
    required this.orderHistory,
    required this.favoriteRestaurants,
    required this.favoriteFoodItems,
    required this.stats,
    required this.createdAt,
    required this.lastActiveAt,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        phoneNumber,
        profileImageUrl,
        preferences,
        orderHistory,
        favoriteRestaurants,
        favoriteFoodItems,
        stats,
        createdAt,
        lastActiveAt,
      ];

  UserProfile copyWith({
    String? id,
    String? name,
    String? email,
    String? phoneNumber,
    String? profileImageUrl,
    UserPreferences? preferences,
    List<OrderHistory>? orderHistory,
    List<String>? favoriteRestaurants,
    List<String>? favoriteFoodItems,
    UserStats? stats,
    DateTime? createdAt,
    DateTime? lastActiveAt,
  }) {
    return UserProfile(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      preferences: preferences ?? this.preferences,
      orderHistory: orderHistory ?? this.orderHistory,
      favoriteRestaurants: favoriteRestaurants ?? this.favoriteRestaurants,
      favoriteFoodItems: favoriteFoodItems ?? this.favoriteFoodItems,
      stats: stats ?? this.stats,
      createdAt: createdAt ?? this.createdAt,
      lastActiveAt: lastActiveAt ?? this.lastActiveAt,
    );
  }
}

class UserPreferences extends Equatable {
  final Map<String, double> cuisinePreferences;
  final Map<String, double> categoryPreferences;
  final double spicyTolerance;
  final bool isVegetarian;
  final bool isVegan;
  final bool isGlutenFree;
  final double budgetPreference;
  final int preferredDeliveryTime;
  final bool enableNotifications;
  final bool enableLocationTracking;
  final String preferredLanguage;
  final String theme; // 'light', 'dark', 'system'

  const UserPreferences({
    required this.cuisinePreferences,
    required this.categoryPreferences,
    required this.spicyTolerance,
    required this.isVegetarian,
    required this.isVegan,
    required this.isGlutenFree,
    required this.budgetPreference,
    required this.preferredDeliveryTime,
    required this.enableNotifications,
    required this.enableLocationTracking,
    required this.preferredLanguage,
    required this.theme,
  });

  @override
  List<Object?> get props => [
        cuisinePreferences,
        categoryPreferences,
        spicyTolerance,
        isVegetarian,
        isVegan,
        isGlutenFree,
        budgetPreference,
        preferredDeliveryTime,
        enableNotifications,
        enableLocationTracking,
        preferredLanguage,
        theme,
      ];

  UserPreferences copyWith({
    Map<String, double>? cuisinePreferences,
    Map<String, double>? categoryPreferences,
    double? spicyTolerance,
    bool? isVegetarian,
    bool? isVegan,
    bool? isGlutenFree,
    double? budgetPreference,
    int? preferredDeliveryTime,
    bool? enableNotifications,
    bool? enableLocationTracking,
    String? preferredLanguage,
    String? theme,
  }) {
    return UserPreferences(
      cuisinePreferences: cuisinePreferences ?? this.cuisinePreferences,
      categoryPreferences: categoryPreferences ?? this.categoryPreferences,
      spicyTolerance: spicyTolerance ?? this.spicyTolerance,
      isVegetarian: isVegetarian ?? this.isVegetarian,
      isVegan: isVegan ?? this.isVegan,
      isGlutenFree: isGlutenFree ?? this.isGlutenFree,
      budgetPreference: budgetPreference ?? this.budgetPreference,
      preferredDeliveryTime: preferredDeliveryTime ?? this.preferredDeliveryTime,
      enableNotifications: enableNotifications ?? this.enableNotifications,
      enableLocationTracking: enableLocationTracking ?? this.enableLocationTracking,
      preferredLanguage: preferredLanguage ?? this.preferredLanguage,
      theme: theme ?? this.theme,
    );
  }

  static UserPreferences defaultPreferences() {
    return UserPreferences(
      cuisinePreferences: {},
      categoryPreferences: {},
      spicyTolerance: 0.5,
      isVegetarian: false,
      isVegan: false,
      isGlutenFree: false,
      budgetPreference: 0.5,
      preferredDeliveryTime: 30,
      enableNotifications: true,
      enableLocationTracking: true,
      preferredLanguage: 'en',
      theme: 'system',
    );
  }
}

class OrderHistory extends Equatable {
  final String orderId;
  final DateTime orderDate;
  final String restaurantId;
  final String restaurantName;
  final List<FoodItem> items;
  final double totalAmount;
  final String status;
  final double? rating;
  final String? review;

  const OrderHistory({
    required this.orderId,
    required this.orderDate,
    required this.restaurantId,
    required this.restaurantName,
    required this.items,
    required this.totalAmount,
    required this.status,
    this.rating,
    this.review,
  });

  @override
  List<Object?> get props => [
        orderId,
        orderDate,
        restaurantId,
        restaurantName,
        items,
        totalAmount,
        status,
        rating,
        review,
      ];
}

class UserStats extends Equatable {
  final int totalOrders;
  final double totalSpent;
  final String favoriteRestaurant;
  final String favoriteCuisine;
  final String favoriteCategory;
  final double averageOrderValue;
  final int loyaltyPoints;
  final String membershipTier; // 'bronze', 'silver', 'gold', 'platinum'

  const UserStats({
    required this.totalOrders,
    required this.totalSpent,
    required this.favoriteRestaurant,
    required this.favoriteCuisine,
    required this.favoriteCategory,
    required this.averageOrderValue,
    required this.loyaltyPoints,
    required this.membershipTier,
  });

  @override
  List<Object?> get props => [
        totalOrders,
        totalSpent,
        favoriteRestaurant,
        favoriteCuisine,
        favoriteCategory,
        averageOrderValue,
        loyaltyPoints,
        membershipTier,
      ];

  UserStats copyWith({
    int? totalOrders,
    double? totalSpent,
    String? favoriteRestaurant,
    String? favoriteCuisine,
    String? favoriteCategory,
    double? averageOrderValue,
    int? loyaltyPoints,
    String? membershipTier,
  }) {
    return UserStats(
      totalOrders: totalOrders ?? this.totalOrders,
      totalSpent: totalSpent ?? this.totalSpent,
      favoriteRestaurant: favoriteRestaurant ?? this.favoriteRestaurant,
      favoriteCuisine: favoriteCuisine ?? this.favoriteCuisine,
      favoriteCategory: favoriteCategory ?? this.favoriteCategory,
      averageOrderValue: averageOrderValue ?? this.averageOrderValue,
      loyaltyPoints: loyaltyPoints ?? this.loyaltyPoints,
      membershipTier: membershipTier ?? this.membershipTier,
    );
  }

  static UserStats defaultStats() {
    return UserStats(
      totalOrders: 0,
      totalSpent: 0.0,
      favoriteRestaurant: '',
      favoriteCuisine: '',
      favoriteCategory: '',
      averageOrderValue: 0.0,
      loyaltyPoints: 0,
      membershipTier: 'bronze',
    );
  }
}
