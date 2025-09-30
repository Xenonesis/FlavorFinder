import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/restaurant/restaurant_bloc.dart';
import '../bloc/restaurant/restaurant_state.dart';
import '../bloc/restaurant/restaurant_event.dart';
import '../bloc/cart/cart_bloc.dart';
import '../bloc/cart/cart_state.dart';
import '../widgets/restaurant_card.dart';
import '../widgets/cart_bottom_sheet.dart';
import '../../../../core/theme/app_theme.dart';

class RestaurantListPage extends StatelessWidget {
  const RestaurantListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food Delivery'),
        actions: [
          BlocBuilder<CartBloc, CartState>(
            builder: (context, cartState) {
              return Stack(
                children: [
                  IconButton(
                    icon: const Icon(Icons.shopping_cart),
                    onPressed: cartState.items.isNotEmpty
                        ? () => _showCartBottomSheet(context)
                        : null,
                  ),
                  if (cartState.totalItems > 0)
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        child: Text(
                          '${cartState.totalItems}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<RestaurantBloc, RestaurantState>(
        builder: (context, state) {
          if (state is RestaurantLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is RestaurantError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: AppTheme.errorColor,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Oops! Something went wrong',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    state.message,
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<RestaurantBloc>().add(RefreshRestaurants());
                    },
                    child: const Text('Try Again'),
                  ),
                ],
              ),
            );
          } else if (state is RestaurantLoaded) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<RestaurantBloc>().add(RefreshRestaurants());
              },
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: state.restaurants.length,
                itemBuilder: (context, index) {
                  final restaurant = state.restaurants[index];
                  return RestaurantCard(restaurant: restaurant);
                },
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  void _showCartBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const CartBottomSheet(),
    );
  }
}