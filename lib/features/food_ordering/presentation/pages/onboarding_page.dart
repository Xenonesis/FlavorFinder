import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'enhanced_restaurant_list_page.dart';
import '../../../../core/theme/enhanced_app_theme.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingItem> _onboardingItems = [
    OnboardingItem(
      title: 'Discover Amazing Food',
      description: 'Explore thousands of restaurants and cuisines from around the world, all in one place.',
      animationAsset: 'assets/animations/food_discovery.json', // You would add actual Lottie files
      backgroundColor: const Color(0xFFFAFAFC), // Modern ultra-clean background
      primaryColor: EnhancedAppTheme.primaryColor, // Modern indigo
    ),
    OnboardingItem(
      title: 'Fast & Reliable Delivery',
      description: 'Get your favorite meals delivered quickly and safely to your doorstep.',
      animationAsset: 'assets/animations/delivery.json',
      backgroundColor: const Color(0xFFECFDF5), // Modern green background
      primaryColor: const Color(0xFF10B981), // Modern green
    ),
    OnboardingItem(
      title: 'Easy Ordering Process',
      description: 'Browse menus, customize your order, and pay securely with just a few taps.',
      animationAsset: 'assets/animations/ordering.json',
      backgroundColor: const Color(0xFFEFF6FF), // Modern blue background
      primaryColor: const Color(0xFF3B82F6), // Modern blue
    ),
    OnboardingItem(
      title: 'Track Your Favorites',
      description: 'Save your favorite restaurants and dishes for quick reordering anytime.',
      animationAsset: 'assets/animations/favorites.json',
      backgroundColor: const Color(0xFFFAF5FF), // Modern purple background
      primaryColor: const Color(0xFF8B5CF6), // Modern purple
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Skip Button
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (_currentPage < _onboardingItems.length - 1)
                    TextButton(
                      onPressed: _skipOnboarding,
                      child: Text(
                        'Skip',
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            
            // Page View
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: _onboardingItems.length,
                itemBuilder: (context, index) {
                  return _OnboardingPageContent(
                    item: _onboardingItems[index],
                  );
                },
              ),
            ),
            
            // Page Indicator and Navigation
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  // Page Indicator
                  SmoothPageIndicator(
                    controller: _pageController,
                    count: _onboardingItems.length,
                    effect: WormEffect(
                      dotColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
                      activeDotColor: _onboardingItems[_currentPage].primaryColor,
                      dotHeight: 12,
                      dotWidth: 12,
                      spacing: 8,
                    ),
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // Navigation Buttons
                  Row(
                    children: [
                      if (_currentPage > 0)
                        Expanded(
                          child: OutlinedButton(
                            onPressed: _previousPage,
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              side: BorderSide(
                                color: _onboardingItems[_currentPage].primaryColor,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                            'Previous',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          ),
                        ),
                      
                      if (_currentPage > 0) const SizedBox(width: 16),
                      
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _currentPage == _onboardingItems.length - 1
                              ? _completeOnboarding
                              : _nextPage,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _onboardingItems[_currentPage].primaryColor,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            _currentPage == _onboardingItems.length - 1
                                ? 'Get Started'
                                : 'Next',
                            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
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

  void _nextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _previousPage() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _skipOnboarding() {
    _pageController.animateToPage(
      _onboardingItems.length - 1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  Future<void> _completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_completed', true);
    
    if (mounted) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const EnhancedRestaurantListPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          transitionDuration: const Duration(milliseconds: 500),
        ),
      );
    }
  }
}

class _OnboardingPageContent extends StatelessWidget {
  final OnboardingItem item;

  const _OnboardingPageContent({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: item.backgroundColor,
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Animation/Illustration
          Container(
            height: 300,
            width: 300,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).shadowColor.withOpacity(0.2),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Center(
              child: _buildPlaceholderAnimation(item),
            ),
          ),
          
          const SizedBox(height: 48),
          
          // Title
          Text(
            item.title,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: item.primaryColor,
            ),
            textAlign: TextAlign.center,
          ),
          
          const SizedBox(height: 16),
          
          // Description
          Text(
            item.description,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceholderAnimation(OnboardingItem item) {
    // In a real app, you would use Lottie.asset(item.animationAsset)
    // For now, we'll use icons as placeholders
    IconData icon;
    switch (item.title) {
      case 'Discover Amazing Food':
        icon = Icons.restaurant_menu;
        break;
      case 'Fast & Reliable Delivery':
        icon = Icons.delivery_dining;
        break;
      case 'Easy Ordering Process':
        icon = Icons.shopping_cart;
        break;
      case 'Track Your Favorites':
        icon = Icons.favorite;
        break;
      default:
        icon = Icons.food_bank;
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      child: Icon(
        icon,
        size: 120,
        color: item.primaryColor.withOpacity(0.8),
      ),
    );
  }
}

class OnboardingItem {
  final String title;
  final String description;
  final String animationAsset;
  final Color backgroundColor;
  final Color primaryColor;

  OnboardingItem({
    required this.title,
    required this.description,
    required this.animationAsset,
    required this.backgroundColor,
    required this.primaryColor,
  });
}

// Helper function to check if onboarding should be shown
class OnboardingHelper {
  static Future<bool> shouldShowOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    final completed = prefs.getBool('onboarding_completed');
    return completed == null || completed == false;
  }
}
