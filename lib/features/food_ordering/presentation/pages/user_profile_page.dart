import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../bloc/user_profile_bloc.dart';
import '../widgets/order_history_card.dart';
import '../widgets/user_stats_card.dart';
import '../widgets/preferences_sheet.dart';
import '../widgets/theme_toggle_widget.dart';
import '../../domain/entities/user_profile.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserProfileBloc()..add(LoadUserProfile()),
      child: Scaffold(
        body: BlocBuilder<UserProfileBloc, UserProfileState>(
          builder: (context, state) {
            if (state is UserProfileLoading) {
              return _buildLoadingView();
            } else if (state is UserProfileLoaded) {
              return _buildProfileView(state.profile, state.insights);
            } else if (state is UserProfileError) {
              return _buildErrorView(state.message);
            }
            return _buildEmptyView();
          },
        ),
      ),
    );
  }

  Widget _buildLoadingView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text('Loading profile...'),
        ],
      ),
    );
  }

  Widget _buildProfileView(UserProfile profile, Map<String, dynamic> insights) {
    return CustomScrollView(
      slivers: [
        _buildProfileHeader(profile),
        SliverToBoxAdapter(
          child: Column(
            children: [
              _buildMembershipCard(profile.stats),
              _buildTabBar(),
            ],
          ),
        ),
        SliverFillRemaining(
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildOverviewTab(profile, insights),
              _buildOrderHistoryTab(profile.orderHistory),
              _buildFavoritesTab(profile),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProfileHeader(UserProfile profile) {
    return SliverAppBar(
      expandedHeight: 200,
      pinned: true,
      backgroundColor: Colors.orange,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.orange.shade400, Colors.deepOrange.shade600],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    backgroundImage: profile.profileImageUrl != null
                        ? CachedNetworkImageProvider(profile.profileImageUrl!)
                        : null,
                    child: profile.profileImageUrl == null
                        ? Icon(Icons.person, size: 40, color: Colors.orange)
                        : null,
                  ),
                  SizedBox(height: 12),
                  Text(
                    profile.name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    profile.email,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      actions: [
        IconButton(
          onPressed: () => _showPreferencesSheet(context, profile.preferences),
          icon: Icon(Icons.settings, color: Colors.white),
        ),
      ],
    );
  }

  Widget _buildMembershipCard(UserStats stats) {
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: _getMembershipColors(stats.membershipTier),
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            _getMembershipIcon(stats.membershipTier),
            color: Colors.white,
            size: 32,
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${stats.membershipTier.toUpperCase()} MEMBER',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${stats.loyaltyPoints} Loyalty Points',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${stats.totalOrders}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Orders',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          color: Colors.orange,
          borderRadius: BorderRadius.circular(12),
        ),
        labelColor: Colors.white,
        unselectedLabelColor: Colors.grey[600],
        tabs: [
          Tab(text: 'Overview'),
          Tab(text: 'Orders'),
          Tab(text: 'Favorites'),
        ],
      ),
    );
  }

  Widget _buildOverviewTab(UserProfile profile, Map<String, dynamic> insights) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: AnimationLimiter(
        child: Column(
          children: AnimationConfiguration.toStaggeredList(
            duration: Duration(milliseconds: 375),
            childAnimationBuilder: (widget) => SlideAnimation(
              horizontalOffset: 50.0,
              child: FadeInAnimation(child: widget),
            ),
            children: [
              ThemeToggleWidget(),
              SizedBox(height: 16),
              UserStatsCard(
                title: 'Spending Overview',
                stats: {
                  'Total Spent': '\$${profile.stats.totalSpent.toStringAsFixed(2)}',
                  'Average Order': '\$${profile.stats.averageOrderValue.toStringAsFixed(2)}',
                  'This Month': '\$${_getThisMonthSpending(insights)}',
                },
                icon: Icons.account_balance_wallet,
                color: Colors.blue,
              ),
              SizedBox(height: 16),
              UserStatsCard(
                title: 'Preferences',
                stats: {
                  'Favorite Cuisine': profile.stats.favoriteCuisine.isEmpty 
                      ? 'Not set' : profile.stats.favoriteCuisine,
                  'Favorite Category': profile.stats.favoriteCategory.isEmpty 
                      ? 'Not set' : profile.stats.favoriteCategory,
                  'Spicy Tolerance': '${(profile.preferences.spicyTolerance * 10).round()}/10',
                },
                icon: Icons.favorite,
                color: Colors.red,
              ),
              SizedBox(height: 16),
              UserStatsCard(
                title: 'Activity',
                stats: {
                  'Order Frequency': '${insights['orderFrequency']?.toStringAsFixed(1) ?? '0'} per day',
                  'Member Since': _formatDate(profile.createdAt),
                  'Last Active': _formatDate(profile.lastActiveAt),
                },
                icon: Icons.timeline,
                color: Colors.green,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOrderHistoryTab(List<OrderHistory> orderHistory) {
    if (orderHistory.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.receipt_long, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'No orders yet',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: 8),
            Text(
              'Your order history will appear here',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: orderHistory.length,
      itemBuilder: (context, index) {
        return AnimationConfiguration.staggeredList(
          position: index,
          duration: Duration(milliseconds: 375),
          child: SlideAnimation(
            verticalOffset: 50.0,
            child: FadeInAnimation(
              child: OrderHistoryCard(
                order: orderHistory[index],
                onTap: () => _showOrderDetails(orderHistory[index]),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildFavoritesTab(UserProfile profile) {
    final hasFavorites = profile.favoriteRestaurants.isNotEmpty || 
                        profile.favoriteFoodItems.isNotEmpty;

    if (!hasFavorites) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.favorite_border, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'No favorites yet',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: 8),
            Text(
              'Add items to your favorites to see them here',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (profile.favoriteRestaurants.isNotEmpty) ...[
            Text(
              'Favorite Restaurants',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12),
            ...profile.favoriteRestaurants.map((restaurantId) {
              return Card(
                margin: EdgeInsets.only(bottom: 8),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.orange.withOpacity(0.1),
                    child: Icon(Icons.restaurant, color: Colors.orange),
                  ),
                  title: Text('Restaurant $restaurantId'), // Would fetch actual name
                  trailing: IconButton(
                    onPressed: () => _removeFromFavorites(restaurantId, 'restaurant'),
                    icon: Icon(Icons.favorite, color: Colors.red),
                  ),
                ),
              );
            }).toList(),
            SizedBox(height: 24),
          ],
          if (profile.favoriteFoodItems.isNotEmpty) ...[
            Text(
              'Favorite Food Items',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12),
            ...profile.favoriteFoodItems.map((itemId) {
              return Card(
                margin: EdgeInsets.only(bottom: 8),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.orange.withOpacity(0.1),
                    child: Icon(Icons.fastfood, color: Colors.orange),
                  ),
                  title: Text('Food Item $itemId'), // Would fetch actual name
                  trailing: IconButton(
                    onPressed: () => _removeFromFavorites(itemId, 'food'),
                    icon: Icon(Icons.favorite, color: Colors.red),
                  ),
                ),
              );
            }).toList(),
          ],
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
            'Profile Error',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(height: 8),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey[600]),
          ),
          SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              context.read<UserProfileBloc>().add(LoadUserProfile());
            },
            child: Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.person_outline, size: 64, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            'No profile found',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }

  List<Color> _getMembershipColors(String tier) {
    switch (tier.toLowerCase()) {
      case 'platinum':
        return [Colors.grey.shade300, Colors.grey.shade600];
      case 'gold':
        return [Colors.amber.shade300, Colors.amber.shade600];
      case 'silver':
        return [Colors.blueGrey.shade300, Colors.blueGrey.shade600];
      default:
        return [Colors.brown.shade300, Colors.brown.shade600];
    }
  }

  IconData _getMembershipIcon(String tier) {
    switch (tier.toLowerCase()) {
      case 'platinum':
        return Icons.diamond;
      case 'gold':
        return Icons.star;
      case 'silver':
        return Icons.star_half;
      default:
        return Icons.star_border;
    }
  }

  String _getThisMonthSpending(Map<String, dynamic> insights) {
    final monthlySpending = insights['monthlySpending'] as Map<String, double>?;
    if (monthlySpending == null) return '0.00';
    
    final now = DateTime.now();
    final thisMonth = '${now.year}-${now.month.toString().padLeft(2, '0')}';
    return (monthlySpending[thisMonth] ?? 0.0).toStringAsFixed(2);
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);
    
    if (difference.inDays == 0) {
      return 'Today';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }

  void _showPreferencesSheet(BuildContext context, UserPreferences preferences) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => PreferencesSheet(
        preferences: preferences,
        onPreferencesUpdated: (updatedPreferences) {
          context.read<UserProfileBloc>()
              .add(UpdateUserPreferences(updatedPreferences));
        },
      ),
    );
  }

  void _showOrderDetails(OrderHistory order) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Order #${order.orderId}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Restaurant: ${order.restaurantName}'),
            Text('Date: ${_formatDate(order.orderDate)}'),
            Text('Total: \$${order.totalAmount.toStringAsFixed(2)}'),
            Text('Status: ${order.status}'),
            if (order.rating != null)
              Text('Rating: ${order.rating} ⭐'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  void _removeFromFavorites(String itemId, String type) {
    context.read<UserProfileBloc>()
        .add(RemoveFromFavorites(itemId, type));
  }
}
