import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../domain/entities/restaurant.dart';
import '../pages/restaurant_menu_page.dart';
import '../../../../core/theme/enhanced_app_theme.dart';
import '../../../../core/utils/responsive_utils.dart';

class RestaurantCard extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantCard({
    super.key,
    required this.restaurant,
  });

  @override
  Widget build(BuildContext context) {
    final cardHeight = ResponsiveUtils.isMobile(context) ? 200.0 : 180.0;
    
    return Card(
      margin: EdgeInsets.zero,
      elevation: ResponsiveUtils.isMobile(context) ? 2 : 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ResponsiveUtils.isMobile(context) ? 12 : 16),
      ),
      child: InkWell(
        onTap: restaurant.isOpen
            ? () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RestaurantMenuPage(restaurant: restaurant),
                  ),
                );
              }
            : null,
        borderRadius: BorderRadius.circular(ResponsiveUtils.isMobile(context) ? 12 : 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(ResponsiveUtils.isMobile(context) ? 12 : 16),
                    topRight: Radius.circular(ResponsiveUtils.isMobile(context) ? 12 : 16),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: restaurant.imageUrl,
                    height: cardHeight,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      height: cardHeight,
                      color: Colors.grey[300],
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      height: cardHeight,
                      color: Colors.grey[300],
                      child: const Icon(
                        Icons.error,
                        color: Colors.grey,
                        size: 50,
                      ),
                    ),
                  ),
                ),
                if (!restaurant.isOpen)
                  Container(
                    height: cardHeight,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(ResponsiveUtils.isMobile(context) ? 12 : 16),
                        topRight: Radius.circular(ResponsiveUtils.isMobile(context) ? 12 : 16),
                      ),
                    ),
                    child: Center(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: ResponsiveUtils.isMobile(context) ? 16 : 20,
                          vertical: ResponsiveUtils.isMobile(context) ? 8 : 10,
                        ),
                        decoration: BoxDecoration(
                          color: EnhancedAppTheme.errorColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'CLOSED',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: ResponsiveUtils.getResponsiveFontSize(context, 12),
                          ),
                        ),
                      ),
                    ),
                  ),
                Positioned(
                  top: ResponsiveUtils.isMobile(context) ? 12 : 16,
                  right: ResponsiveUtils.isMobile(context) ? 12 : 16,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: ResponsiveUtils.isMobile(context) ? 8 : 10,
                      vertical: ResponsiveUtils.isMobile(context) ? 4 : 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: ResponsiveUtils.isMobile(context) ? 14 : 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          restaurant.rating.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: ResponsiveUtils.getResponsiveFontSize(context, 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(ResponsiveUtils.isMobile(context) ? 16 : 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    restaurant.name,
                    style: TextStyle(
                      fontSize: ResponsiveUtils.getResponsiveFontSize(context, 18),
                      fontWeight: FontWeight.w600,
                      color: restaurant.isOpen ? Colors.black87 : Colors.grey,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: ResponsiveUtils.isMobile(context) ? 4 : 6),
                  Text(
                    restaurant.cuisine,
                    style: TextStyle(
                      fontSize: ResponsiveUtils.getResponsiveFontSize(context, 14),
                      color: restaurant.isOpen ? Colors.grey[600] : Colors.grey[400],
                    ),
                  ),
                  SizedBox(height: ResponsiveUtils.isMobile(context) ? 8 : 12),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: ResponsiveUtils.isMobile(context) ? 16 : 18,
                        color: restaurant.isOpen ? EnhancedAppTheme.primaryColor : Colors.grey[400],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${restaurant.deliveryTime} min',
                        style: TextStyle(
                          fontSize: ResponsiveUtils.getResponsiveFontSize(context, 12),
                          color: restaurant.isOpen ? Colors.grey[600] : Colors.grey[400],
                        ),
                      ),
                      const Spacer(),
                      Icon(
                        Icons.delivery_dining,
                        size: ResponsiveUtils.isMobile(context) ? 16 : 18,
                        color: restaurant.isOpen ? EnhancedAppTheme.primaryColor : Colors.grey[400],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '\$${restaurant.deliveryFee.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: ResponsiveUtils.getResponsiveFontSize(context, 12),
                          fontWeight: FontWeight.w600,
                          color: restaurant.isOpen ? EnhancedAppTheme.primaryColor : Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
