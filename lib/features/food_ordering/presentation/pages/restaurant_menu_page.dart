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
import '../../../../core/utils/responsive_utils.dart';

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
      body: ResponsiveBuilder(
        mobile: (context, constraints) => _buildMobileLayout(categories, filteredItems),
        tablet: (context, constraints) => _buildTabletLayout(categories, filteredItems),
        desktop: (context, constraints) => _buildDesktopLayout(categories, filteredItems),
      ),
      floatingActionButton: BlocBuilder<CartBloc, CartState>(
        builder: (context, cartState) {
          if (cartState.items.isEmpty) return const SizedBox.shrink();
          
          return FloatingActionButton.extended(
            onPressed: () => _showCartBottomSheet(context),
            backgroundColor: AppTheme.primaryColor,
            icon: const Icon(Icons.shopping_cart, color: Colors.white),
            label: Text(
              'Cart (${cartState.totalItems})',
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMobileLayout(List<String> categories, List<FoodItem> filteredItems) {
    return CustomScrollView(
      slivers: [
        _buildSliverAppBar(),
        SliverToBoxAdapter(
          child: Padding(
            padding: ResponsiveUtils.getResponsivePadding(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildRestaurantInfo(),
                const SizedBox(height: 24),
                _buildCategoryFilter(categories),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: ResponsiveUtils.getResponsivePadding(context),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: FoodItemCard(
                    foodItem: filteredItems[index],
                    onAddToCart: (item) => _addToCart(item),
                  ),
                );
              },
              childCount: filteredItems.length,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTabletLayout(List<String> categories, List<FoodItem> filteredItems) {
    return CustomScrollView(
      slivers: [
        _buildSliverAppBar(),
        SliverToBoxAdapter(
          child: Padding(
            padding: ResponsiveUtils.getResponsivePadding(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildRestaurantInfo(),
                const SizedBox(height: 24),
                _buildCategoryFilter(categories),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: ResponsiveUtils.getResponsivePadding(context),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.3,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return FoodItemCard(
                  foodItem: filteredItems[index],
                  onAddToCart: (item) => _addToCart(item),
                );
              },
              childCount: filteredItems.length,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopLayout(List<String> categories, List<FoodItem> filteredItems) {
    return CustomScrollView(
      slivers: [
        _buildSliverAppBar(),
        SliverToBoxAdapter(
          child: Center(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: ResponsiveUtils.getMaxContentWidth(context),
              ),
              child: Padding(
                padding: ResponsiveUtils.getResponsivePadding(context),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildRestaurantInfo(),
                    const SizedBox(height: 24),
                    _buildCategoryFilter(categories),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
        ),
        SliverPadding(
          padding: ResponsiveUtils.getResponsivePadding(context),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1.2,
              crossAxisSpacing: 24,
              mainAxisSpacing: 24,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return FoodItemCard(
                  foodItem: filteredItems[index],
                  onAddToCart: (item) => _addToCart(item),
                );
              },
              childCount: filteredItems.length,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: ResponsiveUtils.isMobile(context) ? 200 : 250,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          widget.restaurant.name,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: ResponsiveUtils.getResponsiveFontSize(context, 16),
            shadows: const [
              Shadow(
                offset: Offset(0, 1),
                blurRadius: 3,
                color: Colors.black45,
              ),
            ],
          ),
        ),
        background: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(widget.restaurant.imageUrl),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
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
        ),
      ),
    );
  }

  Widget _buildRestaurantInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.star, color: Colors.amber, size: ResponsiveUtils.isMobile(context) ? 20 : 24),
            const SizedBox(width: 4),
            Text(
              '${widget.restaurant.rating}',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: ResponsiveUtils.getResponsiveFontSize(context, 16),
              ),
            ),
            const SizedBox(width: 16),
            Icon(Icons.access_time, color: Colors.grey[600], size: ResponsiveUtils.isMobile(context) ? 20 : 24),
            const SizedBox(width: 4),
            Text(
              '${widget.restaurant.deliveryTime} min',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: ResponsiveUtils.getResponsiveFontSize(context, 14),
              ),
            ),
            const SizedBox(width: 16),
            Icon(Icons.delivery_dining, color: Colors.grey[600], size: ResponsiveUtils.isMobile(context) ? 20 : 24),
            const SizedBox(width: 4),
            Text(
              '\$${widget.restaurant.deliveryFee.toStringAsFixed(2)}',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: ResponsiveUtils.getResponsiveFontSize(context, 14),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppTheme.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            widget.restaurant.cuisine,
            style: TextStyle(
              color: AppTheme.primaryColor,
              fontWeight: FontWeight.w500,
              fontSize: ResponsiveUtils.getResponsiveFontSize(context, 12),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryFilter(List<String> categories) {
    return SizedBox(
      height: ResponsiveUtils.isMobile(context) ? 40 : 48,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = selectedCategory == category;
          
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: FilterChip(
              label: Text(
                category,
                style: TextStyle(
                  color: isSelected ? Colors.white : AppTheme.primaryColor,
                  fontWeight: FontWeight.w500,
                  fontSize: ResponsiveUtils.getResponsiveFontSize(context, 12),
                ),
              ),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  selectedCategory = category;
                });
              },
              backgroundColor: Colors.white,
              selectedColor: AppTheme.primaryColor,
              checkmarkColor: Colors.white,
              side: BorderSide(color: AppTheme.primaryColor),
            ),
          );
        },
      ),
    );
  }

  List<String> _getCategories() {
    final allItems = _getAllFoodItems();
    final categories = allItems.map((item) => item.category).toSet().toList();
    categories.insert(0, 'All');
    return categories;
  }

  List<FoodItem> _getFilteredItems() {
    final allItems = _getAllFoodItems();
    if (selectedCategory == 'All') {
      return allItems;
    }
    return allItems.where((item) => item.category == selectedCategory).toList();
  }

  List<FoodItem> _getAllFoodItems() {
    // Mock data - in a real app, this would come from the repository
    return [
      FoodItem(
        id: '1',
        name: 'Margherita Pizza',
        description: 'Fresh mozzarella, tomato sauce, basil',
        price: 16.99,
        imageUrl: 'https://images.unsplash.com/photo-1604382354936-07c5d9983bd3?w=400&h=300&fit=crop',
        category: 'Pizza',
        rating: 4.8,
        isVegetarian: true,
        allergens: ['Gluten', 'Dairy'],
      ),
      FoodItem(
        id: '2',
        name: 'Pepperoni Pizza',
        description: 'Classic pepperoni with mozzarella cheese',
        price: 19.99,
        imageUrl: 'https://images.unsplash.com/photo-1565299624946-b28f40a0ca4b?w=400&h=300&fit=crop',
        category: 'Pizza',
        rating: 4.7,
        isVegetarian: false,
        allergens: ['Gluten', 'Dairy'],
      ),
      FoodItem(
        id: '3',
        name: 'Caesar Salad',
        description: 'Crisp romaine lettuce with parmesan and croutons',
        price: 12.99,
        imageUrl: 'https://images.unsplash.com/photo-1540420773420-3366772f4999?w=400&h=300&fit=crop',
        category: 'Salads',
        rating: 4.5,
        isVegetarian: true,
        allergens: ['Gluten', 'Dairy'],
      ),
    ];
  }

  void _addToCart(FoodItem item) {
    context.read<CartBloc>().add(AddToCart(foodItem: item));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${item.name} added to cart'),
        duration: const Duration(seconds: 2),
        backgroundColor: AppTheme.primaryColor,
      ),
    );
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
