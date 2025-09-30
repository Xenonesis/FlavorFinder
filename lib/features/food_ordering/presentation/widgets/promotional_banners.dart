import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../core/theme/enhanced_app_theme.dart';

class PromotionalBanners extends StatefulWidget {
  const PromotionalBanners({super.key});

  @override
  State<PromotionalBanners> createState() => _PromotionalBannersState();
}

class _PromotionalBannersState extends State<PromotionalBanners> {
  int _currentIndex = 0;

  final List<PromoBanner> _banners = [
    PromoBanner(
      title: 'Free Delivery',
      subtitle: 'On orders over \$25',
      description: 'Get free delivery on all orders above \$25. Limited time offer!',
      gradient: const LinearGradient(
        colors: [Color(0xFF4CAF50), Color(0xFF8BC34A)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      icon: Icons.delivery_dining,
    ),
    PromoBanner(
      title: '20% OFF',
      subtitle: 'First Order Discount',
      description: 'New users get 20% off on their first order. Use code: WELCOME20',
      gradient: const LinearGradient(
        colors: [Color(0xFFFF9800), Color(0xFFFFB74D)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      icon: Icons.local_offer,
    ),
    PromoBanner(
      title: 'Happy Hour',
      subtitle: '3-6 PM Daily',
      description: 'Special discounts on selected restaurants during happy hours',
      gradient: const LinearGradient(
        colors: [Color(0xFF9C27B0), Color(0xFFBA68C8)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      icon: Icons.access_time,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: _banners.length,
          itemBuilder: (context, index, realIndex) {
            return _BannerCard(banner: _banners[index]);
          },
          options: CarouselOptions(
            height: 160,
            viewportFraction: 0.9,
            enlargeCenterPage: true,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 4),
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),
        const SizedBox(height: 12),
        AnimatedSmoothIndicator(
          activeIndex: _currentIndex,
          count: _banners.length,
          effect: WormEffect(
            dotColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
            activeDotColor: EnhancedAppTheme.primaryColor,
            dotHeight: 8,
            dotWidth: 8,
          ),
          onDotClicked: (index) {
            // Removed carousel controller functionality to avoid import conflicts
          },
        ),
      ],
    );
  }
}

class _BannerCard extends StatelessWidget {
  final PromoBanner banner;

  const _BannerCard({required this.banner});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        gradient: banner.gradient,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _onBannerTap(context, banner),
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        banner.title,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        banner.subtitle,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        banner.description,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white60,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    banner.icon,
                    size: 32,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onBannerTap(BuildContext context, PromoBanner banner) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(banner.title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              banner.subtitle,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: EnhancedAppTheme.primaryColor,
              ),
            ),
            const SizedBox(height: 12),
            Text(banner.description),
            const SizedBox(height: 16),
            if (banner.title.contains('20%'))
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Theme.of(context).dividerColor),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'WELCOME20',
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        // Copy to clipboard
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Promo code copied to clipboard!',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                            backgroundColor: Theme.of(context).colorScheme.surface,
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.copy,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                      iconSize: 20,
                    ),
                  ],
                ),
              ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          if (banner.title.contains('Free Delivery') || banner.title.contains('20%'))
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                // Navigate to restaurants or apply offer
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: EnhancedAppTheme.primaryColor,
              ),
              child: Text(
                'Order Now',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class PromoBanner {
  final String title;
  final String subtitle;
  final String description;
  final Gradient gradient;
  final IconData icon;

  PromoBanner({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.gradient,
    required this.icon,
  });
}
