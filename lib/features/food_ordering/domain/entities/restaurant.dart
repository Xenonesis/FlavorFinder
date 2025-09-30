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
    required this.imageUrl,
    required this.cuisine,
    required this.rating,
    required this.deliveryTime,
    required this.deliveryFee,
    required this.minimumOrder,
    required this.menu,
    required this.isOpen,
    required this.address,
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