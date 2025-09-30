import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/theme/premium_theme.dart';

class AnimatedHomePage extends StatefulWidget {
  const AnimatedHomePage({super.key});

  @override
  State<AnimatedHomePage> createState() => _AnimatedHomePageState();
}

class _AnimatedHomePageState extends State<AnimatedHomePage>
    with TickerProviderStateMixin {
  late AnimationController _headerController;
  late AnimationController _categoryController;
  late AnimationController _restaurantController;
  late Animation<double> _headerAnimation;
  late Animation<double> _categoryAnimation;
  late Animation<double> _restaurantAnimation;

  final ScrollController _scrollController = ScrollController();
  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();
    _initAnimations();
    _scrollController.addListener(_onScroll);
  }

  void _initAnimations() {
    _headerController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _categoryController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _restaurantController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _headerAnimation = CurvedAnimation(
      parent: _headerController,
      curve: Curves.easeOutBack,
    );
    _categoryAnimation = CurvedAnimation(
      parent: _categoryController,
      curve: Curves.elasticOut,
    );
    _restaurantAnimation = CurvedAnimation(
      parent: _restaurantController,
      curve: Curves.easeOutQuart,
    );

    _startAnimations();
  }

  void _startAnimations() async {
    await Future.delayed(const Duration(milliseconds: 300));
    _headerController.forward();
    await Future.delayed(const Duration(milliseconds: 200));
    _categoryController.forward();
    await Future.delayed(const Duration(milliseconds: 200));
    _restaurantController.forward();
  }

  void _onScroll() {
    if (_scrollController.offset > 100 && !_isScrolled) {
      setState(() => _isScrolled = true);
    } else if (_scrollController.offset <= 100 && _isScrolled) {
      setState(() => _isScrolled = false);
    }
  }

  @override
  void dispose() {
    _headerController.dispose();
    _categoryController.dispose();
    _restaurantController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          _buildAnimatedAppBar(),
          SliverToBoxAdapter(child: _buildHeader()),
          SliverToBoxAdapter(child: _buildSearchBar()),
          SliverToBoxAdapter(child: _buildCategories()),
          SliverToBoxAdapter(child: _buildPromotions()),
          SliverToBoxAdapter(child: _buildRestaurants()),
        ],
      ),
      floatingActionButton: _buildFloatingCart(),
    );
  }

  Widget _buildAnimatedAppBar() {
    return SliverAppBar(
      expandedHeight: 0,
      floating: true,
      pinned: true,
      backgroundColor: _isScrolled 
          ? Theme.of(context).scaffoldBackgroundColor.withOpacity(0.95)
          : Colors.transparent,
      elevation: _isScrolled ? 4 : 0,
      title: AnimatedOpacity(
        opacity: _isScrolled ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 300),
        child: const Text('FlavorFinder'),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_outlined),
          onPressed: () => _showNotifications(),
        ),
        IconButton(
          icon: const Icon(Icons.person_outline),
          onPressed: () => _showProfile(),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return AnimatedBuilder(
      animation: _headerAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, 50 * (1 - _headerAnimation.value)),
          child: Opacity(
            opacity: _headerAnimation.value,
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.location_on, 
                          color: PremiumTheme.primaryOrange, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        'Deliver to',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const Icon(Icons.keyboard_arrow_down, size: 16),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Home - 123 Main Street',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ShaderMask(
                    shaderCallback: (bounds) => PremiumTheme.primaryGradient
                        .createShader(bounds),
                    child: Text(
                      'What would you like\nto eat today? 🍕',
                      style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        color: Colors.white,
                        height: 1.2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSearchBar() {
    return AnimatedBuilder(
      animation: _headerAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: 0.8 + (0.2 * _headerAnimation.value),
          child: Opacity(
            opacity: _headerAnimation.value,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Material(
                elevation: 8,
                borderRadius: BorderRadius.circular(16),
                shadowColor: Colors.black.withOpacity(0.1),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search restaurants, dishes...',
                    prefixIcon: const Icon(Icons.search, 
                        color: PremiumTheme.primaryOrange),
                    suffixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.mic, 
                              color: PremiumTheme.accentGold),
                          onPressed: () => _startVoiceSearch(),
                        ),
                        IconButton(
                          icon: const Icon(Icons.tune, 
                              color: PremiumTheme.textSecondary),
                          onPressed: () => _showFilters(),
                        ),
                      ],
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  onTap: () => _openSearch(),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCategories() {
    final categories = [
      {'icon': '🍕', 'name': 'Pizza', 'color': Colors.red.shade100},
      {'icon': '🍔', 'name': 'Burger', 'color': Colors.orange.shade100},
      {'icon': '🍜', 'name': 'Asian', 'color': Colors.green.shade100},
      {'icon': '🥗', 'name': 'Healthy', 'color': Colors.blue.shade100},
      {'icon': '🍰', 'name': 'Dessert', 'color': Colors.purple.shade100},
      {'icon': '☕', 'name': 'Coffee', 'color': Colors.brown.shade100},
    ];

    return AnimatedBuilder(
      animation: _categoryAnimation,
      builder: (context, child) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Categories',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    TextButton(
                      onPressed: () => _showAllCategories(),
                      child: const Text('See all'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return AnimatedBuilder(
                      animation: _categoryAnimation,
                      builder: (context, child) {
                        final delay = index * 0.1;
                        final animValue = Curves.elasticOut.transform(
                          (_categoryAnimation.value - delay).clamp(0.0, 1.0),
                        );
                        
                        return Transform.scale(
                          scale: animValue,
                          child: Container(
                            width: 80,
                            margin: const EdgeInsets.only(right: 16),
                            child: _buildCategoryCard(categories[index]),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCategoryCard(Map<String, dynamic> category) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        _openCategory(category['name']);
      },
      child: Container(
        decoration: BoxDecoration(
          color: category['color'],
          borderRadius: BorderRadius.circular(16),
          boxShadow: PremiumTheme.cardShadow,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              category['icon'],
              style: const TextStyle(fontSize: 32),
            ),
            const SizedBox(height: 8),
            Text(
              category['name'],
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPromotions() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Special Offers 🔥',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 160,
            child: PageView.builder(
              padEnds: false,
              controller: PageController(viewportFraction: 0.9),
              itemCount: 3,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    gradient: PremiumTheme.primaryGradient,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: PremiumTheme.elevatedShadow,
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        right: -20,
                        top: -20,
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '50% OFF',
                              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'On your first order',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: Colors.white.withOpacity(0.9),
                              ),
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () => _claimOffer(),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: PremiumTheme.primaryOrange,
                              ),
                              child: const Text('Claim Now'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRestaurants() {
    return AnimatedBuilder(
      animation: _restaurantAnimation,
      builder: (context, child) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Popular Restaurants',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    TextButton(
                      onPressed: () => _showAllRestaurants(),
                      child: const Text('See all'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: 5,
                itemBuilder: (context, index) {
                  return AnimatedBuilder(
                    animation: _restaurantAnimation,
                    builder: (context, child) {
                      final delay = index * 0.1;
                      final animValue = Curves.easeOutQuart.transform(
                        (_restaurantAnimation.value - delay).clamp(0.0, 1.0),
                      );
                      
                      return Transform.translate(
                        offset: Offset(0, 50 * (1 - animValue)),
                        child: Opacity(
                          opacity: animValue,
                          child: _buildRestaurantCard(index),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildRestaurantCard(int index) {
    final restaurants = [
      {'name': 'Pizza Palace', 'cuisine': 'Italian', 'rating': 4.8, 'time': '25-30 min', 'image': '🍕'},
      {'name': 'Burger House', 'cuisine': 'American', 'rating': 4.6, 'time': '20-25 min', 'image': '🍔'},
      {'name': 'Sushi Master', 'cuisine': 'Japanese', 'rating': 4.9, 'time': '30-35 min', 'image': '🍣'},
      {'name': 'Taco Fiesta', 'cuisine': 'Mexican', 'rating': 4.7, 'time': '15-20 min', 'image': '🌮'},
      {'name': 'Pasta Corner', 'cuisine': 'Italian', 'rating': 4.5, 'time': '25-30 min', 'image': '🍝'},
    ];

    final restaurant = restaurants[index];

    return GestureDetector(
      onTap: () {
        HapticFeedback.mediumImpact();
        _openRestaurant(restaurant);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: PremiumTheme.cardShadow,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 160,
              decoration: BoxDecoration(
                gradient: PremiumTheme.cardGradient,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              ),
              child: Center(
                child: Text(
                  restaurant['image'],
                  style: const TextStyle(fontSize: 64),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        restaurant['name'],
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: PremiumTheme.success.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.star, 
                                color: PremiumTheme.success, size: 16),
                            const SizedBox(width: 4),
                            Text(
                              restaurant['rating'].toString(),
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: PremiumTheme.success,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        restaurant['cuisine'],
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: PremiumTheme.textSecondary,
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Icon(Icons.access_time, 
                          color: PremiumTheme.textSecondary, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        restaurant['time'],
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: PremiumTheme.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFloatingCart() {
    return FloatingActionButton.extended(
      onPressed: () => _openCart(),
      backgroundColor: PremiumTheme.primaryOrange,
      icon: const Icon(Icons.shopping_cart, color: Colors.white),
      label: const Text('Cart (3)', 
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
    );
  }

  // Action methods
  void _showNotifications() {
    HapticFeedback.lightImpact();
    // Navigate to notifications
  }

  void _showProfile() {
    HapticFeedback.lightImpact();
    // Navigate to profile
  }

  void _startVoiceSearch() {
    HapticFeedback.mediumImpact();
    // Start voice search
  }

  void _showFilters() {
    HapticFeedback.lightImpact();
    // Show filter bottom sheet
  }

  void _openSearch() {
    HapticFeedback.lightImpact();
    // Navigate to search page
  }

  void _showAllCategories() {
    HapticFeedback.lightImpact();
    // Navigate to categories page
  }

  void _openCategory(String category) {
    HapticFeedback.lightImpact();
    // Navigate to category page
  }

  void _claimOffer() {
    HapticFeedback.mediumImpact();
    // Claim offer logic
  }

  void _showAllRestaurants() {
    HapticFeedback.lightImpact();
    // Navigate to restaurants page
  }

  void _openRestaurant(Map<String, dynamic> restaurant) {
    HapticFeedback.mediumImpact();
    // Navigate to restaurant details
  }

  void _openCart() {
    HapticFeedback.mediumImpact();
    // Navigate to cart
  }
}
