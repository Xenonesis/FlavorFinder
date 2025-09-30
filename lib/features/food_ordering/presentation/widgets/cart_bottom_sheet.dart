import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/cart/cart_bloc.dart';
import '../bloc/cart/cart_state.dart';
import '../bloc/cart/cart_event.dart';
import '../pages/checkout_page.dart';
import '../../../../core/theme/app_theme.dart';

class CartBottomSheet extends StatelessWidget {
  const CartBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.3,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) {
          return BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              if (state.items.isEmpty) {
                return Container(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Container(
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Icon(
                        Icons.shopping_cart_outlined,
                        size: 64,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Your cart is empty',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Add items to get started',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                );
              }

              return Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Container(
                          width: 40,
                          height: 4,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Your Order',
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                            TextButton(
                              onPressed: () {
                                context.read<CartBloc>().add(ClearCart());
                              },
                              child: Text(
                                'Clear All',
                                style: TextStyle(
                                  color: AppTheme.errorColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      controller: scrollController,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: state.items.length,
                      itemBuilder: (context, index) {
                        final item = state.items[index];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 8),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        item.foodItem.name,
                                        style: Theme.of(context).textTheme.titleMedium,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        context.read<CartBloc>().add(
                                              RemoveFromCart(
                                                foodItemId: item.foodItem.id,
                                              ),
                                            );
                                      },
                                      icon: Icon(
                                        Icons.delete_outline,
                                        color: AppTheme.errorColor,
                                      ),
                                    ),
                                  ],
                                ),
                                if (item.specialInstructions != null) ...[
                                  const SizedBox(height: 4),
                                  Text(
                                    'Note: ${item.specialInstructions}',
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                          fontStyle: FontStyle.italic,
                                          color: AppTheme.textSecondary,
                                        ),
                                  ),
                                ],
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            context.read<CartBloc>().add(
                                                  UpdateCartItemQuantity(
                                                    foodItemId: item.foodItem.id,
                                                    quantity: item.quantity - 1,
                                                  ),
                                                );
                                          },
                                          icon: const Icon(Icons.remove_circle_outline),
                                        ),
                                        Container(
                                          width: 30,
                                          child: Text(
                                            item.quantity.toString(),
                                            style: Theme.of(context).textTheme.titleMedium,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            context.read<CartBloc>().add(
                                                  UpdateCartItemQuantity(
                                                    foodItemId: item.foodItem.id,
                                                    quantity: item.quantity + 1,
                                                  ),
                                                );
                                          },
                                          icon: const Icon(Icons.add_circle_outline),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      '\$${item.totalPrice.toStringAsFixed(2)}',
                                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                            color: AppTheme.primaryColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, -5),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Subtotal',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            Text(
                              '\$${state.subtotal.toStringAsFixed(2)}',
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const CheckoutPage(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                            child: Text(
                              'Proceed to Checkout (${state.totalItems} items)',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}