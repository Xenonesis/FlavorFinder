import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_theme.dart';

class OrderHistoryPage extends StatelessWidget {
  const OrderHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock order data - in real app, this would come from a bloc/repository
    final orders = _getMockOrders();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Order History'),
        elevation: 0,
      ),
      body: orders.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.receipt_long,
                    size: 80,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'No orders yet',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Your order history will appear here',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            )
          : AnimationLimiter(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 375),
                    child: SlideAnimation(
                      verticalOffset: 50.0,
                      child: FadeInAnimation(
                        child: _OrderCard(order: orders[index]),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }

  List<OrderHistoryItem> _getMockOrders() {
    return [
      OrderHistoryItem(
        id: 'ORD001',
        restaurantName: 'Bella Italia',
        restaurantImage: 'https://via.placeholder.com/100x100',
        items: ['Margherita Pizza', 'Caesar Salad', 'Tiramisu'],
        totalAmount: 32.50,
        orderDate: DateTime.now().subtract(const Duration(days: 1)),
        status: OrderStatus.delivered,
      ),
      OrderHistoryItem(
        id: 'ORD002',
        restaurantName: 'Dragon Palace',
        restaurantImage: 'https://via.placeholder.com/100x100',
        items: ['Sweet & Sour Pork', 'Fried Rice', 'Spring Rolls'],
        totalAmount: 28.75,
        orderDate: DateTime.now().subtract(const Duration(days: 3)),
        status: OrderStatus.delivered,
      ),
      OrderHistoryItem(
        id: 'ORD003',
        restaurantName: 'Spice Garden',
        restaurantImage: 'https://via.placeholder.com/100x100',
        items: ['Chicken Tikka Masala', 'Naan Bread', 'Basmati Rice'],
        totalAmount: 24.99,
        orderDate: DateTime.now().subtract(const Duration(days: 7)),
        status: OrderStatus.cancelled,
      ),
    ];
  }
}

class _OrderCard extends StatelessWidget {
  final OrderHistoryItem order;

  const _OrderCard({required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
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
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: () => _showOrderDetails(context, order),
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        order.restaurantImage,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 50,
                            height: 50,
                            color: Colors.grey[200],
                            child: const Icon(Icons.restaurant),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            order.restaurantName,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Order #${order.id}',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                    _buildStatusChip(order.status),
                  ],
                ),
                
                const SizedBox(height: 12),
                
                Text(
                  order.items.join(', '),
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                
                const SizedBox(height: 12),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      DateFormat('MMM dd, yyyy • hh:mm a').format(order.orderDate),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                    Text(
                      '\$${order.totalAmount.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryColor,
                      ),
                    ),
                  ],
                ),
                
                if (order.status == OrderStatus.delivered)
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => _reorderItems(context, order),
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: AppTheme.primaryColor),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'Reorder',
                              style: TextStyle(color: AppTheme.primaryColor),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => _rateOrder(context, order),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'Rate',
                              style: TextStyle(color: Colors.white),
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
      ),
    );
  }

  Widget _buildStatusChip(OrderStatus status) {
    Color color;
    String text;
    
    switch (status) {
      case OrderStatus.delivered:
        color = Colors.green;
        text = 'Delivered';
        break;
      case OrderStatus.cancelled:
        color = Colors.red;
        text = 'Cancelled';
        break;
      case OrderStatus.inProgress:
        color = Colors.orange;
        text = 'In Progress';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  void _showOrderDetails(BuildContext context, OrderHistoryItem order) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _OrderDetailsBottomSheet(order: order),
    );
  }

  void _reorderItems(BuildContext context, OrderHistoryItem order) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Reordering from ${order.restaurantName}...'),
        backgroundColor: AppTheme.primaryColor,
      ),
    );
  }

  void _rateOrder(BuildContext context, OrderHistoryItem order) {
    // Show rating dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Rate ${order.restaurantName}'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('How was your experience?'),
            SizedBox(height: 16),
            // Add rating stars here
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}

class _OrderDetailsBottomSheet extends StatelessWidget {
  final OrderHistoryItem order;

  const _OrderDetailsBottomSheet({required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Order Details',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text('Order ID: ${order.id}'),
            Text('Restaurant: ${order.restaurantName}'),
            Text('Date: ${DateFormat('MMM dd, yyyy • hh:mm a').format(order.orderDate)}'),
            const SizedBox(height: 16),
            const Text(
              'Items:',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            ...order.items.map((item) => Padding(
              padding: const EdgeInsets.only(left: 16, top: 4),
              child: Text('• $item'),
            )),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '\$${order.totalAmount.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class OrderHistoryItem {
  final String id;
  final String restaurantName;
  final String restaurantImage;
  final List<String> items;
  final double totalAmount;
  final DateTime orderDate;
  final OrderStatus status;

  OrderHistoryItem({
    required this.id,
    required this.restaurantName,
    required this.restaurantImage,
    required this.items,
    required this.totalAmount,
    required this.orderDate,
    required this.status,
  });
}

enum OrderStatus {
  delivered,
  cancelled,
  inProgress,
}
