import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repositories/order_repository.dart';
import 'order_event.dart';
import 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderRepository repository;

  OrderBloc({required this.repository}) : super(OrderInitial()) {
    on<PlaceOrder>(_onPlaceOrder);
    on<ResetOrderState>(_onResetOrderState);
  }

  Future<void> _onPlaceOrder(
    PlaceOrder event,
    Emitter<OrderState> emit,
  ) async {
    emit(OrderPlacing());
    try {
      final placedOrder = await repository.placeOrder(event.order);
      emit(OrderPlaced(order: placedOrder));
    } catch (e) {
      emit(OrderError(message: e.toString()));
    }
  }

  void _onResetOrderState(
    ResetOrderState event,
    Emitter<OrderState> emit,
  ) {
    emit(OrderInitial());
  }
}