import '../../domain/entities/restaurant.dart';
import '../../domain/entities/food_item.dart';
import 'enhanced_mock_data_source.dart';
import 'food_categories_data.dart';
import 'restaurant_specialties_data.dart';

class MockDataSource {
  static List<Restaurant> getRestaurants() {
    return EnhancedMockDataSource.getRestaurants();
  }

  static List<FoodItem> getFoodItems() {
    final mainItems = EnhancedMockDataSource.getAllFoodItems();
    final categoryItems = FoodCategoriesData.getAllCategorizedItems()
        .values
        .expand((items) => items)
        .toList();
    
    return [...mainItems, ...categoryItems];
  }

  static List<FoodItem> getFoodItemsByRestaurant(String restaurantId) {
    final restaurantMenus = RestaurantSpecialtiesData.getRestaurantMenus();
    return restaurantMenus[restaurantId] ?? [];
  }

  static List<FoodItem> getFoodItemsByCategory(String category) {
    final allItems = getFoodItems();
    return allItems.where((item) => item.category == category).toList();
  }

  static List<String> getAvailableCategories() {
    return [
      'Pizza',
      'Burgers',
      'Sushi',
      'Main Course',
      'Appetizers',
      'Desserts',
      'Beverages',
      'Salads',
      'Soups',
      'Snacks',
      'Breakfast',
      'Mexican',
      'Bowls',
      'Tacos',
      'Noodles',
      'Rice',
      'Sandwiches',
      'Sides',
      'Bread',
      'Sashimi',
    ];
  }

  static List<String> getAvailableCuisines() {
    return [
      'Italian',
      'Chinese',
      'Japanese',
      'Thai',
      'American',
      'Indian',
      'Mexican',
      'Mediterranean',
      'Middle Eastern',
      'Healthy',
      'Vegetarian',
      'Desserts',
      'Coffee & Tea',
      'French',
      'Seafood',
    ];
  }

  static List<FoodItem> getPopularItems() {
    final allItems = getFoodItems();
    allItems.sort((a, b) => b.rating.compareTo(a.rating));
    return allItems.take(10).toList();
  }

  static List<Restaurant> getPopularRestaurants() {
    final restaurants = getRestaurants();
    restaurants.sort((a, b) => b.rating.compareTo(a.rating));
    return restaurants.take(8).toList();
  }

  static List<FoodItem> searchFoodItems(String query) {
    final allItems = getFoodItems();
    final queryLower = query.toLowerCase();
    
    return allItems.where((item) {
      return item.name.toLowerCase().contains(queryLower) ||
             item.description.toLowerCase().contains(queryLower) ||
             item.category.toLowerCase().contains(queryLower);
    }).toList();
  }

  static List<Restaurant> searchRestaurants(String query) {
    final restaurants = getRestaurants();
    final queryLower = query.toLowerCase();
    
    return restaurants.where((restaurant) {
      return restaurant.name.toLowerCase().contains(queryLower) ||
             restaurant.cuisine.toLowerCase().contains(queryLower);
    }).toList();
  }
}
