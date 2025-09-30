import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/food_item.dart';
import '../../domain/entities/restaurant.dart';
import '../../data/services/advanced_search_service.dart';

// Events
abstract class SearchEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SearchFoodItems extends SearchEvent {
  final String query;
  final List<FoodItem> items;
  final SearchFilters? filters;

  SearchFoodItems({
    required this.query,
    required this.items,
    this.filters,
  });

  @override
  List<Object?> get props => [query, items, filters];
}

class SearchRestaurants extends SearchEvent {
  final String query;
  final List<Restaurant> restaurants;
  final SearchFilters? filters;

  SearchRestaurants({
    required this.query,
    required this.restaurants,
    this.filters,
  });

  @override
  List<Object?> get props => [query, restaurants, filters];
}

class StartVoiceSearch extends SearchEvent {}

class StopVoiceSearch extends SearchEvent {}

class LoadSearchSuggestions extends SearchEvent {
  final String query;

  LoadSearchSuggestions(this.query);

  @override
  List<Object?> get props => [query];
}

class LoadTrendingSearches extends SearchEvent {}

class ClearSearchHistory extends SearchEvent {}

class UpdateSearchFilters extends SearchEvent {
  final SearchFilters filters;

  UpdateSearchFilters(this.filters);

  @override
  List<Object?> get props => [filters];
}

// States
abstract class SearchState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class FoodItemSearchResults extends SearchState {
  final List<SearchResult<FoodItem>> results;
  final String query;
  final SearchFilters? appliedFilters;

  FoodItemSearchResults({
    required this.results,
    required this.query,
    this.appliedFilters,
  });

  @override
  List<Object?> get props => [results, query, appliedFilters];
}

class RestaurantSearchResults extends SearchState {
  final List<SearchResult<Restaurant>> results;
  final String query;
  final SearchFilters? appliedFilters;

  RestaurantSearchResults({
    required this.results,
    required this.query,
    this.appliedFilters,
  });

  @override
  List<Object?> get props => [results, query, appliedFilters];
}

class VoiceSearchListening extends SearchState {}

class VoiceSearchResult extends SearchState {
  final String recognizedText;

  VoiceSearchResult(this.recognizedText);

  @override
  List<Object?> get props => [recognizedText];
}

class SearchSuggestionsLoaded extends SearchState {
  final List<String> suggestions;
  final String query;

  SearchSuggestionsLoaded({
    required this.suggestions,
    required this.query,
  });

  @override
  List<Object?> get props => [suggestions, query];
}

class TrendingSearchesLoaded extends SearchState {
  final List<String> trendingSearches;

  TrendingSearchesLoaded(this.trendingSearches);

  @override
  List<Object?> get props => [trendingSearches];
}

class SearchError extends SearchState {
  final String message;

  SearchError(this.message);

  @override
  List<Object?> get props => [message];
}

// BLoC
class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final AdvancedSearchService _searchService;
  SearchFilters? _currentFilters;

  SearchBloc({AdvancedSearchService? searchService})
      : _searchService = searchService ?? AdvancedSearchService(),
        super(SearchInitial()) {
    
    on<SearchFoodItems>(_onSearchFoodItems);
    on<SearchRestaurants>(_onSearchRestaurants);
    on<StartVoiceSearch>(_onStartVoiceSearch);
    on<StopVoiceSearch>(_onStopVoiceSearch);
    on<LoadSearchSuggestions>(_onLoadSearchSuggestions);
    on<LoadTrendingSearches>(_onLoadTrendingSearches);
    on<ClearSearchHistory>(_onClearSearchHistory);
    on<UpdateSearchFilters>(_onUpdateSearchFilters);

    _initializeSearchService();
  }

  Future<void> _initializeSearchService() async {
    await _searchService.initializeSpeech();
  }

  Future<void> _onSearchFoodItems(
    SearchFoodItems event,
    Emitter<SearchState> emit,
  ) async {
    try {
      emit(SearchLoading());

      final filters = event.filters ?? _currentFilters;
      final results = _searchService.searchFoodItems(
        event.query,
        event.items,
        filters: filters,
      );

      emit(FoodItemSearchResults(
        results: results,
        query: event.query,
        appliedFilters: filters,
      ));
    } catch (e) {
      emit(SearchError('Failed to search food items: $e'));
    }
  }

  Future<void> _onSearchRestaurants(
    SearchRestaurants event,
    Emitter<SearchState> emit,
  ) async {
    try {
      emit(SearchLoading());

      final filters = event.filters ?? _currentFilters;
      final results = _searchService.searchRestaurants(
        event.query,
        event.restaurants,
        filters: filters,
      );

      emit(RestaurantSearchResults(
        results: results,
        query: event.query,
        appliedFilters: filters,
      ));
    } catch (e) {
      emit(SearchError('Failed to search restaurants: $e'));
    }
  }

  Future<void> _onStartVoiceSearch(
    StartVoiceSearch event,
    Emitter<SearchState> emit,
  ) async {
    try {
      if (!_searchService.isSpeechEnabled) {
        emit(SearchError('Voice search is not available'));
        return;
      }

      emit(VoiceSearchListening());

      final recognizedText = await _searchService.startVoiceSearch();

      if (recognizedText != null && recognizedText.isNotEmpty) {
        emit(VoiceSearchResult(recognizedText));
      } else {
        emit(SearchError('No speech recognized'));
      }
    } catch (e) {
      emit(SearchError('Voice search failed: $e'));
    }
  }

  Future<void> _onStopVoiceSearch(
    StopVoiceSearch event,
    Emitter<SearchState> emit,
  ) async {
    try {
      _searchService.stopVoiceSearch();
      emit(SearchInitial());
    } catch (e) {
      emit(SearchError('Failed to stop voice search: $e'));
    }
  }

  Future<void> _onLoadSearchSuggestions(
    LoadSearchSuggestions event,
    Emitter<SearchState> emit,
  ) async {
    try {
      final suggestions = _searchService.getSearchSuggestions(event.query);
      
      emit(SearchSuggestionsLoaded(
        suggestions: suggestions,
        query: event.query,
      ));
    } catch (e) {
      emit(SearchError('Failed to load suggestions: $e'));
    }
  }

  Future<void> _onLoadTrendingSearches(
    LoadTrendingSearches event,
    Emitter<SearchState> emit,
  ) async {
    try {
      final trendingSearches = _searchService.getTrendingSearches();
      emit(TrendingSearchesLoaded(trendingSearches));
    } catch (e) {
      emit(SearchError('Failed to load trending searches: $e'));
    }
  }

  Future<void> _onClearSearchHistory(
    ClearSearchHistory event,
    Emitter<SearchState> emit,
  ) async {
    try {
      _searchService.clearSearchHistory();
      emit(SearchInitial());
    } catch (e) {
      emit(SearchError('Failed to clear search history: $e'));
    }
  }

  Future<void> _onUpdateSearchFilters(
    UpdateSearchFilters event,
    Emitter<SearchState> emit,
  ) async {
    _currentFilters = event.filters;
    // Optionally re-run the last search with new filters
  }

  SearchFilters? get currentFilters => _currentFilters;
}
