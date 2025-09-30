import 'package:equatable/equatable.dart';

abstract class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object> get props => [];
}

class LoadFavorites extends FavoritesEvent {}

class ToggleFavorite extends FavoritesEvent {
  final String restaurantId;

  const ToggleFavorite(this.restaurantId);

  @override
  List<Object> get props => [restaurantId];
}

class ClearAllFavorites extends FavoritesEvent {}
