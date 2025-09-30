import 'package:equatable/equatable.dart';
import '../../../domain/entities/order.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class PlaceOrder extends OrderEvent {
  final Order order;

  const PlaceOrder({required this.order});

  @override
  List<Object> get props => [order];
}

class ResetOrderState extends OrderEvent {}