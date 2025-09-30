import 'package:equatable/equatable.dart';
import '../../../domain/entities/order.dart';

abstract class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

class OrderInitial extends OrderState {}

class OrderPlacing extends OrderState {}

class OrderPlaced extends OrderState {
  final Order order;

  const OrderPlaced({required this.order});

  @override
  List<Object> get props => [order];
}

class OrderError extends OrderState {
  final String message;

  const OrderError({required this.message});

  @override
  List<Object> get props => [message];
}