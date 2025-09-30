import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../domain/entities/food_item.dart';
import 'add_to_cart_dialog.dart';
import '../../../../core/theme/app_theme.dart';

class FoodItemCard extends StatelessWidget {
  final FoodItem foodItem;
  final Function(int quantity, String? instructions) onAddToCart;

  const FoodItemCard({
    super.key,
    required this.foodItem,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      if (foodItem.isVegetarian)
                        Container(
                          width: 16,
                          height: 16,
                          margin: const EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                            color: AppTheme.successColor,
                            borderRadius: BorderRadius.circular(2),
                          ),
                          child: const Icon(
                            Icons.circle,
                            color: Colors.white,
                            size: 8,
                          ),
                        ),
                      if (foodItem.isSpicy)
                        Container(
                          margin: const EdgeInsets.only(right: 8),
                          child: const Icon(
                            Icons.local_fire_department,
                            color: Colors.red,
                            size: 16,
                          ),
                        ),
                      Expanded(
                        child: Text(
                          foodItem.name,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    foodItem.description,
                    style: Theme.of(context).textTheme.bodyMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  if (foodItem.allergens.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Wrap(
                        spacing: 4,
                        children: foodItem.allergens.map((allergen) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: AppTheme.errorColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: AppTheme.errorColor.withOpacity(0.3),
                              ),
                            ),
                            child: Text(
                              allergen,
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: AppTheme.errorColor,
                                    fontSize: 10,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${foodItem.price.toStringAsFixed(2)}',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: AppTheme.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 16,
                            color: AppTheme.textSecondary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${foodItem.preparationTime} min',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: foodItem.isAvailable
                          ? () => _showAddToCartDialog(context)
                          : null,
                      child: Text(
                        foodItem.isAvailable ? 'Add to Cart' : 'Unavailable',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  imageUrl: foodItem.imageUrl,
                  height: 120,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    height: 120,
                    color: Colors.grey[300],
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    height: 120,
                    color: Colors.grey[300],
                    child: const Center(
                      child: Icon(Icons.error),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddToCartDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AddToCartDialog(
        foodItem: foodItem,
        onConfirm: onAddToCart,
      ),
    );
  }
}