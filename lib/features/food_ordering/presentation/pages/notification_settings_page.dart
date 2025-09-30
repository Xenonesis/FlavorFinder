import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../data/services/notification_service.dart';
import '../../../../core/theme/app_theme.dart';

class NotificationSettingsPage extends StatefulWidget {
  const NotificationSettingsPage({super.key});

  @override
  State<NotificationSettingsPage> createState() => _NotificationSettingsPageState();
}

class _NotificationSettingsPageState extends State<NotificationSettingsPage> {
  final NotificationService _notificationService = NotificationService();
  NotificationSettings? _settings;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    try {
      final settings = await _notificationService.getNotificationSettings();
      setState(() {
        _settings = settings;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _updateSettings(NotificationSettings newSettings) async {
    try {
      await _notificationService.updateNotificationSettings(newSettings);
      setState(() {
        _settings = newSettings;
      });
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Notification settings updated'),
            backgroundColor: AppTheme.successColor,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to update settings'),
            backgroundColor: AppTheme.errorColor,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Settings'),
        elevation: 0,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _settings == null
              ? const Center(child: Text('Failed to load settings'))
              : AnimationLimiter(
                  child: ListView(
                    padding: const EdgeInsets.all(16),
                    children: AnimationConfiguration.toStaggeredList(
                      duration: const Duration(milliseconds: 375),
                      childAnimationBuilder: (widget) => SlideAnimation(
                        horizontalOffset: 50.0,
                        child: FadeInAnimation(child: widget),
                      ),
                      children: [
                        // Header Card
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
                              Icon(
                                Icons.notifications_active,
                                size: 32,
                                color: Colors.white,
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Stay Updated',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      'Manage your notification preferences',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white70,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        const SizedBox(height: 24),
                        
                        // Master Toggle
                        _buildSettingCard(
                          icon: Icons.notifications,
                          title: 'Enable Notifications',
                          subtitle: 'Receive all notifications from FlavorFinder',
                          value: _settings!.notificationsEnabled,
                          onChanged: (value) {
                            final newSettings = NotificationSettings(
                              notificationsEnabled: value,
                              orderUpdates: _settings!.orderUpdates,
                              promotions: _settings!.promotions,
                              newRestaurants: _settings!.newRestaurants,
                            );
                            _updateSettings(newSettings);
                          },
                          isEnabled: true,
                        ),
                        
                        const SizedBox(height: 16),
                        
                        // Order Updates
                        _buildSettingCard(
                          icon: Icons.shopping_bag,
                          title: 'Order Updates',
                          subtitle: 'Get notified about your order status',
                          value: _settings!.orderUpdates,
                          onChanged: (value) {
                            final newSettings = _settings!.copyWith(
                              orderUpdates: value,
                            );
                            _updateSettings(newSettings);
                          },
                          isEnabled: _settings!.notificationsEnabled,
                        ),
                        
                        const SizedBox(height: 16),
                        
                        // Promotions
                        _buildSettingCard(
                          icon: Icons.local_offer,
                          title: 'Promotions & Offers',
                          subtitle: 'Receive special deals and discounts',
                          value: _settings!.promotions,
                          onChanged: (value) {
                            final newSettings = _settings!.copyWith(
                              promotions: value,
                            );
                            _updateSettings(newSettings);
                          },
                          isEnabled: _settings!.notificationsEnabled,
                        ),
                        
                        const SizedBox(height: 16),
                        
                        // New Restaurants
                        _buildSettingCard(
                          icon: Icons.restaurant,
                          title: 'New Restaurants',
                          subtitle: 'Know when new restaurants join FlavorFinder',
                          value: _settings!.newRestaurants,
                          onChanged: (value) {
                            final newSettings = _settings!.copyWith(
                              newRestaurants: value,
                            );
                            _updateSettings(newSettings);
                          },
                          isEnabled: _settings!.notificationsEnabled,
                        ),
                        
                        const SizedBox(height: 32),
                        
                        // Test Notification Button
                        if (_settings!.notificationsEnabled)
                          Container(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: _sendTestNotification,
                              icon: const Icon(Icons.send, color: Colors.white),
                              label: const Text(
                                'Send Test Notification',
                                style: TextStyle(color: Colors.white),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppTheme.primaryColor,
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                        
                        const SizedBox(height: 16),
                        
                        // Info Card
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.blue.withOpacity(0.3),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.info_outline,
                                color: Colors.blue[700],
                              ),
                              const SizedBox(width: 12),
                              const Expanded(
                                child: Text(
                                  'You can change these settings anytime. We respect your privacy and will only send relevant notifications.',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.blue,
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
    );
  }

  Widget _buildSettingCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
    required bool isEnabled,
  }) {
    return Container(
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
            color: isEnabled
                ? AppTheme.primaryColor.withOpacity(0.1)
                : Colors.grey.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: isEnabled ? AppTheme.primaryColor : Colors.grey,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: isEnabled ? Colors.black : Colors.grey,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            color: isEnabled ? Colors.grey[600] : Colors.grey[400],
          ),
        ),
        trailing: Switch(
          value: value && isEnabled,
          onChanged: isEnabled ? onChanged : null,
          activeColor: AppTheme.primaryColor,
        ),
        contentPadding: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Future<void> _sendTestNotification() async {
    await _notificationService.showLocalNotification(
      title: '🎉 Test Notification',
      body: 'This is a test notification from FlavorFinder!',
    );
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Test notification sent!'),
          backgroundColor: AppTheme.successColor,
        ),
      );
    }
  }
}
