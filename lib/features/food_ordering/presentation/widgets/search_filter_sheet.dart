import 'package:flutter/material.dart';
import '../../data/services/advanced_search_service.dart';

class SearchFilterSheet extends StatefulWidget {
  final SearchFilters? currentFilters;
  final Function(SearchFilters) onFiltersApplied;

  const SearchFilterSheet({
    Key? key,
    this.currentFilters,
    required this.onFiltersApplied,
  }) : super(key: key);

  @override
  State<SearchFilterSheet> createState() => _SearchFilterSheetState();
}

class _SearchFilterSheetState extends State<SearchFilterSheet> {
  late RangeValues _priceRange;
  late double _minRating;
  late int _maxDeliveryTime;
  late Set<String> _selectedCategories;
  late Set<String> _selectedCuisines;
  late bool _isVegetarian;
  late bool _isVegan;
  late bool _isGlutenFree;

  final List<String> _availableCategories = [
    'Appetizers',
    'Main Course',
    'Desserts',
    'Beverages',
    'Salads',
    'Soups',
    'Snacks',
  ];

  final List<String> _availableCuisines = [
    'Italian',
    'Chinese',
    'Indian',
    'Mexican',
    'American',
    'Thai',
    'Japanese',
    'Mediterranean',
  ];

  @override
  void initState() {
    super.initState();
    _initializeFilters();
  }

  void _initializeFilters() {
    final filters = widget.currentFilters;
    
    _priceRange = RangeValues(
      filters?.minPrice ?? 0.0,
      filters?.maxPrice ?? 50.0,
    );
    _minRating = filters?.minRating ?? 0.0;
    _maxDeliveryTime = filters?.maxDeliveryTime ?? 60;
    _selectedCategories = Set.from(filters?.categories ?? []);
    _selectedCuisines = Set.from(filters?.cuisines ?? []);
    _isVegetarian = filters?.isVegetarian ?? false;
    _isVegan = filters?.isVegan ?? false;
    _isGlutenFree = filters?.isGlutenFree ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildPriceRangeSection(),
                  SizedBox(height: 24),
                  _buildRatingSection(),
                  SizedBox(height: 24),
                  _buildDeliveryTimeSection(),
                  SizedBox(height: 24),
                  _buildCategoriesSection(),
                  SizedBox(height: 24),
                  _buildCuisinesSection(),
                  SizedBox(height: 24),
                  _buildDietaryOptionsSection(),
                ],
              ),
            ),
          ),
          _buildActionButtons(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey[200]!)),
      ),
      child: Row(
        children: [
          Text(
            'Filters',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          Spacer(),
          TextButton(
            onPressed: _clearAllFilters,
            child: Text('Clear All'),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRangeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Price Range',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8),
        RangeSlider(
          values: _priceRange,
          min: 0,
          max: 100,
          divisions: 20,
          labels: RangeLabels(
            '\$${_priceRange.start.round()}',
            '\$${_priceRange.end.round()}',
          ),
          onChanged: (values) {
            setState(() {
              _priceRange = values;
            });
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('\$0', style: TextStyle(color: Colors.grey[600])),
            Text('\$100', style: TextStyle(color: Colors.grey[600])),
          ],
        ),
      ],
    );
  }

  Widget _buildRatingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Minimum Rating',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8),
        Slider(
          value: _minRating,
          min: 0,
          max: 5,
          divisions: 10,
          label: '${_minRating.toStringAsFixed(1)} ⭐',
          onChanged: (value) {
            setState(() {
              _minRating = value;
            });
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Any', style: TextStyle(color: Colors.grey[600])),
            Text('5.0 ⭐', style: TextStyle(color: Colors.grey[600])),
          ],
        ),
      ],
    );
  }

  Widget _buildDeliveryTimeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Maximum Delivery Time',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8),
        Slider(
          value: _maxDeliveryTime.toDouble(),
          min: 15,
          max: 120,
          divisions: 21,
          label: '$_maxDeliveryTime min',
          onChanged: (value) {
            setState(() {
              _maxDeliveryTime = value.round();
            });
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('15 min', style: TextStyle(color: Colors.grey[600])),
            Text('2 hours', style: TextStyle(color: Colors.grey[600])),
          ],
        ),
      ],
    );
  }

  Widget _buildCategoriesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Categories',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _availableCategories.map((category) {
            final isSelected = _selectedCategories.contains(category);
            return FilterChip(
              label: Text(category),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  if (selected) {
                    _selectedCategories.add(category);
                  } else {
                    _selectedCategories.remove(category);
                  }
                });
              },
              selectedColor: Colors.orange.withOpacity(0.2),
              checkmarkColor: Colors.orange,
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildCuisinesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Cuisines',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _availableCuisines.map((cuisine) {
            final isSelected = _selectedCuisines.contains(cuisine);
            return FilterChip(
              label: Text(cuisine),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  if (selected) {
                    _selectedCuisines.add(cuisine);
                  } else {
                    _selectedCuisines.remove(cuisine);
                  }
                });
              },
              selectedColor: Colors.orange.withOpacity(0.2),
              checkmarkColor: Colors.orange,
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildDietaryOptionsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Dietary Options',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 12),
        CheckboxListTile(
          title: Text('Vegetarian'),
          subtitle: Text('Contains no meat'),
          value: _isVegetarian,
          onChanged: (value) {
            setState(() {
              _isVegetarian = value ?? false;
            });
          },
          activeColor: Colors.orange,
          contentPadding: EdgeInsets.zero,
        ),
        CheckboxListTile(
          title: Text('Vegan'),
          subtitle: Text('Contains no animal products'),
          value: _isVegan,
          onChanged: (value) {
            setState(() {
              _isVegan = value ?? false;
            });
          },
          activeColor: Colors.orange,
          contentPadding: EdgeInsets.zero,
        ),
        CheckboxListTile(
          title: Text('Gluten-Free'),
          subtitle: Text('Contains no gluten'),
          value: _isGlutenFree,
          onChanged: (value) {
            setState(() {
              _isGlutenFree = value ?? false;
            });
          },
          activeColor: Colors.orange,
          contentPadding: EdgeInsets.zero,
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey[200]!)),
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: ElevatedButton(
              onPressed: _applyFilters,
              child: Text('Apply Filters'),
            ),
          ),
        ],
      ),
    );
  }

  void _clearAllFilters() {
    setState(() {
      _priceRange = RangeValues(0.0, 50.0);
      _minRating = 0.0;
      _maxDeliveryTime = 60;
      _selectedCategories.clear();
      _selectedCuisines.clear();
      _isVegetarian = false;
      _isVegan = false;
      _isGlutenFree = false;
    });
  }

  void _applyFilters() {
    final filters = SearchFilters(
      minPrice: _priceRange.start > 0 ? _priceRange.start : null,
      maxPrice: _priceRange.end < 50 ? _priceRange.end : null,
      minRating: _minRating > 0 ? _minRating : null,
      maxDeliveryTime: _maxDeliveryTime < 60 ? _maxDeliveryTime : null,
      categories: _selectedCategories.isNotEmpty ? _selectedCategories.toList() : null,
      cuisines: _selectedCuisines.isNotEmpty ? _selectedCuisines.toList() : null,
      isVegetarian: _isVegetarian ? true : null,
      isVegan: _isVegan ? true : null,
      isGlutenFree: _isGlutenFree ? true : null,
    );

    widget.onFiltersApplied(filters);
    Navigator.pop(context);
  }
}
