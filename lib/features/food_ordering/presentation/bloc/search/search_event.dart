import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object?> get props => [];
}

class SearchRestaurants extends SearchEvent {
  final String query;
  final String? cuisineFilter;
  final double? minRating;
  final String? sortBy;

  const SearchRestaurants({
    required this.query,
    this.cuisineFilter,
    this.minRating,
    this.sortBy,
  });

  @override
  List<Object?> get props => [query, cuisineFilter, minRating, sortBy];
}

class ClearSearch extends SearchEvent {}

class UpdateFilters extends SearchEvent {
  final String? cuisineFilter;
  final double? minRating;
  final String? sortBy;

  const UpdateFilters({
    this.cuisineFilter,
    this.minRating,
    this.sortBy,
  });

  @override
  List<Object?> get props => [cuisineFilter, minRating, sortBy];
}
