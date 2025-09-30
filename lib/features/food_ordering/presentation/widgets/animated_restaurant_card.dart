import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/theme/premium_theme.dart';

class AnimatedRestaurantCard extends StatefulWidget {
  final Map<String, dynamic> restaurant;
  final VoidCallback onTap;
  final int index;

  const AnimatedRestaurantCard({
    super.key,
    required this.restaurant,
    required this.onTap,
    this.index = 0,
  });

  @override
  State<AnimatedRestaurantCard> createState() => _AnimatedRestaurantCardState();
}

class _AnimatedRestaurantCardState extends State<AnimatedRestaurantCard>
    with TickerProviderStateMixin {
  late AnimationController _hoverController;
  late AnimationController _favoriteController;
  late Animation<double> _hoverAnimation;
  late Animation<double> _favoriteAnimation;
  
  bool _isFavorite = false;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _initAnimations();
  }

  void _initAnimations() {
    _hoverController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _favoriteController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _hoverAnimation = CurvedAnimation(
      parent: _hoverController,
      curve: Curves.easeInOut,
    );
    _favoriteAnimation = CurvedAnimation(
      parent: _favoriteController,
      curve: Curves.elasticOut,
    );
  }

  @override
  void dispose() {
    _hoverController.dispose();
    _favoriteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _hoverAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: 1.0 + (_hoverAnimation.value * 0.02),
          child: GestureDetector(
            onTap: () {
              HapticFeedback.mediumImpact();
              widget.onTap();
            },
            onTapDown: (_) => _onHover(true),
            onTapUp: (_) => _onHover(false),
            onTapCancel: () => _onHover(false),
            child: Container(
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08 + (0.04 * _hoverAnimation.value)),
                    blurRadius: 12 + (8 * _hoverAnimation.value),
                    offset: Offset(0, 4 + (4 * _hoverAnimation.value)),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildImageSection(),
                  _buildContentSection(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildImageSection() {
    return Stack(
      children: [
        // Main image container
        Container(
          height: 180,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            gradient: LinearGradient(
              colors: [
                PremiumTheme.primaryOrange.withOpacity(0.1),
                PremiumTheme.accentGold.withOpacity(0.1),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: Hero(
              tag: 'restaurant_${widget.index}',
              child: Text(
                widget.restaurant['image'] ?? '🍽️',
                style: const TextStyle(fontSize: 64),
              ),
            ),
          ),
        ),
        
        // Gradient overlay
        Container(
          height: 180,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            gradient: LinearGradient(
              colors: [
                Colors.transparent,
                Colors.black.withOpacity(0.1),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        
        // Top badges
        Positioned(
          top: 12,
          left: 12,
          child: _buildPromoBadge(),
        ),
        
        // Favorite button
        Positioned(
          top: 12,
          right: 12,
          child: _buildFavoriteButton(),
        ),
        
        // Delivery time badge
        Positioned(
          bottom: 12,
          right: 12,
          child: _buildDeliveryTimeBadge(),
        ),
      ],
    );
  }

  Widget _buildPromoBadge() {
    if (widget.restaurant['hasPromo'] != true) {
      return const SizedBox.shrink();
    }
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: PremiumTheme.error,
        borderRadius: BorderRadius.circular(12),
        boxShadow: PremiumTheme.cardShadow,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.local_fire_department, 
              color: Colors.white, size: 12),
          const SizedBox(width: 4),
          Text(
            '20% OFF',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFavoriteButton() {
    return AnimatedBuilder(
      animation: _favoriteAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: 1.0 + (_favoriteAnimation.value * 0.2),
          child: GestureDetector(
            onTap: () {
              HapticFeedback.lightImpact();
              setState(() => _isFavorite = !_isFavorite);
              if (_isFavorite) {
                _favoriteController.forward();
              } else {
                _favoriteController.reverse();
              }
            },
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                shape: BoxShape.circle,
                boxShadow: PremiumTheme.cardShadow,
              ),
              child: Icon(
                _isFavorite ? Icons.favorite : Icons.favorite_border,
                color: _isFavorite ? PremiumTheme.error : PremiumTheme.textSecondary,
                size: 18,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDeliveryTimeBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(12),
        boxShadow: PremiumTheme.cardShadow,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.access_time, 
              color: PremiumTheme.primaryOrange, size: 12),
          const SizedBox(width: 4),
          Text(
            widget.restaurant['time'] ?? '25-30 min',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContentSection() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Restaurant name and rating
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  widget.restaurant['name'] ?? 'Restaurant Name',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              _buildRatingChip(),
            ],
          ),
          
          const SizedBox(height: 8),
          
          // Cuisine and price range
          Row(
            children: [
              Icon(
                Icons.restaurant_menu,
                color: PremiumTheme.textSecondary,
                size: 16,
              ),
              const SizedBox(width: 4),
              Text(
                widget.restaurant['cuisine'] ?? 'International',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: PremiumTheme.textSecondary,
                ),
              ),
              const SizedBox(width: 16),
              Text(
                '•',
                style: TextStyle(color: PremiumTheme.textSecondary),
              ),
              const SizedBox(width: 16),
              Text(
                '\$\$',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: PremiumTheme.primaryOrange,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 12),
          
          // Features row
          _buildFeaturesRow(),
        ],
      ),
    );
  }

  Widget _buildRatingChip() {
    final rating = widget.restaurant['rating'] ?? 4.5;
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: PremiumTheme.success.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.star, color: PremiumTheme.success, size: 14),
          const SizedBox(width: 4),
          Text(
            rating.toString(),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: PremiumTheme.success,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturesRow() {
    final features = [
      {'icon': Icons.delivery_dining, 'text': 'Free Delivery'},
      {'icon': Icons.access_time, 'text': 'Fast'},
      {'icon': Icons.verified, 'text': 'Verified'},
    ];
    
    return Row(
      children: features.map((feature) {
        return Container(
          margin: const EdgeInsets.only(right: 12),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                feature['icon'] as IconData,
                color: PremiumTheme.primaryOrange,
                size: 14,
              ),
              const SizedBox(width: 4),
              Text(
                feature['text'] as String,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: PremiumTheme.textSecondary,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  void _onHover(bool isHovered) {
    setState(() => _isHovered = isHovered);
    if (isHovered) {
      _hoverController.forward();
    } else {
      _hoverController.reverse();
    }
  }
}

class RestaurantCardShimmer extends StatefulWidget {
  const RestaurantCardShimmer({super.key});

  @override
  State<RestaurantCardShimmer> createState() => _RestaurantCardShimmerState();
}

class _RestaurantCardShimmerState extends State<RestaurantCardShimmer>
    with SingleTickerProviderStateMixin {
  late AnimationController _shimmerController;
  late Animation<double> _shimmerAnimation;

  @override
  void initState() {
    super.initState();
    _shimmerController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _shimmerAnimation = CurvedAnimation(
      parent: _shimmerController,
      curve: Curves.easeInOut,
    );
    _shimmerController.repeat();
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _shimmerAnimation,
      builder: (context, child) {
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: PremiumTheme.cardShadow,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image shimmer
              Container(
                height: 180,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                  gradient: LinearGradient(
                    colors: [
                      Colors.grey.shade300,
                      Colors.grey.shade100,
                      Colors.grey.shade300,
                    ],
                    stops: [
                      0.0,
                      _shimmerAnimation.value,
                      1.0,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
              
              // Content shimmer
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 20,
                      width: double.infinity * 0.7,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 14,
                      width: double.infinity * 0.5,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Container(
                          height: 12,
                          width: 60,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Container(
                          height: 12,
                          width: 40,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
