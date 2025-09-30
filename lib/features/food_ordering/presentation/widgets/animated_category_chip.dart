import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AnimatedCategoryChip extends StatefulWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const AnimatedCategoryChip({
    Key? key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  State<AnimatedCategoryChip> createState() => _AnimatedCategoryChipState();
}

class _AnimatedCategoryChipState extends State<AnimatedCategoryChip>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _colorController;
  late Animation<double> _scaleAnimation;
  late Animation<Color?> _backgroundColorAnimation;
  late Animation<Color?> _textColorAnimation;

  @override
  void initState() {
    super.initState();
    
    _scaleController = AnimationController(
      duration: Duration(milliseconds: 150),
      vsync: this,
    );
    
    _colorController = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeInOut),
    );

    _backgroundColorAnimation = ColorTween(
      begin: Colors.grey[100],
      end: Colors.orange,
    ).animate(CurvedAnimation(
      parent: _colorController,
      curve: Curves.easeInOut,
    ));

    _textColorAnimation = ColorTween(
      begin: Colors.grey[700],
      end: Colors.white,
    ).animate(CurvedAnimation(
      parent: _colorController,
      curve: Curves.easeInOut,
    ));

    // Set initial state
    if (widget.isSelected) {
      _colorController.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(AnimatedCategoryChip oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    if (widget.isSelected != oldWidget.isSelected) {
      if (widget.isSelected) {
        _colorController.forward();
      } else {
        _colorController.reverse();
      }
    }
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _colorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([_scaleAnimation, _colorController]),
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Container(
            margin: EdgeInsets.only(right: 12),
            child: Material(
              color: Colors.transparent,
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
                borderRadius: BorderRadius.circular(25),
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  decoration: BoxDecoration(
                    color: _backgroundColorAnimation.value,
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color: widget.isSelected 
                          ? Colors.orange 
                          : Colors.grey[300]!,
                      width: 1,
                    ),
                    boxShadow: widget.isSelected
                        ? [
                            BoxShadow(
                              color: Colors.orange.withOpacity(0.3),
                              blurRadius: 8,
                              offset: Offset(0, 4),
                            ),
                          ]
                        : [],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (widget.isSelected) ...[
                        Icon(
                          _getCategoryIcon(widget.label),
                          size: 16,
                          color: Colors.white,
                        ),
                        SizedBox(width: 6),
                      ],
                      Text(
                        widget.label,
                        style: TextStyle(
                          color: _textColorAnimation.value,
                          fontSize: 14,
                          fontWeight: widget.isSelected 
                              ? FontWeight.w600 
                              : FontWeight.w500,
                        ),
                      ),
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

  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'all':
        return Icons.restaurant_menu;
      case 'pizza':
        return Icons.local_pizza;
      case 'burgers':
        return Icons.lunch_dining;
      case 'sushi':
        return Icons.set_meal;
      case 'indian':
        return Icons.curry;
      case 'chinese':
        return Icons.ramen_dining;
      case 'italian':
        return Icons.local_dining;
      case 'mexican':
        return Icons.local_fire_department;
      default:
        return Icons.fastfood;
    }
  }
}
