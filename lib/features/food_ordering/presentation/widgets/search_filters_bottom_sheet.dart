import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../../../core/theme/enhanced_app_theme.dart';

class SearchFiltersBottomSheet extends StatefulWidget {
  final String? selectedCuisine;
  final double? minRating;
  final String? sortBy;
  final Function(String?, double?, String?) onFiltersChanged;

  const SearchFiltersBottomSheet({
    super.key,
    this.selectedCuisine,
    this.minRating,
    this.sortBy,
    required this.onFiltersChanged,
  });

  @override
  State<SearchFiltersBottomSheet> createState() => _SearchFiltersBottomSheetState();
}

class _SearchFiltersBottomSheetState extends State<SearchFiltersBottomSheet> {
  String? _selectedCuisine;
  double? _minRating;
  String? _sortBy;

  final List<String> _cuisines = [
    'Italian',
    'Chinese',
    'Indian',
    'Mexican',
    'Japanese',
    'American',
    'Thai',
    'Mediterranean',
  ];

  final List<Map<String, String>> _sortOptions = [
    {'value': 'rating', 'label': 'Rating'},
    {'value': 'delivery_time', 'label': 'Delivery Time'},
    {'value': 'delivery_fee', 'label': 'Delivery Fee'},
    {'value': 'name', 'label': 'Name'},
  ];

  @override
  void initState() {
    super.initState();
    _selectedCuisine = widget.selectedCuisine;
    _minRating = widget.minRating;
    _sortBy = widget.sortBy;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 8),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Theme.of(context).dividerColor,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Filters',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _selectedCuisine = null;
                          _minRating = null;
                          _sortBy = null;
                        });
                      },
                      child: const Text('Clear All'),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                
                // Cuisine Filter
                const Text(
                  'Cuisine',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _cuisines.map((cuisine) {
                    final isSelected = _selectedCuisine == cuisine;
                    return FilterChip(
                      label: Text(cuisine),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          _selectedCuisine = selected ? cuisine : null;
                        });
                      },
                      selectedColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                      checkmarkColor: Theme.of(context).colorScheme.primary,
                    );
                  }).toList(),
                ),
                
                const SizedBox(height: 24),
                
                // Rating Filter
                const Text(
                  'Minimum Rating',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    RatingBar.builder(
                      initialRating: _minRating ?? 0,
                      minRating: 0,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 30,
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        setState(() {
                          _minRating = rating > 0 ? rating : null;
                        });
                      },
                    ),
                    const SizedBox(width: 12),
                    if (_minRating != null)
                      Text(
                        '${_minRating!.toStringAsFixed(1)}+',
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                  ],
                ),
                
                const SizedBox(height: 24),
                
                // Sort By
                const Text(
                  'Sort By',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 12),
                Column(
                  children: _sortOptions.map((option) {
                    return RadioListTile<String>(
                      title: Text(option['label']!),
                      value: option['value']!,
                      groupValue: _sortBy,
                      onChanged: (value) {
                        setState(() {
                          _sortBy = value;
                        });
                      },
                      activeColor: Theme.of(context).colorScheme.primary,
                      contentPadding: EdgeInsets.zero,
                    );
                  }).toList(),
                ),
                
                const SizedBox(height: 24),
                
                // Apply Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      widget.onFiltersChanged(_selectedCuisine, _minRating, _sortBy);
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Apply Filters',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
