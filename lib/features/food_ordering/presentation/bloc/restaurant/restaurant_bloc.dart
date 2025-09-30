import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repositories/restaurant_repository.dart';
import 'restaurant_event.dart';
import 'restaurant_state.dart';

class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  final RestaurantRepository repository;

  RestaurantBloc({required this.repository}) : super(RestaurantInitial()) {
    on<LoadRestaurants>(_onLoadRestaurants);
    on<RefreshRestaurants>(_onRefreshRestaurants);
  }

  Future<void> _onLoadRestaurants(
    LoadRestaurants event,
    Emitter<RestaurantState> emit,
  ) async {
    emit(RestaurantLoading());
    try {
      final restaurants = await repository.getRestaurants();
      emit(RestaurantLoaded(restaurants: restaurants));
    } catch (e) {
      emit(RestaurantError(message: e.toString()));
    }
  }

  Future<void> _onRefreshRestaurants(
    RefreshRestaurants event,
    Emitter<RestaurantState> emit,
  ) async {
    try {
      final restaurants = await repository.getRestaurants();
      emit(RestaurantLoaded(restaurants: restaurants));
    } catch (e) {
      emit(RestaurantError(message: e.toString()));
    }
  }
}