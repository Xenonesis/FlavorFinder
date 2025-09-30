import 'package:equatable/equatable.dart';
import 'food_item.dart';

class Restaurant extends Equatable {
  final String id;
  final String name;
  final String imageUrl;
  final String cuisine;
  final double rating;
  final int deliveryTime;
  final double deliveryFee;
  final double minimumOrder;
  final List<FoodItem> menu;
  final bool isOpen;
  final String address;

  const Restaurant({
    required this.id,
    required this.name,
    this.imageUrl = '',
    required this.cuisine,
    required this.rating,
    required this.deliveryTime,
    required this.deliveryFee,
    this.minimumOrder = 0.0,
    this.menu = const [],
    this.isOpen = true,
    this.address = '',
  });

  @override
  List<Object?> get props => [
        id,
        name,
        imageUrl,
        cuisine,
        rating,
        deliveryTime,
        deliveryFee,
        minimumOrder,
        menu,
        isOpen,
        address,
      ];
}
