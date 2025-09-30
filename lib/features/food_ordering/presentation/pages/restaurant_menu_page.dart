import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/restaurant.dart';
import '../../domain/entities/food_item.dart';
import '../bloc/cart/cart_bloc.dart';
import '../bloc/cart/cart_state.dart';
import '../bloc/cart/cart_event.dart';
import '../widgets/food_item_card.dart';
import '../widgets/cart_bottom_sheet.dart';
import '../../../../core/theme/app_theme.dart';

class RestaurantMenuPage extends StatefulWidget {
  final Restaurant restaurant;

  const RestaurantMenuPage({
    super.key,
    required this.restaurant,
  });

  @override
  State<RestaurantMenuPage> createState() => _RestaurantMenuPageState();
}

class _RestaurantMenuPageState extends State<RestaurantMenuPage> {
  String selectedCategory = 'All';

  @override
  Widget build(BuildContext context) {
    final categories = _getCategories();
    final filteredItems = _getFilteredItems();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                widget.restaurant.name,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  shadows: [
                    Shadow(
                      offset: Offset(0, 1),
                      blurRadius: 3,
                      color: Colors.black45,
                    ),
                  ],
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    widget.restaurant.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[300],
                        child: const Icon(Icons.error),
                      );
                    },
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              BlocBuilder<CartBloc, CartState>(
                builder: (context, cartState) {
                  return Stack(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.shopping_cart),
                        onPressed: cartState.items.isNotEmpty
                            ? () => _showCartBottomSheet(context)
                            : null,
                      ),
                      if (cartState.totalItems > 0)
                        Positioned(
                          right: 8,
                          top: 8,
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: AppTheme.primaryColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            constraints: const BoxConstraints(
                              minWidth: 16,
                              minHeight: 16,
                            ),
                            child: Text(
                              '${cartState.totalItems}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 20,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        widget.restaurant.rating.toString(),
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(width: 16),
                      Icon(
                        Icons.access_time,
                        color: AppTheme.textSecondary,
                        size: 20,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${widget.restaurant.deliveryTime} min',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(width: 16),
                      Icon(
                        Icons.delivery_dining,
                        color: AppTheme.textSecondary,
                        size: 20,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '\$${widget.restaurant.deliveryFee.toStringAsFixed(2)}',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.restaurant.address,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: AppTheme.primaryColor.withOpacity(0.3),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: AppTheme.primaryColor,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Minimum order: \$${widget.restaurant.minimumOrder.toStringAsFixed(2)}',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: AppTheme.primaryColor,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 50,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  final isSelected = category == selectedCategory;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategory = category;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 12),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppTheme.primaryColor
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected
                              ? AppTheme.primaryColor
                              : AppTheme.borderColor,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          category,
                          style: TextStyle(
                            color: isSelected
                                ? Colors.white
                                : AppTheme.textPrimary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final item = filteredItems[index];
                return FoodItemCard(
                  foodItem: item,
                  onAddToCart: (quantity, instructions) {
                    context.read<CartBloc>().add(
                          AddToCart(
                            foodItem: item,
                            quantity: quantity,
                            specialInstructions: instructions,
                          ),
                        );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${item.name} added to cart'),
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  },
                );
              },
              childCount: filteredItems.length,
            ),
          ),
        ],
      ),
    );
  }

  List<String> _getCategories() {
    final categories = <String>{'All'};
    for (final item in widget.restaurant.menu) {
      categories.add(item.category);
    }
    return categories.toList();
  }

  List<FoodItem> _getFilteredItems() {
    if (selectedCategory == 'All') {
      return widget.restaurant.menu;
    }
    return widget.restaurant.menu
        .where((item) => item.category == selectedCategory)
        .toList();
  }

  void _showCartBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const CartBottomSheet(),
    );
  }
}