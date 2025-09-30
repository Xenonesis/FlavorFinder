import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../domain/entities/food_item.dart';
import 'add_to_cart_dialog.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/responsive_utils.dart';

class FoodItemCard extends StatelessWidget {
  final FoodItem foodItem;
  final Function(FoodItem) onAddToCart;

  const FoodItemCard({
    super.key,
    required this.foodItem,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      mobile: (context, constraints) => _buildMobileCard(context),
      tablet: (context, constraints) => _buildTabletCard(context),
      desktop: (context, constraints) => _buildDesktopCard(context),
    );
  }

  Widget _buildMobileCard(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: _buildItemInfo(context),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 1,
              child: _buildItemImage(context, 80),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabletCard(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildItemImage(context, 120),
          Padding(
            padding: const EdgeInsets.all(16),
            child: _buildItemInfo(context),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopCard(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildItemImage(context, 140),
          Padding(
            padding: const EdgeInsets.all(20),
            child: _buildItemInfo(context),
          ),
        ],
      ),
    );
  }

  Widget _buildItemInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (foodItem.isVegetarian)
              Container(
                width: ResponsiveUtils.isMobile(context) ? 16 : 18,
                height: ResponsiveUtils.isMobile(context) ? 16 : 18,
                margin: const EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                  color: AppTheme.successColor,
                  borderRadius: BorderRadius.circular(2),
                ),
                child: Icon(
                  Icons.circle,
                  color: Colors.white,
                  size: ResponsiveUtils.isMobile(context) ? 8 : 10,
                ),
              ),
            Expanded(
              child: Text(
                foodItem.name,
                style: TextStyle(
                  fontSize: ResponsiveUtils.getResponsiveFontSize(context, 16),
                  fontWeight: FontWeight.w600,
                ),
                maxLines: ResponsiveUtils.isMobile(context) ? 2 : 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        SizedBox(height: ResponsiveUtils.isMobile(context) ? 4 : 8),
        Text(
          foodItem.description,
          style: TextStyle(
            fontSize: ResponsiveUtils.getResponsiveFontSize(context, 14),
            color: Colors.grey[600],
          ),
          maxLines: ResponsiveUtils.isMobile(context) ? 2 : 3,
          overflow: TextOverflow.ellipsis,
        ),
        if (foodItem.allergens.isNotEmpty) ...[
          SizedBox(height: ResponsiveUtils.isMobile(context) ? 8 : 12),
          Wrap(
            spacing: 4,
            runSpacing: 4,
            children: foodItem.allergens.map((allergen) {
              return Container(
                padding: EdgeInsets.symmetric(
                  horizontal: ResponsiveUtils.isMobile(context) ? 6 : 8,
                  vertical: ResponsiveUtils.isMobile(context) ? 2 : 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.orange.withOpacity(0.3)),
                ),
                child: Text(
                  allergen,
                  style: TextStyle(
                    fontSize: ResponsiveUtils.getResponsiveFontSize(context, 10),
                    color: Colors.orange[700],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
        SizedBox(height: ResponsiveUtils.isMobile(context) ? 12 : 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '\$${foodItem.price.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: ResponsiveUtils.getResponsiveFontSize(context, 18),
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryColor,
                  ),
                ),
                if (foodItem.rating > 0) ...[
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: ResponsiveUtils.isMobile(context) ? 14 : 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        foodItem.rating.toString(),
                        style: TextStyle(
                          fontSize: ResponsiveUtils.getResponsiveFontSize(context, 12),
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
            ElevatedButton(
              onPressed: () => _showAddToCartDialog(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryColor,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(
                  horizontal: ResponsiveUtils.isMobile(context) ? 16 : 20,
                  vertical: ResponsiveUtils.isMobile(context) ? 8 : 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(ResponsiveUtils.isMobile(context) ? 8 : 12),
                ),
              ),
              child: Text(
                'Add',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: ResponsiveUtils.getResponsiveFontSize(context, 14),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildItemImage(BuildContext context, double height) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(
        ResponsiveUtils.isMobile(context) ? 8 : 12,
      ),
      child: CachedNetworkImage(
        imageUrl: foodItem.imageUrl,
        height: height,
        width: double.infinity,
        fit: BoxFit.cover,
        placeholder: (context, url) => Container(
          height: height,
          color: Colors.grey[300],
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
        errorWidget: (context, url, error) => Container(
          height: height,
          color: Colors.grey[300],
          child: const Icon(
            Icons.fastfood,
            color: Colors.grey,
            size: 40,
          ),
        ),
      ),
    );
  }

  void _showAddToCartDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AddToCartDialog(
        foodItem: foodItem,
        onConfirm: (quantity, instructions) {
          // For simplicity, just call onAddToCart with the food item
          onAddToCart(foodItem);
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
