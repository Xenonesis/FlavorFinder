import 'dart:math';
import '../../domain/entities/food_item.dart';
import '../../domain/entities/restaurant.dart';

class AIRecommendationService {
  static final AIRecommendationService _instance = AIRecommendationService._internal();
  factory AIRecommendationService() => _instance;
  AIRecommendationService._internal();

  // User preference weights
  Map<String, double> _userPreferences = {
    'spicy': 0.5,
    'sweet': 0.3,
    'healthy': 0.7,
    'fast': 0.8,
    'budget': 0.6,
  };

  // Order history for learning
  List<FoodItem> _orderHistory = [];
  Map<String, int> _cuisineFrequency = {};
  Map<String, int> _categoryFrequency = {};

  void updateUserPreferences(Map<String, double> preferences) {
    _userPreferences.addAll(preferences);
  }

  void addToOrderHistory(FoodItem item) {
    _orderHistory.add(item);
    _updateFrequencies(item);
  }

  void _updateFrequencies(FoodItem item) {
    _categoryFrequency[item.category] = (_categoryFrequency[item.category] ?? 0) + 1;
  }

  List<FoodItem> getPersonalizedRecommendations(
    List<FoodItem> allItems, {
    int limit = 10,
  }) {
    final scoredItems = allItems.map((item) {
      final score = _calculateRecommendationScore(item);
      return MapEntry(item, score);
    }).toList();

    scoredItems.sort((a, b) => b.value.compareTo(a.value));
    return scoredItems.take(limit).map((e) => e.key).toList();
  }

  double _calculateRecommendationScore(FoodItem item) {
    double score = 0.0;

    // Base popularity score
    score += item.rating * 0.3;

    // Category preference
    final categoryFreq = _categoryFrequency[item.category] ?? 0;
    score += (categoryFreq / max(_orderHistory.length, 1)) * 0.4;

    // Price preference
    if (_userPreferences['budget']! > 0.5 && item.price < 15.0) {
      score += 0.2;
    }

    // Healthy preference
    if (_userPreferences['healthy']! > 0.5 && _isHealthy(item)) {
      score += 0.3;
    }

    // Spicy preference
    if (_userPreferences['spicy']! > 0.5 && _isSpicy(item)) {
      score += 0.2;
    }

    // Add randomness for discovery
    score += Random().nextDouble() * 0.1;

    return score;
  }

  bool _isHealthy(FoodItem item) {
    final healthyKeywords = ['salad', 'grilled', 'steamed', 'fresh', 'organic'];
    return healthyKeywords.any((keyword) => 
      item.name.toLowerCase().contains(keyword) ||
      item.description.toLowerCase().contains(keyword)
    );
  }

  bool _isSpicy(FoodItem item) {
    final spicyKeywords = ['spicy', 'hot', 'chili', 'pepper', 'jalapeño'];
    return spicyKeywords.any((keyword) => 
      item.name.toLowerCase().contains(keyword) ||
      item.description.toLowerCase().contains(keyword)
    );
  }

  List<FoodItem> getSimilarItems(FoodItem item, List<FoodItem> allItems) {
    return allItems
        .where((other) => 
          other.id != item.id &&
          (other.category == item.category ||
           _calculateSimilarity(item, other) > 0.6))
        .take(5)
        .toList();
  }

  double _calculateSimilarity(FoodItem item1, FoodItem item2) {
    double similarity = 0.0;
    
    // Category similarity
    if (item1.category == item2.category) similarity += 0.4;
    
    // Price similarity
    final priceDiff = (item1.price - item2.price).abs();
    similarity += (1 - (priceDiff / max(item1.price, item2.price))) * 0.3;
    
    // Rating similarity
    final ratingDiff = (item1.rating - item2.rating).abs();
    similarity += (1 - (ratingDiff / 5.0)) * 0.3;
    
    return similarity;
  }

  List<Restaurant> getRecommendedRestaurants(
    List<Restaurant> restaurants,
    String? currentLocation,
  ) {
    return restaurants
        .where((restaurant) => restaurant.rating >= 4.0)
        .toList()
      ..sort((a, b) {
        double scoreA = _calculateRestaurantScore(a);
        double scoreB = _calculateRestaurantScore(b);
        return scoreB.compareTo(scoreA);
      });
  }

  double _calculateRestaurantScore(Restaurant restaurant) {
    double score = restaurant.rating * 0.4;
    
    // Delivery time preference
    if (_userPreferences['fast']! > 0.5) {
      score += (60 - restaurant.deliveryTime) / 60 * 0.3;
    }
    
    // Delivery fee preference
    if (_userPreferences['budget']! > 0.5) {
      score += (5.0 - restaurant.deliveryFee) / 5.0 * 0.3;
    }
    
    return score;
  }

  Map<String, dynamic> getUserInsights() {
    return {
      'totalOrders': _orderHistory.length,
      'favoriteCategory': _getFavoriteCategory(),
      'averageOrderValue': _getAverageOrderValue(),
      'preferences': _userPreferences,
      'categoryDistribution': _categoryFrequency,
    };
  }

  String _getFavoriteCategory() {
    if (_categoryFrequency.isEmpty) return 'None';
    return _categoryFrequency.entries
        .reduce((a, b) => a.value > b.value ? a : b)
        .key;
  }

  double _getAverageOrderValue() {
    if (_orderHistory.isEmpty) return 0.0;
    return _orderHistory.map((item) => item.price).reduce((a, b) => a + b) / 
           _orderHistory.length;
  }
}
