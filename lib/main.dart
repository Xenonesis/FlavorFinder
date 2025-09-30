import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/theme/app_theme.dart';
import 'features/food_ordering/presentation/pages/restaurant_list_page.dart';
import 'features/food_ordering/presentation/bloc/restaurant/restaurant_bloc.dart';
import 'features/food_ordering/presentation/bloc/restaurant/restaurant_event.dart';
import 'features/food_ordering/presentation/bloc/cart/cart_bloc.dart';
import 'features/food_ordering/presentation/bloc/order/order_bloc.dart';
import 'features/food_ordering/data/repositories/restaurant_repository_impl.dart';
import 'features/food_ordering/data/repositories/order_repository_impl.dart';
import 'features/food_ordering/data/datasources/mock_data_source.dart';

void main() {
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
      ],
      child: MultiBlocProvider(
        providers: [
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
        ],
        child: MaterialApp(
          title: 'Food Delivery',
          theme: AppTheme.lightTheme,
          home: const RestaurantListPage(),
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}