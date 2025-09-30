import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/order.dart';
import 'restaurant_list_page.dart';
import '../../../../core/theme/app_theme.dart';

class OrderConfirmationPage extends StatelessWidget {
  final Order order;

  const OrderConfirmationPage({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Confirmed'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Success Icon and Message
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: AppTheme.successColor.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.check_circle,
                        size: 80,
                        color: AppTheme.successColor,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Order Confirmed!',
                      style: Theme.of(context).textTheme.displayMedium?.copyWith(
                            color: AppTheme.successColor,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Your order has been placed successfully',
                      style: Theme.of(context).textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),

                    // Order Details Card
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Order #${order.id}',
                                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: _getStatusColor(order.status).withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: _getStatusColor(order.status).withOpacity(0.3),
                                    ),
                                  ),
                                  child: Text(
                                    _getStatusText(order.status),
                                    style: TextStyle(
                                      color: _getStatusColor(order.status),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            _buildDetailRow(
                              'Restaurant',
                              order.restaurant.name,
                              Icons.restaurant,
                            ),
                            _buildDetailRow(
                              'Order Time',
                              DateFormat('MMM dd, yyyy • hh:mm a').format(order.orderTime),
                              Icons.access_time,
                            ),
                            _buildDetailRow(
                              'Estimated Delivery',
                              '${order.estimatedDeliveryTime} minutes',
                              Icons.delivery_dining,
                            ),
                            _buildDetailRow(
                              'Delivery Address',
                              order.deliveryAddress,
                              Icons.location_on,
                            ),
                            if (order.specialInstructions != null)
                              _buildDetailRow(
                                'Special Instructions',
                                order.specialInstructions!,
                                Icons.note,
                              ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Order Items Card
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Order Items',
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            const SizedBox(height: 16),
                            ...order.items.map((item) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: AppTheme.primaryColor.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Center(
                                        child: Text(
                                          '${item.quantity}',
                                          style: TextStyle(
                                            color: AppTheme.primaryColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item.foodItem.name,
                                            style: Theme.of(context).textTheme.titleMedium,
                                          ),
                                          if (item.specialInstructions != null)
                                            Text(
                                              'Note: ${item.specialInstructions}',
                                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                    fontStyle: FontStyle.italic,
                                                    color: AppTheme.textSecondary,
                                                  ),
                                            ),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      '\$${item.totalPrice.toStringAsFixed(2)}',
                                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                            const Divider(height: 24),
                            _buildCostRow('Subtotal', order.subtotal),
                            _buildCostRow('Delivery Fee', order.deliveryFee),
                            _buildCostRow('Tax', order.tax),
                            const Divider(height: 16),
                            _buildCostRow('Total', order.total, isTotal: true),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Track Order Info
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppTheme.primaryColor.withOpacity(0.3),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: AppTheme.primaryColor,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'You will receive updates about your order via push notifications.',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: AppTheme.primaryColor,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Bottom Buttons
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => const RestaurantListPage(),
                    ),
                    (route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'Order More Food',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 20,
            color: AppTheme.textSecondary,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppTheme.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppTheme.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        ],
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
            style: TextStyle(
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: AppTheme.textPrimary,
            ),
          ),
          Text(
            '\$${amount.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? AppTheme.primaryColor : AppTheme.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return Colors.orange;
      case OrderStatus.confirmed:
        return AppTheme.successColor;
      case OrderStatus.preparing:
        return Colors.blue;
      case OrderStatus.outForDelivery:
        return Colors.purple;
      case OrderStatus.delivered:
        return AppTheme.successColor;
      case OrderStatus.cancelled:
        return AppTheme.errorColor;
    }
  }

  String _getStatusText(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return 'Pending';
      case OrderStatus.confirmed:
        return 'Confirmed';
      case OrderStatus.preparing:
        return 'Preparing';
      case OrderStatus.outForDelivery:
        return 'Out for Delivery';
      case OrderStatus.delivered:
        return 'Delivered';
      case OrderStatus.cancelled:
        return 'Cancelled';
    }
  }
}