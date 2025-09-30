import 'package:equatable/equatable.dart';
import '../../../domain/entities/cart_item.dart';
import '../../../domain/entities/food_item.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object?> get props => [];
}

class AddToCart extends CartEvent {
  final FoodItem foodItem;
  final int quantity;
  final String? specialInstructions;

  const AddToCart({
    required this.foodItem,
    this.quantity = 1,
    this.specialInstructions,
  });

  @override
  List<Object?> get props => [foodItem, quantity, specialInstructions];
}

class RemoveFromCart extends CartEvent {
  final String foodItemId;

  const RemoveFromCart({required this.foodItemId});

  @override
  List<Object> get props => [foodItemId];
}

class UpdateCartItemQuantity extends CartEvent {
  final String foodItemId;
  final int quantity;

  const UpdateCartItemQuantity({
    required this.foodItemId,
    required this.quantity,
  });

  @override
  List<Object> get props => [foodItemId, quantity];
}

class UpdateCartItemInstructions extends CartEvent {
  final String foodItemId;
  final String? specialInstructions;

  const UpdateCartItemInstructions({
    required this.foodItemId,
    this.specialInstructions,
  });

  @override
  List<Object?> get props => [foodItemId, specialInstructions];
}

class ClearCart extends CartEvent {}