import 'package:equatable/equatable.dart';

class FoodItem extends Equatable {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String category;
  final bool isVegetarian;
  final bool isSpicy;
  final List<String> allergens;
  final int preparationTime;
  final bool isAvailable;
  final double rating;

  const FoodItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.category,
    this.isVegetarian = false,
    this.isSpicy = false,
    this.allergens = const [],
    this.preparationTime = 15,
    this.isAvailable = true,
    this.rating = 0.0,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        price,
        imageUrl,
        category,
        isVegetarian,
        isSpicy,
        allergens,
        preparationTime,
        isAvailable,
        rating,
      ];
}