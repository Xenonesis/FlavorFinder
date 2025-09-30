import 'package:equatable/equatable.dart';
import '../../../domain/entities/cart_item.dart';

class CartState extends Equatable {
  final List<CartItem> items;
  final double subtotal;
  final int totalItems;

  const CartState({
    this.items = const [],
    this.subtotal = 0.0,
    this.totalItems = 0,
  });

  double get totalPrice => items.fold(0.0, (sum, item) => sum + item.totalPrice);

  CartState copyWith({
    List<CartItem>? items,
    double? subtotal,
    int? totalItems,
  }) {
    return CartState(
      items: items ?? this.items,
      subtotal: subtotal ?? this.subtotal,
      totalItems: totalItems ?? this.totalItems,
    );
  }

  @override
  List<Object> get props => [items, subtotal, totalItems];
}
