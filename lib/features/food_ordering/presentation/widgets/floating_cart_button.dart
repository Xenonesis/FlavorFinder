import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FloatingCartButton extends StatefulWidget {
  final int itemCount;
  final VoidCallback onPressed;

  const FloatingCartButton({
    Key? key,
    required this.itemCount,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<FloatingCartButton> createState() => _FloatingCartButtonState();
}

class _FloatingCartButtonState extends State<FloatingCartButton>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _badgeController;
  late AnimationController _pulseController;
  
  late Animation<double> _scaleAnimation;
  late Animation<double> _badgeScaleAnimation;
  late Animation<double> _pulseAnimation;

  int _previousItemCount = 0;

  @override
  void initState() {
    super.initState();
    
    _scaleController = AnimationController(
      duration: Duration(milliseconds: 150),
      vsync: this,
    );
    
    _badgeController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
    
    _pulseController = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.9).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeInOut),
    );

    _badgeScaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _badgeController, curve: Curves.elasticOut),
    );

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _previousItemCount = widget.itemCount;
    
    if (widget.itemCount > 0) {
      _badgeController.forward();
    }
  }

  @override
  void didUpdateWidget(FloatingCartButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    if (widget.itemCount != oldWidget.itemCount) {
      if (widget.itemCount > _previousItemCount) {
        // Item added - animate badge and pulse
        _badgeController.forward();
        _pulseController.forward().then((_) {
          _pulseController.reverse();
        });
        HapticFeedback.lightImpact();
      } else if (widget.itemCount == 0) {
        // All items removed - hide badge
        _badgeController.reverse();
      }
      _previousItemCount = widget.itemCount;
    }
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _badgeController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([_scaleAnimation, _pulseAnimation]),
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value * _pulseAnimation.value,
          child: Stack(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.orange.shade400,
                      Colors.deepOrange.shade600,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.orange.withOpacity(0.4),
                      blurRadius: 15,
                      offset: Offset(0, 8),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      _scaleController.forward().then((_) {
                        _scaleController.reverse();
                        widget.onPressed();
                      });
                      HapticFeedback.mediumImpact();
                    },
                    onTapDown: (_) => _scaleController.forward(),
                    onTapUp: (_) => _scaleController.reverse(),
                    onTapCancel: () => _scaleController.reverse(),
                    borderRadius: BorderRadius.circular(30),
                    child: Center(
                      child: Icon(
                        Icons.shopping_cart,
                        color: Theme.of(context).colorScheme.onPrimary,
                        size: 28,
                      ),
                    ),
                  ),
                ),
              ),
              if (widget.itemCount > 0)
                Positioned(
                  right: 0,
                  top: 0,
                  child: AnimatedBuilder(
                    animation: _badgeScaleAnimation,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _badgeScaleAnimation.value,
                        child: Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Theme.of(context).colorScheme.surface,
                              width: 2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.red.withOpacity(0.3),
                                blurRadius: 6,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              widget.itemCount > 99 ? '99+' : widget.itemCount.toString(),
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onError,
                                fontSize: widget.itemCount > 99 ? 8 : 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
