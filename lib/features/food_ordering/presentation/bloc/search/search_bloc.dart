import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repositories/restaurant_repository.dart';
import '../../../domain/entities/restaurant.dart';
import 'search_event.dart';
import 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final RestaurantRepository repository;

  SearchBloc({required this.repository}) : super(SearchInitial()) {
    on<SearchRestaurants>(_onSearchRestaurants);
    on<ClearSearch>(_onClearSearch);
    on<UpdateFilters>(_onUpdateFilters);
  }

  Future<void> _onSearchRestaurants(
    SearchRestaurants event,
    Emitter<SearchState> emit,
  ) async {
    emit(SearchLoading());
    
    try {
      final restaurants = await repository.getRestaurants();
      final filteredRestaurants = _filterRestaurants(
        restaurants,
        event.query,
        event.cuisineFilter,
        event.minRating,
        event.sortBy,
      );

      emit(SearchLoaded(
        restaurants: filteredRestaurants,
        query: event.query,
        cuisineFilter: event.cuisineFilter,
        minRating: event.minRating,
        sortBy: event.sortBy,
      ));
    } catch (e) {
      emit(SearchError('Failed to search restaurants: ${e.toString()}'));
    }
  }

  void _onClearSearch(ClearSearch event, Emitter<SearchState> emit) {
    emit(SearchInitial());
  }

  Future<void> _onUpdateFilters(
    UpdateFilters event,
    Emitter<SearchState> emit,
  ) async {
    if (state is SearchLoaded) {
      final currentState = state as SearchLoaded;
      
      add(SearchRestaurants(
        query: currentState.query,
        cuisineFilter: event.cuisineFilter ?? currentState.cuisineFilter,
        minRating: event.minRating ?? currentState.minRating,
        sortBy: event.sortBy ?? currentState.sortBy,
      ));
    }
  }

  List<Restaurant> _filterRestaurants(
    List<Restaurant> restaurants,
    String query,
    String? cuisineFilter,
    double? minRating,
    String? sortBy,
  ) {
    var filtered = restaurants.where((restaurant) {
      final matchesQuery = query.isEmpty ||
          restaurant.name.toLowerCase().contains(query.toLowerCase()) ||
          restaurant.cuisine.toLowerCase().contains(query.toLowerCase());
      
      final matchesCuisine = cuisineFilter == null ||
          restaurant.cuisine.toLowerCase() == cuisineFilter.toLowerCase();
      
      final matchesRating = minRating == null || restaurant.rating >= minRating;

      return matchesQuery && matchesCuisine && matchesRating;
    }).toList();

    // Sort results
    if (sortBy != null) {
      switch (sortBy) {
        case 'rating':
          filtered.sort((a, b) => b.rating.compareTo(a.rating));
          break;
        case 'delivery_time':
          filtered.sort((a, b) => a.deliveryTime.compareTo(b.deliveryTime));
          break;
        case 'delivery_fee':
          filtered.sort((a, b) => a.deliveryFee.compareTo(b.deliveryFee));
          break;
        case 'name':
          filtered.sort((a, b) => a.name.compareTo(b.name));
          break;
      }
    }

    return filtered;
  }
}
