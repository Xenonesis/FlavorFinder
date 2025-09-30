import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/theme/premium_theme.dart';

class AnimatedFloatingCart extends StatefulWidget {
  final int itemCount;
  final double totalPrice;
  final VoidCallback onPressed;

  const AnimatedFloatingCart({
    super.key,
    required this.itemCount,
    required this.totalPrice,
    required this.onPressed,
  });

  @override
  State<AnimatedFloatingCart> createState() => _AnimatedFloatingCartState();
}

class _AnimatedFloatingCartState extends State<AnimatedFloatingCart>
    with TickerProviderStateMixin {
  late AnimationController _bounceController;
  late AnimationController _pulseController;
  late AnimationController _badgeController;
  late Animation<double> _bounceAnimation;
  late Animation<double> _pulseAnimation;
  late Animation<double> _badgeAnimation;

  int _previousItemCount = 0;

  @override
  void initState() {
    super.initState();
    _initAnimations();
    _previousItemCount = widget.itemCount;
  }

  void _initAnimations() {
    _bounceController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _badgeController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _bounceAnimation = CurvedAnimation(
      parent: _bounceController,
      curve: Curves.elasticOut,
    );
    _pulseAnimation = CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    );
    _badgeAnimation = CurvedAnimation(
      parent: _badgeController,
      curve: Curves.elasticOut,
    );

    _pulseController.repeat(reverse: true);
  }

  @override
  void didUpdateWidget(AnimatedFloatingCart oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    if (widget.itemCount != _previousItemCount) {
      if (widget.itemCount > _previousItemCount) {
        // Item added - bounce animation
        _bounceController.forward().then((_) {
          _bounceController.reverse();
        });
        
        // Badge animation
        _badgeController.forward().then((_) {
          _badgeController.reverse();
        });
        
        // Haptic feedback
        HapticFeedback.lightImpact();
      }
      _previousItemCount = widget.itemCount;
    }
  }

  @override
  void dispose() {
    _bounceController.dispose();
    _pulseController.dispose();
    _badgeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.itemCount == 0) {
      return const SizedBox.shrink();
    }

    return AnimatedBuilder(
      animation: Listenable.merge([_bounceAnimation, _pulseAnimation]),
      builder: (context, child) {
        return Transform.scale(
          scale: 1.0 + (_bounceAnimation.value * 0.2),
          child: Container(
            margin: const EdgeInsets.all(16),
            child: Stack(
              children: [
                // Main cart button
                Container(
                  decoration: BoxDecoration(
                    gradient: PremiumTheme.primaryGradient,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: PremiumTheme.primaryOrange.withOpacity(0.3),
                        blurRadius: 12 + (4 * _pulseAnimation.value),
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(25),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(25),
                      onTap: () {
                        HapticFeedback.mediumImpact();
                        widget.onPressed();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 16,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Cart icon with animation
                            AnimatedBuilder(
                              animation: _bounceAnimation,
                              builder: (context, child) {
                                return Transform.rotate(
                                  angle: _bounceAnimation.value * 0.2,
                                  child: const Icon(
                                    Icons.shopping_cart,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                );
                              },
                            ),
                            const SizedBox(width: 12),
                            
                            // Item count and price
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${widget.itemCount} item${widget.itemCount > 1 ? 's' : ''}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  '\$${widget.totalPrice.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            
                            const SizedBox(width: 12),
                            
                            // Arrow icon
                            const Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                
                // Animated badge
                Positioned(
                  top: -8,
                  right: -8,
                  child: AnimatedBuilder(
                    animation: _badgeAnimation,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: 1.0 + (_badgeAnimation.value * 0.5),
                        child: Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            color: PremiumTheme.accentGold,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                            boxShadow: PremiumTheme.cardShadow,
                          ),
                          child: Center(
                            child: Text(
                              widget.itemCount.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                
                // Pulse effect
                AnimatedBuilder(
                  animation: _pulseAnimation,
                  builder: (context, child) {
                    return Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                            color: PremiumTheme.primaryOrange.withOpacity(
                              0.3 * _pulseAnimation.value,
                            ),
                            width: 2,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class CartItemCounter extends StatefulWidget {
  final int count;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const CartItemCounter({
    super.key,
    required this.count,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  State<CartItemCounter> createState() => _CartItemCounterState();
}

class _CartItemCounterState extends State<CartItemCounter>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = CurvedAnimation(
      parent: _scaleController,
      curve: Curves.elasticOut,
    );
  }

  @override
  void didUpdateWidget(CartItemCounter oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.count != oldWidget.count) {
      _scaleController.forward().then((_) {
        _scaleController.reverse();
      });
    }
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.count == 0) {
      return GestureDetector(
        onTap: () {
          HapticFeedback.lightImpact();
          widget.onIncrement();
        },
        child: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: PremiumTheme.primaryOrange,
            shape: BoxShape.circle,
            boxShadow: PremiumTheme.cardShadow,
          ),
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 20,
          ),
        ),
      );
    }

    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: 1.0 + (_scaleAnimation.value * 0.1),
          child: Container(
            decoration: BoxDecoration(
              color: PremiumTheme.primaryOrange,
              borderRadius: BorderRadius.circular(20),
              boxShadow: PremiumTheme.cardShadow,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () {
                    HapticFeedback.lightImpact();
                    widget.onDecrement();
                  },
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: const BoxDecoration(
                      color: Colors.white24,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.remove,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    widget.count.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    HapticFeedback.lightImpact();
                    widget.onIncrement();
                  },
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: const BoxDecoration(
                      color: Colors.white24,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
