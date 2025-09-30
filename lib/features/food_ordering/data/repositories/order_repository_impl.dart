import '../../domain/entities/order.dart';
import '../../domain/repositories/order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  @override
  Future<Order> placeOrder(Order order) async {
    // Simulate network delay and order processing
    await Future.delayed(const Duration(seconds: 2));
    
    // Simulate random order confirmation (95% success rate)
    if (DateTime.now().millisecond % 20 == 0) {
      throw Exception('Payment failed. Please try again.');
    }
    
    return order.copyWith(
      status: OrderStatus.confirmed,
      orderTime: DateTime.now(),
    );
  }

  @override
  Future<Order> trackOrder(String orderId) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    // This would normally fetch order from backend
    throw UnimplementedError('Order tracking not implemented in this demo');
  }
}