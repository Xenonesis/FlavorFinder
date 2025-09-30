import 'package:flutter/material.dart';
import '../../domain/entities/food_item.dart';
import '../../../../core/theme/app_theme.dart';

class AddToCartDialog extends StatefulWidget {
  final FoodItem foodItem;
  final Function(int quantity, String? instructions) onConfirm;

  const AddToCartDialog({
    super.key,
    required this.foodItem,
    required this.onConfirm,
  });

  @override
  State<AddToCartDialog> createState() => _AddToCartDialogState();
}

class _AddToCartDialogState extends State<AddToCartDialog> {
  int quantity = 1;
  final TextEditingController instructionsController = TextEditingController();

  @override
  void dispose() {
    instructionsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final totalPrice = widget.foodItem.price * quantity;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    widget.foodItem.name,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              widget.foodItem.description,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            if (widget.foodItem.allergens.isNotEmpty) ...[
              Text(
                'Allergens:',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppTheme.errorColor,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 4),
              Wrap(
                spacing: 8,
                children: widget.foodItem.allergens.map((allergen) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
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
                          ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
            ],
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Quantity',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: quantity > 1
                          ? () {
                              setState(() {
                                quantity--;
                              });
                            }
                          : null,
                      icon: const Icon(Icons.remove_circle_outline),
                      iconSize: 32,
                    ),
                    Container(
                      width: 40,
                      child: Text(
                        quantity.toString(),
                        style: Theme.of(context).textTheme.titleLarge,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    IconButton(
                      onPressed: quantity < 10
                          ? () {
                              setState(() {
                                quantity++;
                              });
                            }
                          : null,
                      icon: const Icon(Icons.add_circle_outline),
                      iconSize: 32,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Special Instructions (Optional)',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            TextField(
              controller: instructionsController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'e.g., No onions, extra spicy, etc.',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.all(12),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  final instructions = instructionsController.text.trim();
                  widget.onConfirm(
                    quantity,
                    instructions.isEmpty ? null : instructions,
                  );
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(
                  'Add to Cart - \$${totalPrice.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}