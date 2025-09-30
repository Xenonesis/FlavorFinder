import 'package:equatable/equatable.dart';
import '../../../domain/entities/restaurant.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object?> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final List<Restaurant> restaurants;
  final String query;
  final String? cuisineFilter;
  final double? minRating;
  final String? sortBy;

  const SearchLoaded({
    required this.restaurants,
    required this.query,
    this.cuisineFilter,
    this.minRating,
    this.sortBy,
  });

  @override
  List<Object?> get props => [restaurants, query, cuisineFilter, minRating, sortBy];
}

class SearchError extends SearchState {
  final String message;

  const SearchError(this.message);

  @override
  List<Object> get props => [message];
}
