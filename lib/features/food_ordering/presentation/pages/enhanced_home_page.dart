import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:lottie/lottie.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../bloc/restaurant_bloc.dart';
import '../bloc/cart_bloc.dart';
import '../bloc/recommendation_bloc.dart';
import '../widgets/animated_restaurant_card.dart';
import '../widgets/animated_category_chip.dart';
import '../widgets/floating_cart_button.dart';
import 'advanced_search_page.dart';
import 'user_profile_page.dart';
import '../../../../main_enhanced_v2.dart';

class EnhancedHomePage extends StatefulWidget {
  @override
  State<EnhancedHomePage> createState() => _EnhancedHomePageState();
}

class _EnhancedHomePageState extends State<EnhancedHomePage>
    with TickerProviderStateMixin {
  late AnimationController _headerController;
  late AnimationController _fabController;
  late Animation<double> _headerAnimation;
  late Animation<Offset> _searchBarAnimation;
  
  final ScrollController _scrollController = ScrollController();
  final CarouselController _carouselController = CarouselController();
  
  int _currentCarouselIndex = 0;
  bool _isHeaderExpanded = true;

  final List<String> _bannerImages = [
    'assets/images/banner1.jpg',
    'assets/images/banner2.jpg',
    'assets/images/banner3.jpg',
  ];

  final List<String> _categories = [
    'All',
    'Pizza',
    'Burgers',
    'Sushi',
    'Indian',
    'Chinese',
    'Italian',
    'Mexican',
  ];

  String _selectedCategory = 'All';

  @override
  void initState() {
    super.initState();
    
    _headerController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
    
    _fabController = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
    );

    _headerAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _headerController, curve: Curves.easeInOut),
    );

    _searchBarAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset(0, -1),
    ).animate(CurvedAnimation(
      parent: _headerController,
      curve: Curves.easeInOut,
    ));

    _scrollController.addListener(_onScroll);
    
    // Load initial data
    context.read<RestaurantBloc>().add(LoadRestaurants());
    context.read<RecommendationBloc>().add(LoadRecommendations(
      allItems: [], // Would be populated with actual data
      restaurants: [],
    ));
  }

  void _onScroll() {
    final offset = _scrollController.offset;
    final shouldExpand = offset < 100;
    
    if (shouldExpand != _isHeaderExpanded) {
      setState(() {
        _isHeaderExpanded = shouldExpand;
      });
      
      if (shouldExpand) {
        _headerController.reverse();
      } else {
        _headerController.forward();
      }
    }
  }

  @override
  void dispose() {
    _headerController.dispose();
    _fabController.dispose();
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
          SliverToBoxAdapter(child: _buildPromoBanner()),
          SliverToBoxAdapter(child: _buildCategorySection()),
          SliverToBoxAdapter(child: _buildRecommendationsSection()),
          _buildRestaurantsList(),
        ],
      ),
      floatingActionButton: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoaded && state.items.isNotEmpty) {
            return FloatingCartButton(
              itemCount: state.items.length,
              onPressed: () => _navigateToCart(),
            );
          }
          return SizedBox.shrink();
        },
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildAnimatedAppBar() {
    return SliverAppBar(
      expandedHeight: 120,
      floating: true,
      pinned: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        background: AnimatedBuilder(
          animation: _headerAnimation,
          builder: (context, child) {
            return Container(
              padding: EdgeInsets.fromLTRB(20, 60, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Good Morning! 👋',
                              style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).textTheme.bodyMedium?.color,
                              ),
                            ),
                            Text(
                              'What would you like to eat?',
                              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      AnimatedCard(
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
                          child: Icon(Icons.person, color: Theme.of(context).primaryColor),
                        ),
                        onTap: () => _navigateToProfile(),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: SlideTransition(
          position: _searchBarAnimation,
          child: Container(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: _buildSearchBar(),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return AnimatedCard(
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor.withOpacity(0.1),
              blurRadius: 10,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Search for food or restaurants...',
            hintStyle: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color),
            prefixIcon: Icon(Icons.search, color: Theme.of(context).iconTheme.color),
            suffixIcon: Icon(Icons.mic, color: Theme.of(context).iconTheme.color),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          ),
          onTap: () => _navigateToSearch(),
          readOnly: true,
        ),
      ),
      onTap: () => _navigateToSearch(),
    );
  }

  Widget _buildPromoBanner() {
    return Container(
      height: 180,
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          Expanded(
            child: CarouselSlider(
              carouselController: _carouselController,
              options: CarouselOptions(
                height: 140,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 4),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                autoPlayCurve: Curves.easeInOutCubic,
                enlargeCenterPage: true,
                viewportFraction: 0.9,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentCarouselIndex = index;
                  });
                },
              ),
              items: _bannerImages.asMap().entries.map((entry) {
                return AnimationConfiguration.staggeredList(
                  position: entry.key,
                  duration: Duration(milliseconds: 600),
                  child: SlideAnimation(
                    horizontalOffset: 50.0,
                    child: FadeInAnimation(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          gradient: LinearGradient(
                            colors: [
                              Colors.orange.shade400,
                              Colors.deepOrange.shade600,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.orange.withOpacity(0.3),
                              blurRadius: 15,
                              offset: Offset(0, 8),
                            ),
                          ],
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
                              padding: EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Special Offer!',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    '30% off on your first order',
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.9),
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      'Order Now',
                                      style: TextStyle(
                                        color: Colors.orange,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          SizedBox(height: 12),
          AnimatedSmoothIndicator(
            activeIndex: _currentCarouselIndex,
            count: _bannerImages.length,
            effect: ExpandingDotsEffect(
              dotHeight: 8,
              dotWidth: 8,
              activeDotColor: Colors.orange,
              dotColor: Colors.grey[300]!,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategorySection() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Categories',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
          SizedBox(height: 16),
          Container(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 20),
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: Duration(milliseconds: 400),
                  delay: Duration(milliseconds: index * 50),
                  child: SlideAnimation(
                    horizontalOffset: 50.0,
                    child: FadeInAnimation(
                      child: AnimatedCategoryChip(
                        label: _categories[index],
                        isSelected: _selectedCategory == _categories[index],
                        onTap: () {
                          setState(() {
                            _selectedCategory = _categories[index];
                          });
                          HapticFeedback.selectionClick();
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendationsSection() {
    return BlocBuilder<RecommendationBloc, RecommendationState>(
      builder: (context, state) {
        if (state is RecommendationLoaded) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Text(
                        'Recommended for You',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(width: 8),
                      PulseAnimation(
                        child: Icon(
                          Icons.auto_awesome,
                          color: Colors.orange,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    itemCount: state.recommendedItems.length,
                    itemBuilder: (context, index) {
                      final item = state.recommendedItems[index];
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: Duration(milliseconds: 600),
                        delay: Duration(milliseconds: index * 100),
                        child: SlideAnimation(
                          horizontalOffset: 100.0,
                          child: FadeInAnimation(
                            child: Container(
                              width: 160,
                              margin: EdgeInsets.only(right: 16),
                              child: AnimatedCard(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.white,
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(12),
                                            ),
                                            gradient: LinearGradient(
                                              colors: [
                                                Colors.orange.shade200,
                                                Colors.orange.shade400,
                                              ],
                                            ),
                                          ),
                                          child: Center(
                                            child: Icon(
                                              Icons.fastfood,
                                              size: 40,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Padding(
                                          padding: EdgeInsets.all(12),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                item.name,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              SizedBox(height: 4),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.star,
                                                    size: 14,
                                                    color: Colors.amber,
                                                  ),
                                                  SizedBox(width: 4),
                                                  Text(
                                                    item.rating.toString(),
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.grey[600],
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  Text(
                                                    '\$${item.price.toStringAsFixed(2)}',
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.orange,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                onTap: () => _onFoodItemTap(item),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }
        return SizedBox.shrink();
      },
    );
  }

  Widget _buildRestaurantsList() {
    return BlocBuilder<RestaurantBloc, RestaurantState>(
      builder: (context, state) {
        if (state is RestaurantLoading) {
          return SliverToBoxAdapter(
            child: Container(
              height: 200,
              child: Center(
                child: Lottie.asset(
                  'assets/animations/loading_food.json',
                  width: 100,
                  height: 100,
                ),
              ),
            ),
          );
        } else if (state is RestaurantLoaded) {
          return SliverPadding(
            padding: EdgeInsets.all(20),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  if (index == 0) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 16),
                      child: Text(
                        'Popular Restaurants',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    );
                  }
                  
                  final restaurant = state.restaurants[index - 1];
                  return AnimationConfiguration.staggeredList(
                    position: index - 1,
                    duration: Duration(milliseconds: 600),
                    delay: Duration(milliseconds: (index - 1) * 100),
                    child: SlideAnimation(
                      verticalOffset: 50.0,
                      child: FadeInAnimation(
                        child: AnimatedRestaurantCard(
                          restaurant: restaurant,
                          onTap: () => _onRestaurantTap(restaurant),
                        ),
                      ),
                    ),
                  );
                },
                childCount: state.restaurants.length + 1,
              ),
            ),
          );
        } else if (state is RestaurantError) {
          return SliverToBoxAdapter(
            child: Container(
              height: 200,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, size: 48, color: Colors.red),
                    SizedBox(height: 16),
                    Text(
                      'Failed to load restaurants',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        context.read<RestaurantBloc>().add(LoadRestaurants());
                      },
                      child: Text('Retry'),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        return SliverToBoxAdapter(child: SizedBox.shrink());
      },
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Icons.home, 'Home', true),
          _buildNavItem(Icons.search, 'Search', false),
          _buildNavItem(Icons.favorite_border, 'Favorites', false),
          _buildNavItem(Icons.person_outline, 'Profile', false),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isActive) {
    return AnimatedCard(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isActive 
                  ? Theme.of(context).primaryColor 
                  : Theme.of(context).iconTheme.color,
              size: 24,
            ),
            SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isActive 
                    ? Theme.of(context).primaryColor 
                    : Theme.of(context).textTheme.bodyMedium?.color,
                fontSize: 12,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        if (label == 'Search') {
          _navigateToSearch();
        } else if (label == 'Profile') {
          _navigateToProfile();
        }
      },
    );
  }

  void _navigateToSearch() {
    Navigator.of(context).push(
      SlideUpPageRoute(
        child: AdvancedSearchPage(
          foodItems: [], // Would be populated with actual data
          restaurants: [],
        ),
      ),
    );
  }

  void _navigateToProfile() {
    Navigator.of(context).push(
      FadeScalePageRoute(child: UserProfilePage()),
    );
  }

  void _navigateToCart() {
    // Navigate to cart page
    HapticFeedback.lightImpact();
  }

  void _onRestaurantTap(restaurant) {
    HapticFeedback.selectionClick();
    // Navigate to restaurant details
  }

  void _onFoodItemTap(item) {
    HapticFeedback.selectionClick();
    // Navigate to food item details
  }
}
