import 'package:shared_preferences/shared_preferences.dart';

class FavoritesService {
  static const String _favoritesKey = 'favorite_restaurants';

  Future<List<String>> getFavoriteRestaurantIds() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_favoritesKey) ?? [];
  }

  Future<void> addToFavorites(String restaurantId) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = await getFavoriteRestaurantIds();
    
    if (!favorites.contains(restaurantId)) {
      favorites.add(restaurantId);
      await prefs.setStringList(_favoritesKey, favorites);
    }
  }

  Future<void> removeFromFavorites(String restaurantId) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = await getFavoriteRestaurantIds();
    
    favorites.remove(restaurantId);
    await prefs.setStringList(_favoritesKey, favorites);
  }

  Future<bool> isFavorite(String restaurantId) async {
    final favorites = await getFavoriteRestaurantIds();
    return favorites.contains(restaurantId);
  }

  Future<void> clearFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_favoritesKey);
  }
}
