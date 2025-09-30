import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/food_item.dart';
import '../../domain/entities/restaurant.dart';
import '../../data/services/ai_recommendation_service.dart';

// Events
abstract class RecommendationEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadRecommendations extends RecommendationEvent {
  final List<FoodItem> allItems;
  final List<Restaurant> restaurants;
  
  LoadRecommendations({required this.allItems, required this.restaurants});
  
  @override
  List<Object?> get props => [allItems, restaurants];
}

class UpdateUserPreferences extends RecommendationEvent {
  final Map<String, double> preferences;
  
  UpdateUserPreferences(this.preferences);
  
  @override
  List<Object?> get props => [preferences];
}

class AddToOrderHistory extends RecommendationEvent {
  final FoodItem item;
  
  AddToOrderHistory(this.item);
  
  @override
  List<Object?> get props => [item];
}

class GetSimilarItems extends RecommendationEvent {
  final FoodItem item;
  final List<FoodItem> allItems;
  
  GetSimilarItems({required this.item, required this.allItems});
  
  @override
  List<Object?> get props => [item, allItems];
}

// States
abstract class RecommendationState extends Equatable {
  @override
  List<Object?> get props => [];
}

class RecommendationInitial extends RecommendationState {}

class RecommendationLoading extends RecommendationState {}

class RecommendationLoaded extends RecommendationState {
  final List<FoodItem> recommendedItems;
  final List<Restaurant> recommendedRestaurants;
  final Map<String, dynamic> userInsights;
  
  RecommendationLoaded({
    required this.recommendedItems,
    required this.recommendedRestaurants,
    required this.userInsights,
  });
  
  @override
  List<Object?> get props => [recommendedItems, recommendedRestaurants, userInsights];
}

class SimilarItemsLoaded extends RecommendationState {
  final List<FoodItem> similarItems;
  
  SimilarItemsLoaded(this.similarItems);
  
  @override
  List<Object?> get props => [similarItems];
}

class RecommendationError extends RecommendationState {
  final String message;
  
  RecommendationError(this.message);
  
  @override
  List<Object?> get props => [message];
}

// BLoC
class RecommendationBloc extends Bloc<RecommendationEvent, RecommendationState> {
  final AIRecommendationService _aiService;
  
  RecommendationBloc({AIRecommendationService? aiService})
      : _aiService = aiService ?? AIRecommendationService(),
        super(RecommendationInitial()) {
    
    on<LoadRecommendations>(_onLoadRecommendations);
    on<UpdateUserPreferences>(_onUpdateUserPreferences);
    on<AddToOrderHistory>(_onAddToOrderHistory);
    on<GetSimilarItems>(_onGetSimilarItems);
  }
  
  Future<void> _onLoadRecommendations(
    LoadRecommendations event,
    Emitter<RecommendationState> emit,
  ) async {
    try {
      emit(RecommendationLoading());
      
      final recommendedItems = _aiService.getPersonalizedRecommendations(
        event.allItems,
        limit: 10,
      );
      
      final recommendedRestaurants = _aiService.getRecommendedRestaurants(
        event.restaurants,
        null, // Current location would be passed here
      );
      
      final userInsights = _aiService.getUserInsights();
      
      emit(RecommendationLoaded(
        recommendedItems: recommendedItems,
        recommendedRestaurants: recommendedRestaurants,
        userInsights: userInsights,
      ));
    } catch (e) {
      emit(RecommendationError('Failed to load recommendations: $e'));
    }
  }
  
  Future<void> _onUpdateUserPreferences(
    UpdateUserPreferences event,
    Emitter<RecommendationState> emit,
  ) async {
    try {
      _aiService.updateUserPreferences(event.preferences);
      // Optionally reload recommendations after updating preferences
    } catch (e) {
      emit(RecommendationError('Failed to update preferences: $e'));
    }
  }
  
  Future<void> _onAddToOrderHistory(
    AddToOrderHistory event,
    Emitter<RecommendationState> emit,
  ) async {
    try {
      _aiService.addToOrderHistory(event.item);
    } catch (e) {
      emit(RecommendationError('Failed to add to order history: $e'));
    }
  }
  
  Future<void> _onGetSimilarItems(
    GetSimilarItems event,
    Emitter<RecommendationState> emit,
  ) async {
    try {
      emit(RecommendationLoading());
      
      final similarItems = _aiService.getSimilarItems(event.item, event.allItems);
      
      emit(SimilarItemsLoaded(similarItems));
    } catch (e) {
      emit(RecommendationError('Failed to get similar items: $e'));
    }
  }
}
