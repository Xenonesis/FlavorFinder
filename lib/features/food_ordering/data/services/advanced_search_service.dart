import 'dart:async';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import '../../domain/entities/food_item.dart';
import '../../domain/entities/restaurant.dart';

class SearchFilters {
  final double? minPrice;
  final double? maxPrice;
  final double? minRating;
  final List<String>? categories;
  final List<String>? cuisines;
  final bool? isVegetarian;
  final bool? isVegan;
  final bool? isGlutenFree;
  final int? maxDeliveryTime;
  final String? sortBy; // 'price', 'rating', 'delivery_time', 'popularity'
  final bool? ascending;

  SearchFilters({
    this.minPrice,
    this.maxPrice,
    this.minRating,
    this.categories,
    this.cuisines,
    this.isVegetarian,
    this.isVegan,
    this.isGlutenFree,
    this.maxDeliveryTime,
    this.sortBy,
    this.ascending,
  });

  SearchFilters copyWith({
    double? minPrice,
    double? maxPrice,
    double? minRating,
    List<String>? categories,
    List<String>? cuisines,
    bool? isVegetarian,
    bool? isVegan,
    bool? isGlutenFree,
    int? maxDeliveryTime,
    String? sortBy,
    bool? ascending,
  }) {
    return SearchFilters(
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      minRating: minRating ?? this.minRating,
      categories: categories ?? this.categories,
      cuisines: cuisines ?? this.cuisines,
      isVegetarian: isVegetarian ?? this.isVegetarian,
      isVegan: isVegan ?? this.isVegan,
      isGlutenFree: isGlutenFree ?? this.isGlutenFree,
      maxDeliveryTime: maxDeliveryTime ?? this.maxDeliveryTime,
      sortBy: sortBy ?? this.sortBy,
      ascending: ascending ?? this.ascending,
    );
  }
}

class SearchResult<T> {
  final T item;
  final double relevanceScore;
  final List<String> matchedTerms;

  SearchResult({
    required this.item,
    required this.relevanceScore,
    required this.matchedTerms,
  });
}

class AdvancedSearchService {
  static final AdvancedSearchService _instance = AdvancedSearchService._internal();
  factory AdvancedSearchService() => _instance;
  AdvancedSearchService._internal();

  final stt.SpeechToText _speechToText = stt.SpeechToText();
  bool _speechEnabled = false;
  
  // Search history and suggestions
  final List<String> _searchHistory = [];
  final Map<String, int> _searchFrequency = {};

  Future<void> initializeSpeech() async {
    _speechEnabled = await _speechToText.initialize();
  }

  Future<String?> startVoiceSearch() async {
    if (!_speechEnabled) {
      await initializeSpeech();
    }

    if (!_speechEnabled) return null;

    final completer = Completer<String?>();
    String recognizedText = '';

    await _speechToText.listen(
      onResult: (result) {
        recognizedText = result.recognizedWords;
        if (result.finalResult) {
          completer.complete(recognizedText.isNotEmpty ? recognizedText : null);
        }
      },
      listenFor: Duration(seconds: 10),
      pauseFor: Duration(seconds: 3),
    );

    return completer.future;
  }

  void stopVoiceSearch() {
    _speechToText.stop();
  }

  List<SearchResult<FoodItem>> searchFoodItems(
    String query,
    List<FoodItem> items, {
    SearchFilters? filters,
  }) {
    if (query.isEmpty && filters == null) return [];

    _addToSearchHistory(query);

    List<SearchResult<FoodItem>> results = [];

    for (final item in items) {
      if (!_passesFilters(item, filters)) continue;

      final score = _calculateFoodItemRelevance(query, item);
      if (score > 0) {
        results.add(SearchResult(
          item: item,
          relevanceScore: score,
          matchedTerms: _getMatchedTerms(query, item),
        ));
      }
    }

    // Sort by relevance score
    results.sort((a, b) => b.relevanceScore.compareTo(a.relevanceScore));

    // Apply sorting if specified
    if (filters?.sortBy != null) {
      results = _applySorting(results, filters!);
    }

    return results;
  }

  List<SearchResult<Restaurant>> searchRestaurants(
    String query,
    List<Restaurant> restaurants, {
    SearchFilters? filters,
  }) {
    if (query.isEmpty && filters == null) return [];

    _addToSearchHistory(query);

    List<SearchResult<Restaurant>> results = [];

    for (final restaurant in restaurants) {
      if (!_passesRestaurantFilters(restaurant, filters)) continue;

      final score = _calculateRestaurantRelevance(query, restaurant);
      if (score > 0) {
        results.add(SearchResult(
          item: restaurant,
          relevanceScore: score,
          matchedTerms: _getRestaurantMatchedTerms(query, restaurant),
        ));
      }
    }

    results.sort((a, b) => b.relevanceScore.compareTo(a.relevanceScore));
    return results;
  }

  bool _passesFilters(FoodItem item, SearchFilters? filters) {
    if (filters == null) return true;

    if (filters.minPrice != null && item.price < filters.minPrice!) return false;
    if (filters.maxPrice != null && item.price > filters.maxPrice!) return false;
    if (filters.minRating != null && item.rating < filters.minRating!) return false;
    
    if (filters.categories != null && 
        !filters.categories!.contains(item.category)) return false;

    if (filters.isVegetarian == true && !_isVegetarian(item)) return false;
    if (filters.isVegan == true && !_isVegan(item)) return false;
    if (filters.isGlutenFree == true && !_isGlutenFree(item)) return false;

    return true;
  }

