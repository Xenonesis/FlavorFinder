import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/theme/enhanced_app_theme.dart';
import 'core/theme/theme_bloc.dart';
import 'features/food_ordering/presentation/pages/onboarding_page.dart';
import 'features/food_ordering/presentation/pages/enhanced_restaurant_list_page.dart';
import 'features/food_ordering/presentation/bloc/restaurant/restaurant_bloc.dart';
import 'features/food_ordering/presentation/bloc/restaurant/restaurant_event.dart';
import 'features/food_ordering/presentation/bloc/cart/cart_bloc.dart';
import 'features/food_ordering/presentation/bloc/order/order_bloc.dart';
import 'features/food_ordering/presentation/bloc/favorites/favorites_bloc.dart';
import 'features/food_ordering/data/repositories/restaurant_repository_impl.dart';
import 'features/food_ordering/data/repositories/order_repository_impl.dart';
import 'features/food_ordering/data/datasources/mock_data_source.dart';
import 'features/food_ordering/data/services/favorites_service.dart';
import 'features/food_ordering/data/services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize notification service
  final notificationService = NotificationService();
  await notificationService.initialize();
  
  runApp(const FlavorFinderApp());
}

class FlavorFinderApp extends StatelessWidget {
  const FlavorFinderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => RestaurantRepositoryImpl(
            dataSource: MockDataSource(),
          ),
        ),
        RepositoryProvider(
          create: (context) => OrderRepositoryImpl(),
        ),
        RepositoryProvider(
          create: (context) => FavoritesService(),
        ),
        RepositoryProvider(
          create: (context) => NotificationService(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ThemeBloc()..add(LoadTheme()),
          ),
          BlocProvider(
            create: (context) => RestaurantBloc(
              repository: context.read<RestaurantRepositoryImpl>(),
            )..add(LoadRestaurants()),
          ),
          BlocProvider(
            create: (context) => CartBloc(),
          ),
          BlocProvider(
            create: (context) => OrderBloc(
              repository: context.read<OrderRepositoryImpl>(),
            ),
          ),
          BlocProvider(
            create: (context) => FavoritesBloc(
              favoritesService: context.read<FavoritesService>(),
            ),
          ),
        ],
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, themeState) {
            return MaterialApp(
              title: 'FlavorFinder',
              theme: EnhancedAppTheme.lightTheme,
              darkTheme: EnhancedAppTheme.darkTheme,
              themeMode: themeState.isDarkMode ? ThemeMode.dark : ThemeMode.light,
              home: const AppInitializer(),
              debugShowCheckedModeBanner: false,
            );
          },
        ),
      ),
    );
  }
}

class AppInitializer extends StatefulWidget {
  const AppInitializer({super.key});

  @override
  State<AppInitializer> createState() => _AppInitializerState();
}

class _AppInitializerState extends State<AppInitializer> {
  bool _isLoading = true;
  bool _shouldShowOnboarding = false;

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    try {
      // Check if onboarding should be shown
      final shouldShow = await OnboardingHelper.shouldShowOnboarding();
      
      // Initialize notification service and schedule promotional notifications
      final notificationService = context.read<NotificationService>();
      await notificationService.requestPermissions();
      
      // Schedule some demo promotional notifications
      notificationService.schedulePromotionalNotifications();
      
      setState(() {
        _shouldShowOnboarding = shouldShow;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.primary.withOpacity(0.8),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.restaurant_menu,
                  size: 80,
                  color: Colors.white,
                ),
                SizedBox(height: 24),
                Text(
                  'FlavorFinder',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 16),
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return _shouldShowOnboarding
        ? const OnboardingPage()
        : const EnhancedRestaurantListPage();
  }
}
