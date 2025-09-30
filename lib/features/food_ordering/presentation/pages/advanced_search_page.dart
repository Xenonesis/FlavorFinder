import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:lottie/lottie.dart';
import '../bloc/search_bloc.dart';
import '../widgets/search_filter_sheet.dart';
import '../widgets/food_item_card.dart';
import '../widgets/restaurant_card.dart';
import '../../data/services/advanced_search_service.dart';
import '../../domain/entities/food_item.dart';
import '../../domain/entities/restaurant.dart';

class AdvancedSearchPage extends StatefulWidget {
  final List<FoodItem> foodItems;
  final List<Restaurant> restaurants;

  const AdvancedSearchPage({
    Key? key,
    required this.foodItems,
    required this.restaurants,
  }) : super(key: key);

  @override
  State<AdvancedSearchPage> createState() => _AdvancedSearchPageState();
}

class _AdvancedSearchPageState extends State<AdvancedSearchPage>
    with TickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  late TabController _tabController;
  late AnimationController _voiceAnimationController;
  
  bool _isSearchingFood = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _voiceAnimationController = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    );
    
    _tabController.addListener(() {
      setState(() {
        _isSearchingFood = _tabController.index == 0;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _tabController.dispose();
    _voiceAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchBloc()..add(LoadTrendingSearches()),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Search'),
          backgroundColor: Colors.transparent,
          elevation: 0,
          bottom: TabBar(
            controller: _tabController,
            tabs: [
              Tab(text: 'Food Items'),
              Tab(text: 'Restaurants'),
            ],
          ),
        ),
        body: Column(
          children: [
            _buildSearchBar(),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildFoodSearchTab(),
                  _buildRestaurantSearchTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          BlocBuilder<SearchBloc, SearchState>(
            builder: (context, state) {
              return TypeAheadField<String>(
                textFieldConfiguration: TextFieldConfiguration(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: _isSearchingFood 
                        ? 'Search for food items...' 
                        : 'Search for restaurants...',
                    prefixIcon: Icon(Icons.search),
                    suffixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildVoiceSearchButton(state),
                        _buildFilterButton(),
                      ],
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.grey[100],
                  ),
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      context.read<SearchBloc>()
                          .add(LoadSearchSuggestions(value));
                    }
                  },
                  onSubmitted: (value) => _performSearch(context, value),
                ),
                suggestionsCallback: (pattern) async {
                  if (state is SearchSuggestionsLoaded && 
                      state.query == pattern) {
                    return state.suggestions;
                  }
                  return [];
                },
                itemBuilder: (context, suggestion) {
                  return ListTile(
                    leading: Icon(Icons.history, color: Colors.grey),
                    title: Text(suggestion),
                    trailing: Icon(Icons.north_west, color: Colors.grey),
                  );
                },
                onSuggestionSelected: (suggestion) {
                  _searchController.text = suggestion;
                  _performSearch(context, suggestion);
                },
              );
            },
          ),
          SizedBox(height: 8),
          _buildTrendingSearches(),
        ],
      ),
    );
  }

  Widget _buildVoiceSearchButton(SearchState state) {
    return BlocListener<SearchBloc, SearchState>(
      listener: (context, state) {
        if (state is VoiceSearchListening) {
          _voiceAnimationController.repeat();
        } else {
          _voiceAnimationController.stop();
        }
        
        if (state is VoiceSearchResult) {
          _searchController.text = state.recognizedText;
          _performSearch(context, state.recognizedText);
        }
      },
      child: IconButton(
        onPressed: () {
          if (state is VoiceSearchListening) {
            context.read<SearchBloc>().add(StopVoiceSearch());
          } else {
            context.read<SearchBloc>().add(StartVoiceSearch());
          }
        },
        icon: AnimatedBuilder(
          animation: _voiceAnimationController,
          builder: (context, child) {
            return Transform.scale(
              scale: state is VoiceSearchListening 
                  ? 1.0 + (_voiceAnimationController.value * 0.2)
                  : 1.0,
              child: Icon(
                Icons.mic,
                color: state is VoiceSearchListening 
                    ? Colors.red 
                    : Colors.grey[600],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildFilterButton() {
    return IconButton(
      onPressed: () => _showFilterSheet(context),
      icon: Icon(Icons.tune, color: Colors.grey[600]),
    );
  }

  Widget _buildTrendingSearches() {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state is TrendingSearchesLoaded && state.trendingSearches.isNotEmpty) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Trending Searches',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: state.trendingSearches.take(5).map((search) {
                  return ActionChip(
                    label: Text(search),
                    onPressed: () {
                      _searchController.text = search;
                      _performSearch(context, search);
                    },
                    backgroundColor: Colors.orange.withOpacity(0.1),
                    labelStyle: TextStyle(color: Colors.orange[700]),
                  );
                }).toList(),
              ),
            ],
          );
        }
        return SizedBox.shrink();
      },
    );
  }

  Widget _buildFoodSearchTab() {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state is SearchLoading) {
          return _buildLoadingView();
        } else if (state is FoodItemSearchResults) {
          return _buildFoodResults(state);
        } else if (state is SearchError) {
          return _buildErrorView(state.message);
        }
        return _buildEmptySearchView();
      },
    );
  }

  Widget _buildRestaurantSearchTab() {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state is SearchLoading) {
          return _buildLoadingView();
        } else if (state is RestaurantSearchResults) {
          return _buildRestaurantResults(state);
        } else if (state is SearchError) {
          return _buildErrorView(state.message);
        }
        return _buildEmptySearchView();
      },
    );
  }

  Widget _buildLoadingView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/animations/search_loading.json',
            width: 150,
            height: 150,
          ),
          SizedBox(height: 16),
          Text(
            'Searching...',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildFoodResults(FoodItemSearchResults state) {
    if (state.results.isEmpty) {
      return _buildNoResultsView(state.query);
    }

    return Column(
      children: [
        _buildResultsHeader(state.results.length, state.query),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: state.results.length,
            itemBuilder: (context, index) {
              final result = state.results[index];
              return Container(
                margin: EdgeInsets.only(bottom: 12),
                child: FoodItemCard(
                  item: result.item,
                  onTap: () => _onFoodItemTap(result.item),
                  highlightedTerms: result.matchedTerms,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildRestaurantResults(RestaurantSearchResults state) {
    if (state.results.isEmpty) {
      return _buildNoResultsView(state.query);
    }

    return Column(
      children: [
        _buildResultsHeader(state.results.length, state.query),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: state.results.length,
            itemBuilder: (context, index) {
              final result = state.results[index];
              return Container(
                margin: EdgeInsets.only(bottom: 12),
                child: RestaurantCard(
                  restaurant: result.item,
                  onTap: () => _onRestaurantTap(result.item),
                  highlightedTerms: result.matchedTerms,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildResultsHeader(int count, String query) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Text(
            '$count results for "$query"',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
          Spacer(),
          TextButton.icon(
            onPressed: () => _showSortOptions(context),
            icon: Icon(Icons.sort, size: 18),
            label: Text('Sort'),
          ),
        ],
      ),
    );
  }

  Widget _buildNoResultsView(String query) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/animations/no_results.json',
            width: 200,
            height: 200,
          ),
          SizedBox(height: 16),
          Text(
            'No results found for "$query"',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(height: 8),
          Text(
            'Try adjusting your search or filters',
            style: TextStyle(color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorView(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 64, color: Colors.red),
          SizedBox(height: 16),
          Text(
            'Search Error',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(height: 8),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptySearchView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search, size: 64, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            'Start typing to search',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(height: 8),
          Text(
            'Find your favorite food or restaurants',
            style: TextStyle(color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  void _performSearch(BuildContext context, String query) {
    if (query.trim().isEmpty) return;

    if (_isSearchingFood) {
      context.read<SearchBloc>().add(SearchFoodItems(
        query: query,
        items: widget.foodItems,
      ));
    } else {
      context.read<SearchBloc>().add(SearchRestaurants(
        query: query,
        restaurants: widget.restaurants,
      ));
    }
  }

  void _showFilterSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => SearchFilterSheet(
        currentFilters: context.read<SearchBloc>().currentFilters,
        onFiltersApplied: (filters) {
          context.read<SearchBloc>().add(UpdateSearchFilters(filters));
          // Re-run search with new filters if there's a current query
          if (_searchController.text.isNotEmpty) {
            _performSearch(context, _searchController.text);
          }
        },
      ),
    );
  }

  void _showSortOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Sort by',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: 16),
            ListTile(
              leading: Icon(Icons.star),
              title: Text('Rating'),
              onTap: () => _applySorting('rating', false),
            ),
            ListTile(
              leading: Icon(Icons.attach_money),
              title: Text('Price: Low to High'),
              onTap: () => _applySorting('price', true),
            ),
            ListTile(
              leading: Icon(Icons.money_off),
              title: Text('Price: High to Low'),
              onTap: () => _applySorting('price', false),
            ),
            ListTile(
              leading: Icon(Icons.trending_up),
              title: Text('Popularity'),
              onTap: () => _applySorting('popularity', false),
            ),
          ],
        ),
      ),
    );
  }

  void _applySorting(String sortBy, bool ascending) {
    Navigator.pop(context);
    
    final currentFilters = context.read<SearchBloc>().currentFilters;
    final newFilters = (currentFilters ?? SearchFilters()).copyWith(
      sortBy: sortBy,
      ascending: ascending,
    );
    
    context.read<SearchBloc>().add(UpdateSearchFilters(newFilters));
    
    if (_searchController.text.isNotEmpty) {
      _performSearch(context, _searchController.text);
    }
  }

  void _onFoodItemTap(FoodItem item) {
    // Navigate to food item details
    Navigator.pop(context, item);
  }

  void _onRestaurantTap(Restaurant restaurant) {
    // Navigate to restaurant details
    Navigator.pop(context, restaurant);
  }
}