  bool _passesRestaurantFilters(Restaurant restaurant, SearchFilters? filters) {
    if (filters == null) return true;

    if (filters.minRating != null && restaurant.rating < filters.minRating!) return false;
    if (filters.maxDeliveryTime != null && 
        restaurant.deliveryTime > filters.maxDeliveryTime!) return false;

    if (filters.cuisines != null && 
        !filters.cuisines!.contains(restaurant.cuisine)) return false;

    return true;
  }

  double _calculateFoodItemRelevance(String query, FoodItem item) {
    if (query.isEmpty) return 1.0;

    double score = 0.0;
    final queryLower = query.toLowerCase();
    final terms = queryLower.split(' ').where((term) => term.isNotEmpty).toList();

    // Exact name match
    if (item.name.toLowerCase() == queryLower) {
      score += 10.0;
    }

    // Name contains query
    if (item.name.toLowerCase().contains(queryLower)) {
      score += 5.0;
    }

    // Individual term matches
    for (final term in terms) {
      if (item.name.toLowerCase().contains(term)) score += 2.0;
      if (item.description.toLowerCase().contains(term)) score += 1.0;
      if (item.category.toLowerCase().contains(term)) score += 1.5;
    }

    // Boost popular items
    score += item.rating * 0.5;

    return score;
  }

  double _calculateRestaurantRelevance(String query, Restaurant restaurant) {
    if (query.isEmpty) return 1.0;

    double score = 0.0;
    final queryLower = query.toLowerCase();
    final terms = queryLower.split(' ').where((term) => term.isNotEmpty).toList();

    // Exact name match
    if (restaurant.name.toLowerCase() == queryLower) {
      score += 10.0;
    }

    // Name contains query
    if (restaurant.name.toLowerCase().contains(queryLower)) {
      score += 5.0;
    }

    // Individual term matches
    for (final term in terms) {
      if (restaurant.name.toLowerCase().contains(term)) score += 2.0;
      if (restaurant.cuisine.toLowerCase().contains(term)) score += 1.5;
    }

    // Boost highly rated restaurants
    score += restaurant.rating * 0.5;

    return score;
  }

  List<String> _getMatchedTerms(String query, FoodItem item) {
    final terms = query.toLowerCase().split(' ').where((term) => term.isNotEmpty).toList();
    final matched = <String>[];

    for (final term in terms) {
      if (item.name.toLowerCase().contains(term) ||
          item.description.toLowerCase().contains(term) ||
          item.category.toLowerCase().contains(term)) {
        matched.add(term);
      }
    }

    return matched;
  }

  List<String> _getRestaurantMatchedTerms(String query, Restaurant restaurant) {
    final terms = query.toLowerCase().split(' ').where((term) => term.isNotEmpty).toList();
    final matched = <String>[];

    for (final term in terms) {
      if (restaurant.name.toLowerCase().contains(term) ||
          restaurant.cuisine.toLowerCase().contains(term)) {
        matched.add(term);
      }
    }

    return matched;
  }

  List<SearchResult<FoodItem>> _applySorting(
    List<SearchResult<FoodItem>> results,
    SearchFilters filters,
  ) {
    switch (filters.sortBy) {
      case 'price':
        results.sort((a, b) {
          final comparison = a.item.price.compareTo(b.item.price);
          return filters.ascending == true ? comparison : -comparison;
        });
        break;
      case 'rating':
        results.sort((a, b) {
          final comparison = a.item.rating.compareTo(b.item.rating);
          return filters.ascending == true ? comparison : -comparison;
        });
        break;
      case 'popularity':
        // Keep relevance score sorting for popularity
        break;
    }

    return results;
  }

  bool _isVegetarian(FoodItem item) {
    final vegKeywords = ['vegetarian', 'veggie', 'veg'];
    return vegKeywords.any((keyword) => 
      item.name.toLowerCase().contains(keyword) ||
      item.description.toLowerCase().contains(keyword)
    );
  }

  bool _isVegan(FoodItem item) {
    final veganKeywords = ['vegan', 'plant-based'];
    return veganKeywords.any((keyword) => 
      item.name.toLowerCase().contains(keyword) ||
      item.description.toLowerCase().contains(keyword)
    );
  }

  bool _isGlutenFree(FoodItem item) {
    final gfKeywords = ['gluten-free', 'gluten free', 'gf'];
    return gfKeywords.any((keyword) => 
      item.name.toLowerCase().contains(keyword) ||
      item.description.toLowerCase().contains(keyword)
    );
  }

  void _addToSearchHistory(String query) {
    if (query.isEmpty) return;

    _searchHistory.insert(0, query);
    if (_searchHistory.length > 50) {
      _searchHistory.removeLast();
    }

    _searchFrequency[query] = (_searchFrequency[query] ?? 0) + 1;
  }

  List<String> getSearchSuggestions(String query) {
    if (query.isEmpty) {
      return _searchHistory.take(5).toList();
    }

    final suggestions = <String>[];
    
    // Add matching history items
    for (final historyItem in _searchHistory) {
      if (historyItem.toLowerCase().contains(query.toLowerCase()) &&
          !suggestions.contains(historyItem)) {
        suggestions.add(historyItem);
      }
    }

    // Add popular searches that match
    final popularSearches = _searchFrequency.entries
        .where((entry) => entry.key.toLowerCase().contains(query.toLowerCase()))
        .toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    for (final entry in popularSearches) {
      if (!suggestions.contains(entry.key)) {
        suggestions.add(entry.key);
      }
    }

    return suggestions.take(8).toList();
  }

  List<String> getTrendingSearches() {
    final trending = _searchFrequency.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    
    return trending.take(10).map((e) => e.key).toList();
  }

  void clearSearchHistory() {
    _searchHistory.clear();
    _searchFrequency.clear();
  }

  bool get isSpeechEnabled => _speechEnabled;
}
