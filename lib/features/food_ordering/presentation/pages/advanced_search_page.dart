import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/theme/premium_theme.dart';

class AdvancedSearchPage extends StatefulWidget {
  const AdvancedSearchPage({super.key});

  @override
  State<AdvancedSearchPage> createState() => _AdvancedSearchPageState();
}

class _AdvancedSearchPageState extends State<AdvancedSearchPage>
    with TickerProviderStateMixin {
  late AnimationController _searchController;
  late AnimationController _filterController;
  late AnimationController _resultsController;
  late Animation<double> _searchAnimation;
  late Animation<double> _filterAnimation;
  late Animation<double> _resultsAnimation;

  final TextEditingController _searchTextController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  
  bool _isVoiceSearching = false;
  bool _showFilters = false;
  String _selectedCategory = 'All';
  double _priceRange = 50.0;
  double _rating = 4.0;
  String _sortBy = 'Relevance';

  final List<String> _recentSearches = [
    'Pizza margherita',
    'Sushi rolls',
    'Chicken burger',
    'Pasta carbonara',
  ];

  final List<String> _trendingSearches = [
    'Bubble tea',
    'Korean BBQ',
    'Vegan bowls',
    'Ice cream',
  ];

  @override
  void initState() {
    super.initState();
    _initAnimations();
    _searchFocusNode.requestFocus();
  }

  void _initAnimations() {
    _searchController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _filterController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _resultsController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _searchAnimation = CurvedAnimation(
      parent: _searchController,
      curve: Curves.easeOutBack,
    );
    _filterAnimation = CurvedAnimation(
      parent: _filterController,
      curve: Curves.easeInOut,
    );
    _resultsAnimation = CurvedAnimation(
      parent: _resultsController,
      curve: Curves.easeOutQuart,
    );

    _searchController.forward();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _filterController.dispose();
    _resultsController.dispose();
    _searchTextController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildSearchHeader(),
            if (_showFilters) _buildFilters(),
            Expanded(
              child: _searchTextController.text.isEmpty
                  ? _buildSearchSuggestions()
                  : _buildSearchResults(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchHeader() {
    return AnimatedBuilder(
      animation: _searchAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, -50 * (1 - _searchAnimation.value)),
          child: Opacity(
            opacity: _searchAnimation.value,
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () => Navigator.pop(context),
                      ),
                      Expanded(child: _buildSearchBar()),
                      IconButton(
                        icon: Icon(
                          _showFilters ? Icons.filter_list : Icons.tune,
                          color: _showFilters 
                              ? PremiumTheme.primaryOrange 
                              : PremiumTheme.textSecondary,
                        ),
                        onPressed: _toggleFilters,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildQuickFilters(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: PremiumTheme.cardShadow,
      ),
      child: TextField(
        controller: _searchTextController,
        focusNode: _searchFocusNode,
        decoration: InputDecoration(
          hintText: 'Search for food, restaurants...',
          prefixIcon: const Icon(Icons.search, color: PremiumTheme.primaryOrange),
          suffixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_searchTextController.text.isNotEmpty)
                IconButton(
                  icon: const Icon(Icons.clear, color: PremiumTheme.textSecondary),
                  onPressed: () {
                    _searchTextController.clear();
                    setState(() {});
                  },
                ),
              GestureDetector(
                onTap: _toggleVoiceSearch,
                child: Container(
                  margin: const EdgeInsets.only(right: 8),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _isVoiceSearching 
                        ? PremiumTheme.primaryOrange.withOpacity(0.1)
                        : Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    _isVoiceSearching ? Icons.mic : Icons.mic_none,
                    color: _isVoiceSearching 
                        ? PremiumTheme.primaryOrange 
                        : PremiumTheme.accentGold,
                    size: 20,
                  ),
                ),
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
        onChanged: (value) {
          setState(() {});
          if (value.isNotEmpty) {
            _resultsController.forward();
          }
        },
      ),
    );
  }

  Widget _buildQuickFilters() {
    final filters = ['All', 'Pizza', 'Burger', 'Asian', 'Healthy', 'Dessert'];
    
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        itemBuilder: (context, index) {
          final filter = filters[index];
          final isSelected = _selectedCategory == filter;
          
          return GestureDetector(
            onTap: () {
              HapticFeedback.lightImpact();
              setState(() => _selectedCategory = filter);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected 
                    ? PremiumTheme.primaryOrange 
                    : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected 
                      ? PremiumTheme.primaryOrange 
                      : Colors.grey.shade300,
                ),
              ),
              child: Text(
                filter,
                style: TextStyle(
                  color: isSelected ? Colors.white : PremiumTheme.textPrimary,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFilters() {
    return AnimatedBuilder(
      animation: _filterAnimation,
      builder: (context, child) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          height: _showFilters ? 200 : 0,
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                border: Border(
                  bottom: BorderSide(color: Colors.grey.shade200),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Filters',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  _buildPriceFilter(),
                  const SizedBox(height: 16),
                  _buildRatingFilter(),
                  const SizedBox(height: 16),
                  _buildSortFilter(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPriceFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Price Range: \$${_priceRange.round()}',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Slider(
          value: _priceRange,
          min: 10,
          max: 100,
          divisions: 18,
          activeColor: PremiumTheme.primaryOrange,
          onChanged: (value) => setState(() => _priceRange = value),
        ),
      ],
    );
  }

  Widget _buildRatingFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Minimum Rating: ${_rating.toStringAsFixed(1)} ⭐',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Slider(
          value: _rating,
          min: 1,
          max: 5,
          divisions: 8,
          activeColor: PremiumTheme.primaryOrange,
          onChanged: (value) => setState(() => _rating = value),
        ),
      ],
    );
  }

  Widget _buildSortFilter() {
    final sortOptions = ['Relevance', 'Rating', 'Price', 'Distance', 'Delivery Time'];
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sort by',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: sortOptions.map((option) {
            final isSelected = _sortBy == option;
            return GestureDetector(
              onTap: () {
                HapticFeedback.lightImpact();
                setState(() => _sortBy = option);
              },
              child: Chip(
                label: Text(option),
                backgroundColor: isSelected 
                    ? PremiumTheme.primaryOrange 
                    : Colors.grey.shade200,
                labelStyle: TextStyle(
                  color: isSelected ? Colors.white : PremiumTheme.textPrimary,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSearchSuggestions() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_recentSearches.isNotEmpty) ...[
            _buildSuggestionSection('Recent Searches', _recentSearches, Icons.history),
            const SizedBox(height: 24),
          ],
          _buildSuggestionSection('Trending Now', _trendingSearches, Icons.trending_up),
        ],
      ),
    );
  }

  Widget _buildSuggestionSection(String title, List<String> items, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: PremiumTheme.primaryOrange, size: 20),
            const SizedBox(width: 8),
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...items.map((item) => _buildSuggestionItem(item)),
      ],
    );
  }

  Widget _buildSuggestionItem(String suggestion) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        _searchTextController.text = suggestion;
        setState(() {});
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            const Icon(Icons.search, color: PremiumTheme.textSecondary, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                suggestion,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            const Icon(Icons.north_west, color: PremiumTheme.textSecondary, size: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchResults() {
    return AnimatedBuilder(
      animation: _resultsAnimation,
      builder: (context, child) {
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: 10,
          itemBuilder: (context, index) {
            return Transform.translate(
              offset: Offset(0, 50 * (1 - _resultsAnimation.value)),
              child: Opacity(
                opacity: _resultsAnimation.value,
                child: _buildResultItem(index),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildResultItem(int index) {
    final results = [
      {'name': 'Margherita Pizza', 'restaurant': 'Pizza Palace', 'price': '\$12.99', 'rating': 4.8, 'image': '🍕'},
      {'name': 'Chicken Burger', 'restaurant': 'Burger House', 'price': '\$8.99', 'rating': 4.6, 'image': '🍔'},
      {'name': 'Salmon Sushi', 'restaurant': 'Sushi Master', 'price': '\$15.99', 'rating': 4.9, 'image': '🍣'},
      {'name': 'Beef Tacos', 'restaurant': 'Taco Fiesta', 'price': '\$9.99', 'rating': 4.7, 'image': '🌮'},
      {'name': 'Caesar Salad', 'restaurant': 'Green Garden', 'price': '\$7.99', 'rating': 4.5, 'image': '🥗'},
    ];

    final result = results[index % results.length];

    return GestureDetector(
      onTap: () {
        HapticFeedback.mediumImpact();
        _openResult(result);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: PremiumTheme.cardShadow,
        ),
        child: Row(
          children: [
            Container(
              width: 80,
              height: 80,
              margin: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                gradient: PremiumTheme.cardGradient,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  result['image'] as String,
                  style: const TextStyle(fontSize: 32),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      result['name'] as String,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      result['restaurant'] as String,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: PremiumTheme.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.star, color: PremiumTheme.success, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          result['rating'].toString(),
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: PremiumTheme.success,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          result['price'] as String,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: PremiumTheme.primaryOrange,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.add_circle, color: PremiumTheme.primaryOrange),
              onPressed: () => _addToCart(result),
            ),
          ],
        ),
      ),
    );
  }

  void _toggleFilters() {
    HapticFeedback.lightImpact();
    setState(() => _showFilters = !_showFilters);
    if (_showFilters) {
      _filterController.forward();
    } else {
      _filterController.reverse();
    }
  }

  void _toggleVoiceSearch() {
    HapticFeedback.mediumImpact();
    setState(() => _isVoiceSearching = !_isVoiceSearching);
    
    if (_isVoiceSearching) {
      // Start voice recognition
      Future.delayed(const Duration(seconds: 3), () {
        if (mounted) {
          setState(() => _isVoiceSearching = false);
          _searchTextController.text = 'Pizza margherita';
        }
      });
    }
  }

  void _openResult(Map<String, dynamic> result) {
    // Navigate to item details
  }

  void _addToCart(Map<String, dynamic> result) {
    HapticFeedback.lightImpact();
    // Add item to cart
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${result['name']} added to cart'),
        backgroundColor: PremiumTheme.success,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
