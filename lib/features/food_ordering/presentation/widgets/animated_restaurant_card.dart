import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../domain/entities/restaurant.dart';

class AnimatedRestaurantCard extends StatefulWidget {
  final Restaurant restaurant;
  final VoidCallback onTap;

  const AnimatedRestaurantCard({
    Key? key,
    required this.restaurant,
    required this.onTap,
  }) : super(key: key);

  @override
  State<AnimatedRestaurantCard> createState() => _AnimatedRestaurantCardState();
}

class _AnimatedRestaurantCardState extends State<AnimatedRestaurantCard>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _favoriteController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _favoriteAnimation;
  
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    
    _scaleController = AnimationController(
      duration: Duration(milliseconds: 150),
      vsync: this,
    );
    
    _favoriteController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeInOut),
    );

    _favoriteAnimation = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(parent: _favoriteController, curve: Curves.elasticOut),
    );
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _favoriteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Container(
            margin: EdgeInsets.only(bottom: 16),
            child: Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(16),
              shadowColor: Colors.black.withOpacity(0.1),
              child: InkWell(
                onTap: () {
                  _scaleController.forward().then((_) {
                    _scaleController.reverse();
                    widget.onTap();
                  });
                  HapticFeedback.selectionClick();
                },
                onTapDown: (_) => _scaleController.forward(),
                onTapUp: (_) => _scaleController.reverse(),
                onTapCancel: () => _scaleController.reverse(),
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      _buildImageSection(),
                      Expanded(child: _buildContentSection()),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildImageSection() {
    return Container(
      width: 120,
      height: 120,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.horizontal(left: Radius.circular(16)),
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.orange.shade200,
                    Colors.orange.shade400,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: widget.restaurant.imageUrl.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: widget.restaurant.imageUrl,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          strokeWidth: 2,
                        ),
                      ),
                      errorWidget: (context, url, error) => Center(
                        child: Icon(
                          Icons.restaurant,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                    )
                  : Center(
                      child: Icon(
                        Icons.restaurant,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
            ),
          ),
          Positioned(
            top: 8,
            left: 8,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.star,
                    size: 12,
                    color: Colors.amber,
                  ),
                  SizedBox(width: 2),
                  Text(
                    widget.restaurant.rating.toStringAsFixed(1),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (widget.restaurant.deliveryFee == 0)
            Positioned(
              bottom: 8,
              left: 8,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'FREE',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildContentSection() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.restaurant.name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  AnimatedBuilder(
                    animation: _favoriteAnimation,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _favoriteAnimation.value,
                        child: GestureDetector(
                          onTap: _toggleFavorite,
                          child: Icon(
                            _isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: _isFavorite ? Colors.red : Colors.grey[400],
                            size: 20,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
              SizedBox(height: 4),
              Text(
                widget.restaurant.cuisine,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
          Row(
            children: [
              _buildInfoChip(
                Icons.access_time,
                '${widget.restaurant.deliveryTime} min',
                Colors.blue,
              ),
              SizedBox(width: 8),
              _buildInfoChip(
                Icons.delivery_dining,
                widget.restaurant.deliveryFee == 0
                    ? 'Free'
                    : '\$${widget.restaurant.deliveryFee.toStringAsFixed(2)}',
                widget.restaurant.deliveryFee == 0 ? Colors.green : Colors.orange,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String text, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 12,
            color: color,
          ),
          SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              fontSize: 10,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });
    
    _favoriteController.forward().then((_) {
      _favoriteController.reverse();
    });
    
    HapticFeedback.lightImpact();
  }
}
