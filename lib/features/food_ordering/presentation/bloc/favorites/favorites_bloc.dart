import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/services/favorites_service.dart';
import 'favorites_event.dart';
import 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final FavoritesService _favoritesService;

  FavoritesBloc({required FavoritesService favoritesService})
      : _favoritesService = favoritesService,
        super(const FavoritesState()) {
    on<LoadFavorites>(_onLoadFavorites);
    on<ToggleFavorite>(_onToggleFavorite);
    on<ClearAllFavorites>(_onClearAllFavorites);
  }

  Future<void> _onLoadFavorites(
    LoadFavorites event,
    Emitter<FavoritesState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    
    try {
      final favoriteIds = await _favoritesService.getFavoriteRestaurantIds();
      emit(state.copyWith(
        favoriteRestaurantIds: favoriteIds,
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> _onToggleFavorite(
    ToggleFavorite event,
    Emitter<FavoritesState> emit,
  ) async {
    final isFavorite = state.isFavorite(event.restaurantId);
    
    try {
      if (isFavorite) {
        await _favoritesService.removeFromFavorites(event.restaurantId);
        final updatedFavorites = List<String>.from(state.favoriteRestaurantIds)
          ..remove(event.restaurantId);
        emit(state.copyWith(favoriteRestaurantIds: updatedFavorites));
      } else {
        await _favoritesService.addToFavorites(event.restaurantId);
        final updatedFavorites = List<String>.from(state.favoriteRestaurantIds)
          ..add(event.restaurantId);
        emit(state.copyWith(favoriteRestaurantIds: updatedFavorites));
      }
    } catch (e) {
      // Handle error silently or emit error state if needed
    }
  }

  Future<void> _onClearAllFavorites(
    ClearAllFavorites event,
    Emitter<FavoritesState> emit,
  ) async {
    try {
      await _favoritesService.clearFavorites();
      emit(state.copyWith(favoriteRestaurantIds: []));
    } catch (e) {
      // Handle error silently or emit error state if needed
    }
  }
}
