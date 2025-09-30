import '../entities/order.dart';

abstract class OrderRepository {
  Future<Order> placeOrder(Order order);
  Future<Order> trackOrder(String orderId);
}