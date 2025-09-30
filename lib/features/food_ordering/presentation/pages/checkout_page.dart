import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/order.dart';
import '../../domain/entities/restaurant.dart';
import '../bloc/cart/cart_bloc.dart';
import '../bloc/cart/cart_state.dart';
import '../bloc/cart/cart_event.dart';
import '../bloc/order/order_bloc.dart';
import '../bloc/order/order_state.dart';
import '../bloc/order/order_event.dart';
import 'order_confirmation_page.dart';
import '../../../../core/theme/app_theme.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final _formKey = GlobalKey<FormState>();
  final _addressController = TextEditingController(
    text: '123 Main Street, Apartment 4B, New York, NY 10001',
  );
  final _phoneController = TextEditingController(text: '+1 (555) 123-4567');
  final _instructionsController = TextEditingController();

  String selectedPaymentMethod = 'Credit Card';
  final List<String> paymentMethods = [
    'Credit Card',
    'Debit Card',
    'PayPal',
    'Apple Pay',
    'Google Pay',
  ];

  @override
  void dispose() {
    _addressController.dispose();
    _phoneController.dispose();
    _instructionsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: BlocConsumer<OrderBloc, OrderState>(
        listener: (context, state) {
          if (state is OrderPlaced) {
            context.read<CartBloc>().add(ClearCart());
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => OrderConfirmationPage(order: state.order),
              ),
            );
          } else if (state is OrderError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppTheme.errorColor,
              ),
            );
          }
        },
        builder: (context, orderState) {
          return BlocBuilder<CartBloc, CartState>(
            builder: (context, cartState) {
              if (cartState.items.isEmpty) {
                return const Center(
                  child: Text('Your cart is empty'),
                );
              }

              // Calculate costs
              final restaurant = _getRestaurantFromCart(cartState);
              final subtotal = cartState.subtotal;
              final deliveryFee = restaurant?.deliveryFee ?? 3.99;
              final tax = subtotal * 0.08; // 8% tax
              final total = subtotal + deliveryFee + tax;

              return Form(
                key: _formKey,
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Order Summary
                            _buildSectionTitle('Order Summary'),
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  children: [
                                    if (restaurant != null) ...[
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.restaurant,
                                            color: AppTheme.primaryColor,
                                          ),
                                          const SizedBox(width: 8),
                                          Expanded(
                                            child: Text(
                                              restaurant.name,
                                              style: Theme.of(context).textTheme.titleMedium,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Divider(height: 24),
                                    ],
                                    ...cartState.items.map((item) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 4),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                '${item.quantity}x ${item.foodItem.name}',
                                                style: Theme.of(context).textTheme.bodyMedium,
                                              ),
                                            ),
                                            Text(
                                              '\$${item.totalPrice.toStringAsFixed(2)}',
                                              style: Theme.of(context).textTheme.bodyMedium,
                                            ),
                                          ],
                                        ),
                                      );
                                    }).toList(),
                                    const Divider(height: 24),
                                    _buildCostRow('Subtotal', subtotal),
                                    _buildCostRow('Delivery Fee', deliveryFee),
                                    _buildCostRow('Tax', tax),
                                    const Divider(height: 16),
                                    _buildCostRow('Total', total, isTotal: true),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),

                            // Delivery Address
                            _buildSectionTitle('Delivery Address'),
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: TextFormField(
                                  controller: _addressController,
                                  decoration: const InputDecoration(
                                    labelText: 'Address',
                                    hintText: 'Enter your delivery address',
                                    border: OutlineInputBorder(),
                                  ),
                                  maxLines: 3,
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'Please enter a delivery address';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),

                            // Contact Information
                            _buildSectionTitle('Contact Information'),
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: TextFormField(
                                  controller: _phoneController,
                                  decoration: const InputDecoration(
                                    labelText: 'Phone Number',
                                    hintText: 'Enter your phone number',
                                    border: OutlineInputBorder(),
                                  ),
                                  keyboardType: TextInputType.phone,
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'Please enter a phone number';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),

                            // Payment Method
                            _buildSectionTitle('Payment Method'),
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  children: paymentMethods.map((method) {
                                    return RadioListTile<String>(
                                      title: Text(method),
                                      value: method,
                                      groupValue: selectedPaymentMethod,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedPaymentMethod = value!;
                                        });
                                      },
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),

                            // Special Instructions
                            _buildSectionTitle('Special Instructions (Optional)'),
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: TextFormField(
                                  controller: _instructionsController,
                                  decoration: const InputDecoration(
                                    labelText: 'Instructions for delivery',
                                    hintText: 'e.g., Ring doorbell, Leave at door, etc.',
                                    border: OutlineInputBorder(),
                                  ),
                                  maxLines: 3,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Place Order Button
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
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: orderState is OrderPlacing
                              ? null
                              : () => _placeOrder(context, cartState, restaurant, total),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: orderState is OrderPlacing
                              ? const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                      ),
                                    ),
                                    SizedBox(width: 12),
                                    Text('Placing Order...'),
                                  ],
                                )
                              : Text(
                                  'Place Order - \$${total.toStringAsFixed(2)}',
                                  style: const TextStyle(fontSize: 16),
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }

  Widget _buildCostRow(String label, double amount, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: isTotal
                ? Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    )
                : Theme.of(context).textTheme.bodyMedium,
          ),
          Text(
            '\$${amount.toStringAsFixed(2)}',
            style: isTotal
                ? Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryColor,
                    )
                : Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }

  Restaurant? _getRestaurantFromCart(CartState cartState) {
    if (cartState.items.isEmpty) return null;
    // In a real app, you'd store restaurant info with cart items
    // For this demo, we'll return null and handle gracefully
    return null;
  }

  void _placeOrder(BuildContext context, CartState cartState, Restaurant? restaurant, double total) {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Check minimum order requirement (demo)
    if (restaurant != null && cartState.subtotal < restaurant.minimumOrder) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Minimum order is \$${restaurant.minimumOrder.toStringAsFixed(2)}',
          ),
          backgroundColor: AppTheme.errorColor,
        ),
      );
      return;
    }

    final order = Order(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      restaurant: restaurant ?? Restaurant(
        id: 'demo',
        name: 'Demo Restaurant',
        imageUrl: '',
        cuisine: 'Various',
        rating: 4.5,
        deliveryTime: 30,
        deliveryFee: 3.99,
        minimumOrder: 15.0,
        menu: [],
        isOpen: true,
        address: 'Demo Address',
      ),
      items: cartState.items,
      subtotal: cartState.subtotal,
      deliveryFee: 3.99,
      tax: cartState.subtotal * 0.08,
      total: total,
      status: OrderStatus.pending,
      orderTime: DateTime.now(),
      deliveryAddress: _addressController.text.trim(),
      specialInstructions: _instructionsController.text.trim().isEmpty
          ? null
          : _instructionsController.text.trim(),
      estimatedDeliveryTime: 35,
    );

    context.read<OrderBloc>().add(PlaceOrder(order: order));
  }
}