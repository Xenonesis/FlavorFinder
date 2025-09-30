import 'package:equatable/equatable.dart';

class FavoritesState extends Equatable {
  final List<String> favoriteRestaurantIds;
  final bool isLoading;

  const FavoritesState({
    this.favoriteRestaurantIds = const [],
    this.isLoading = false,
  });

  FavoritesState copyWith({
    List<String>? favoriteRestaurantIds,
    bool? isLoading,
  }) {
    return FavoritesState(
      favoriteRestaurantIds: favoriteRestaurantIds ?? this.favoriteRestaurantIds,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  bool isFavorite(String restaurantId) {
    return favoriteRestaurantIds.contains(restaurantId);
  }

  @override
  List<Object> get props => [favoriteRestaurantIds, isLoading];
}
