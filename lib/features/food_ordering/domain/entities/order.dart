import 'package:equatable/equatable.dart';
import 'cart_item.dart';
import 'restaurant.dart';

enum OrderStatus {
  pending,
  confirmed,
  preparing,
  outForDelivery,
  delivered,
  cancelled,
}

class Order extends Equatable {
  final String id;
  final Restaurant restaurant;
  final List<CartItem> items;
  final double subtotal;
  final double deliveryFee;
  final double tax;
  final double total;
  final OrderStatus status;
  final DateTime orderTime;
  final String deliveryAddress;
  final String? specialInstructions;
  final int estimatedDeliveryTime;

  const Order({
    required this.id,
    required this.restaurant,
    required this.items,
    required this.subtotal,
    required this.deliveryFee,
    required this.tax,
    required this.total,
    required this.status,
    required this.orderTime,
    required this.deliveryAddress,
    this.specialInstructions,
    required this.estimatedDeliveryTime,
  });

  Order copyWith({
    String? id,
    Restaurant? restaurant,
    List<CartItem>? items,
    double? subtotal,
    double? deliveryFee,
    double? tax,
    double? total,
    OrderStatus? status,
    DateTime? orderTime,
    String? deliveryAddress,
    String? specialInstructions,
    int? estimatedDeliveryTime,
  }) {
    return Order(
      id: id ?? this.id,
      restaurant: restaurant ?? this.restaurant,
      items: items ?? this.items,
      subtotal: subtotal ?? this.subtotal,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      tax: tax ?? this.tax,
      total: total ?? this.total,
      status: status ?? this.status,
      orderTime: orderTime ?? this.orderTime,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      specialInstructions: specialInstructions ?? this.specialInstructions,
      estimatedDeliveryTime: estimatedDeliveryTime ?? this.estimatedDeliveryTime,
    );
  }

  @override
  List<Object?> get props => [
        id,
        restaurant,
        items,
        subtotal,
        deliveryFee,
        tax,
        total,
        status,
        orderTime,
        deliveryAddress,
        specialInstructions,
        estimatedDeliveryTime,
      ];
}