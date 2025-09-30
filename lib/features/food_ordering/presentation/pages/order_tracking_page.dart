import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/theme/premium_theme.dart';

class OrderTrackingPage extends StatefulWidget {
  const OrderTrackingPage({super.key});

  @override
  State<OrderTrackingPage> createState() => _OrderTrackingPageState();
}

class _OrderTrackingPageState extends State<OrderTrackingPage>
    with TickerProviderStateMixin {
  late AnimationController _mapController;
  late AnimationController _statusController;
  late AnimationController _pulseController;
  late Animation<double> _mapAnimation;
  late Animation<double> _statusAnimation;
  late Animation<double> _pulseAnimation;

  int _currentStep = 2; // 0: Confirmed, 1: Preparing, 2: On the way, 3: Delivered
  String _estimatedTime = '15-20 min';
  String _driverName = 'John Smith';
  double _driverRating = 4.8;

  @override
  void initState() {
    super.initState();
    _initAnimations();
    _simulateOrderProgress();
  }

  void _initAnimations() {
    _mapController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _statusController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _mapAnimation = CurvedAnimation(
      parent: _mapController,
      curve: Curves.easeOutBack,
    );
    _statusAnimation = CurvedAnimation(
      parent: _statusController,
      curve: Curves.easeOutQuart,
    );
    _pulseAnimation = CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    );

    _mapController.forward();
    _statusController.forward();
    _pulseController.repeat(reverse: true);
  }

  void _simulateOrderProgress() {
    // Simulate order status updates
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted && _currentStep < 3) {
        setState(() {
          _currentStep++;
          if (_currentStep == 3) {
            _estimatedTime = 'Delivered!';
          }
        });
        _statusController.reset();
        _statusController.forward();
      }
    });
  }

  @override
  void dispose() {
    _mapController.dispose();
    _statusController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildMap(),
                  _buildOrderStatus(),
                  _buildDriverInfo(),
                  _buildOrderDetails(),
                  _buildActions(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 50, 16, 16),
      decoration: BoxDecoration(
        gradient: PremiumTheme.primaryGradient,
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24)),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Order Tracking',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Order #FF-2024-001',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.support_agent, color: Colors.white),
            onPressed: () => _contactSupport(),
          ),
        ],
      ),
    );
  }

  Widget _buildMap() {
    return AnimatedBuilder(
      animation: _mapAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: 0.8 + (0.2 * _mapAnimation.value),
          child: Opacity(
            opacity: _mapAnimation.value,
            child: Container(
              height: 250,
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: PremiumTheme.elevatedShadow,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Stack(
                  children: [
                    // Map background
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.blue.shade100,
                            Colors.green.shade100,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          '🗺️',
                          style: TextStyle(fontSize: 64),
                        ),
                      ),
                    ),
                    // Driver location pulse
                    Positioned(
                      top: 100,
                      left: 150,
                      child: AnimatedBuilder(
                        animation: _pulseAnimation,
                        builder: (context, child) {
                          return Container(
                            width: 20 + (10 * _pulseAnimation.value),
                            height: 20 + (10 * _pulseAnimation.value),
                            decoration: BoxDecoration(
                              color: PremiumTheme.primaryOrange.withOpacity(
                                0.3 + (0.4 * (1 - _pulseAnimation.value)),
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Container(
                                width: 12,
                                height: 12,
                                decoration: const BoxDecoration(
                                  color: PremiumTheme.primaryOrange,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    // Destination marker
                    const Positioned(
                      bottom: 50,
                      right: 80,
                      child: Icon(
                        Icons.location_on,
                        color: PremiumTheme.error,
                        size: 32,
                      ),
                    ),
                    // ETA overlay
                    Positioned(
                      top: 16,
                      left: 16,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: PremiumTheme.cardShadow,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.access_time, 
                                color: PremiumTheme.primaryOrange, size: 16),
                            const SizedBox(width: 4),
                            Text(
                              _estimatedTime,
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildOrderStatus() {
    final steps = [
      {'title': 'Order Confirmed', 'subtitle': 'We received your order', 'icon': Icons.check_circle},
      {'title': 'Preparing', 'subtitle': 'Restaurant is preparing your food', 'icon': Icons.restaurant},
      {'title': 'On the way', 'subtitle': 'Driver is coming to you', 'icon': Icons.delivery_dining},
      {'title': 'Delivered', 'subtitle': 'Enjoy your meal!', 'icon': Icons.home},
    ];

    return AnimatedBuilder(
      animation: _statusAnimation,
      builder: (context, child) {
        return Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: PremiumTheme.cardShadow,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Order Status',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              ...steps.asMap().entries.map((entry) {
                final index = entry.key;
                final step = entry.value;
                final isCompleted = index <= _currentStep;
                final isCurrent = index == _currentStep;
                
                return Transform.translate(
                  offset: Offset(0, 20 * (1 - _statusAnimation.value)),
                  child: Opacity(
                    opacity: _statusAnimation.value,
                    child: _buildStatusStep(
                      step['title'] as String,
                      step['subtitle'] as String,
                      step['icon'] as IconData,
                      isCompleted,
                      isCurrent,
                      index < steps.length - 1,
                    ),
                  ),
                );
              }).toList(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStatusStep(
    String title,
    String subtitle,
    IconData icon,
    bool isCompleted,
    bool isCurrent,
    bool hasNext,
  ) {
    return Column(
      children: [
        Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: isCompleted 
                    ? PremiumTheme.primaryOrange 
                    : Colors.grey.shade200,
                shape: BoxShape.circle,
                boxShadow: isCurrent ? PremiumTheme.cardShadow : null,
              ),
              child: Icon(
                icon,
                color: isCompleted ? Colors.white : Colors.grey.shade400,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: isCompleted 
                          ? PremiumTheme.textPrimary 
                          : Colors.grey.shade600,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: isCompleted 
                          ? PremiumTheme.textSecondary 
                          : Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
            ),
            if (isCurrent)
              AnimatedBuilder(
                animation: _pulseController,
                builder: (context, child) {
                  return Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: PremiumTheme.primaryOrange.withOpacity(
                        0.5 + (0.5 * _pulseAnimation.value),
                      ),
                      shape: BoxShape.circle,
                    ),
                  );
                },
              ),
          ],
        ),
        if (hasNext)
          Container(
            margin: const EdgeInsets.only(left: 24, top: 8, bottom: 8),
            width: 2,
            height: 30,
            color: isCompleted 
                ? PremiumTheme.primaryOrange.withOpacity(0.3)
                : Colors.grey.shade300,
          ),
      ],
    );
  }

  Widget _buildDriverInfo() {
    if (_currentStep < 2) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: PremiumTheme.cardShadow,
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              gradient: PremiumTheme.primaryGradient,
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Text(
                '👨‍🍳',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _driverName,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Row(
                  children: [
                    const Icon(Icons.star, color: PremiumTheme.success, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      _driverRating.toString(),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: PremiumTheme.success,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Delivery Partner',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: PremiumTheme.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.phone, color: PremiumTheme.primaryOrange),
                onPressed: () => _callDriver(),
              ),
              IconButton(
                icon: const Icon(Icons.message, color: PremiumTheme.accentGold),
                onPressed: () => _messageDriver(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOrderDetails() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: PremiumTheme.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Order Details',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildOrderItem('Margherita Pizza', 'Large', '\$12.99', 2),
          _buildOrderItem('Chicken Wings', '6 pieces', '\$8.99', 1),
          _buildOrderItem('Coca Cola', '500ml', '\$2.99', 2),
          const Divider(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '\$37.96',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: PremiumTheme.primaryOrange,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOrderItem(String name, String description, String price, int quantity) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: PremiumTheme.primaryOrange,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: PremiumTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Text(
            'x$quantity',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: PremiumTheme.textSecondary,
            ),
          ),
          const SizedBox(width: 16),
          Text(
            price,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActions() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          if (_currentStep < 3)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _cancelOrder(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade50,
                  foregroundColor: Colors.red,
                  elevation: 0,
                ),
                child: const Text('Cancel Order'),
              ),
            ),
          if (_currentStep == 3) ...[
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _rateOrder(),
                child: const Text('Rate Your Experience'),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => _reorder(),
                child: const Text('Order Again'),
              ),
            ),
          ],
        ],
      ),
    );
  }

  void _contactSupport() {
    HapticFeedback.lightImpact();
    // Contact support
  }

  void _callDriver() {
    HapticFeedback.mediumImpact();
    // Call driver
  }

  void _messageDriver() {
    HapticFeedback.lightImpact();
    // Message driver
  }

  void _cancelOrder() {
    HapticFeedback.mediumImpact();
    // Cancel order
  }

  void _rateOrder() {
    HapticFeedback.lightImpact();
    // Rate order
  }

  void _reorder() {
    HapticFeedback.lightImpact();
    // Reorder
  }
}
