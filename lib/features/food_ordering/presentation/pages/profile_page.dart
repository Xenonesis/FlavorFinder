import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../bloc/favorites/favorites_bloc.dart';
import '../bloc/favorites/favorites_state.dart';
import '../bloc/favorites/favorites_event.dart';
import '../../../../core/theme/theme_bloc.dart';
import 'favorites_page.dart';
import 'order_history_page.dart';
import 'notification_settings_page.dart';
import '../../../../core/theme/app_theme.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        elevation: 0,
      ),
      body: AnimationLimiter(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: AnimationConfiguration.toStaggeredList(
            duration: const Duration(milliseconds: 375),
            childAnimationBuilder: (widget) => SlideAnimation(
              horizontalOffset: 50.0,
              child: FadeInAnimation(child: widget),
            ),
            children: [
              // Profile Header
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppTheme.primaryColor,
                      AppTheme.primaryColor.withOpacity(0.8),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.person,
                        size: 35,
                        color: AppTheme.primaryColor,
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'John Doe',
                            style: TextStyle(
                              inherit: false,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 0.1,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'john.doe@example.com',
                            style: TextStyle(
                              inherit: false,
                              fontSize: 14,
                              color: Colors.white70,
                              letterSpacing: 0.1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Quick Stats
              Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      icon: Icons.shopping_bag,
                      title: 'Orders',
                      value: '12',
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: BlocBuilder<FavoritesBloc, FavoritesState>(
                      builder: (context, state) {
                        return _buildStatCard(
                          icon: Icons.favorite,
                          title: 'Favorites',
                          value: '${state.favoriteRestaurantIds.length}',
                          color: Colors.red,
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildStatCard(
                      icon: Icons.star,
                      title: 'Reviews',
                      value: '8',
                      color: Colors.amber,
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 24),
              
              // Menu Items
              _buildMenuItem(
                icon: Icons.history,
                title: 'Order History',
                subtitle: 'View your past orders',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const OrderHistoryPage(),
                    ),
                  );
                },
              ),
              
              _buildMenuItem(
                icon: Icons.favorite,
                title: 'Favorites',
                subtitle: 'Your favorite restaurants',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FavoritesPage(),
                    ),
                  );
                },
              ),
              
              _buildMenuItem(
                icon: Icons.location_on,
                title: 'Addresses',
                subtitle: 'Manage delivery addresses',
                onTap: () {
                  // Navigate to addresses page
                },
              ),
              
              _buildMenuItem(
                icon: Icons.payment,
                title: 'Payment Methods',
                subtitle: 'Manage payment options',
                onTap: () {
                  // Navigate to payment methods page
                },
              ),
              
              _buildMenuItem(
                icon: Icons.notifications,
                title: 'Notifications',
                subtitle: 'Notification preferences',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NotificationSettingsPage(),
                    ),
                  );
                },
              ),
              
              BlocBuilder<ThemeBloc, ThemeState>(
                builder: (context, themeState) {
                  return _buildMenuItem(
                    icon: Icons.dark_mode,
                    title: 'Dark Mode',
                    subtitle: 'Toggle dark theme',
                    trailing: Switch(
                      value: themeState.isDarkMode,
                      onChanged: (value) {
                        context.read<ThemeBloc>().add(ToggleTheme());
                      },
                      activeColor: AppTheme.primaryColor,
                    ),
                    onTap: null,
                  );
                },
              ),
              
              _buildMenuItem(
                icon: Icons.help,
                title: 'Help & Support',
                subtitle: 'Get help and contact us',
                onTap: () {
                  // Navigate to help page
                },
              ),
              
              _buildMenuItem(
                icon: Icons.info,
                title: 'About',
                subtitle: 'App version and info',
                onTap: () {
                  _showAboutDialog(context);
                },
              ),
              
              const SizedBox(height: 24),
              
              // Logout Button
              Container(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    _showLogoutDialog(context);
                  },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    side: const BorderSide(color: Colors.red),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Logout',
                    style: TextStyle(
                      inherit: false,
                      color: Colors.red,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.1,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              inherit: false,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
              letterSpacing: 0.1,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              inherit: false,
              fontSize: 12,
              color: Colors.grey[600],
              letterSpacing: 0.1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required String subtitle,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return Container(
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
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppTheme.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: AppTheme.primaryColor),
        ),
        title: Text(
          title,
          style: const TextStyle(
            inherit: false,
            fontWeight: FontWeight.w600,
            fontSize: 16,
            letterSpacing: 0.1,
          ),
        ),
        subtitle: Text(subtitle),
        trailing: trailing ?? const Icon(Icons.chevron_right),
        onTap: onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Implement logout logic
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('Logout', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: 'FlavorFinder',
      applicationVersion: '1.0.0',
      applicationIcon: const Icon(
        Icons.restaurant_menu,
        size: 48,
        color: AppTheme.primaryColor,
      ),
      children: [
        const Text(
          'FlavorFinder is your ultimate food delivery companion. Discover amazing restaurants, track your orders, and enjoy delicious meals delivered to your doorstep.',
        ),
        const SizedBox(height: 16),
        const Text(
          'Features:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const Text('• Restaurant browsing and search'),
        const Text('• Order tracking and history'),
        const Text('• Favorites and recommendations'),
        const Text('• Secure payment processing'),
        const Text('• Real-time notifications'),
      ],
    );
  }
}
