import 'package:equatable/equatable.dart';
import 'food_item.dart';

class CartItem extends Equatable {
  final FoodItem foodItem;
  final int quantity;
  final String? specialInstructions;

  const CartItem({
    required this.foodItem,
    required this.quantity,
    this.specialInstructions,
  });

  double get totalPrice => foodItem.price * quantity;

  CartItem copyWith({
    FoodItem? foodItem,
    int? quantity,
    String? specialInstructions,
  }) {
    return CartItem(
      foodItem: foodItem ?? this.foodItem,
      quantity: quantity ?? this.quantity,
      specialInstructions: specialInstructions ?? this.specialInstructions,
    );
  }

  @override
  List<Object?> get props => [foodItem, quantity, specialInstructions];
}