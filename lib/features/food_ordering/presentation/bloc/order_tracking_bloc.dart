import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/services/real_time_tracking_service.dart';

// Events
abstract class OrderTrackingEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class StartOrderTracking extends OrderTrackingEvent {
  final String orderId;
  
  StartOrderTracking(this.orderId);
  
  @override
  List<Object?> get props => [orderId];
}

class StopOrderTracking extends OrderTrackingEvent {
  final String orderId;
  
  StopOrderTracking(this.orderId);
  
  @override
  List<Object?> get props => [orderId];
}

class OrderStatusUpdated extends OrderTrackingEvent {
  final OrderTrackingData trackingData;
  
  OrderStatusUpdated(this.trackingData);
  
  @override
  List<Object?> get props => [trackingData];
}

class LoadOrderHistory extends OrderTrackingEvent {
  final String orderId;
  
  LoadOrderHistory(this.orderId);
  
  @override
  List<Object?> get props => [orderId];
}

// States
abstract class OrderTrackingState extends Equatable {
  @override
  List<Object?> get props => [];
}

class OrderTrackingInitial extends OrderTrackingState {}

class OrderTrackingLoading extends OrderTrackingState {}

class OrderTrackingActive extends OrderTrackingState {
  final OrderTrackingData currentStatus;
  final List<OrderTrackingData> statusHistory;
  
  OrderTrackingActive({
    required this.currentStatus,
    required this.statusHistory,
  });
  
  @override
  List<Object?> get props => [currentStatus, statusHistory];
}

class OrderTrackingError extends OrderTrackingState {
  final String message;
  
  OrderTrackingError(this.message);
  
  @override
  List<Object?> get props => [message];
}

class OrderDelivered extends OrderTrackingState {
  final OrderTrackingData finalStatus;
  final List<OrderTrackingData> completeHistory;
  
  OrderDelivered({
    required this.finalStatus,
    required this.completeHistory,
  });
  
  @override
  List<Object?> get props => [finalStatus, completeHistory];
}

// BLoC
class OrderTrackingBloc extends Bloc<OrderTrackingEvent, OrderTrackingState> {
  final RealTimeTrackingService _trackingService;
  StreamSubscription<OrderTrackingData>? _trackingSubscription;
  String? _currentOrderId;
  final List<OrderTrackingData> _statusHistory = [];
  
  OrderTrackingBloc({RealTimeTrackingService? trackingService})
      : _trackingService = trackingService ?? RealTimeTrackingService(),
        super(OrderTrackingInitial()) {
    
    on<StartOrderTracking>(_onStartOrderTracking);
    on<StopOrderTracking>(_onStopOrderTracking);
    on<OrderStatusUpdated>(_onOrderStatusUpdated);
    on<LoadOrderHistory>(_onLoadOrderHistory);
    
    _initializeTrackingService();
  }
  
  Future<void> _initializeTrackingService() async {
    await _trackingService.connect();
  }
  
  Future<void> _onStartOrderTracking(
    StartOrderTracking event,
    Emitter<OrderTrackingState> emit,
  ) async {
    try {
      emit(OrderTrackingLoading());
      
      _currentOrderId = event.orderId;
      _statusHistory.clear();
      
      // Subscribe to tracking updates
      _trackingSubscription?.cancel();
      _trackingSubscription = _trackingService.trackingStream
          .where((data) => data.orderId == event.orderId)
          .listen((data) {
        add(OrderStatusUpdated(data));
      });
      
      // Start tracking
      _trackingService.startTracking(event.orderId);
      
      // Check if there's already a current status
      final currentStatus = _trackingService.getCurrentStatus(event.orderId);
      if (currentStatus != null) {
        _statusHistory.add(currentStatus);
        emit(OrderTrackingActive(
          currentStatus: currentStatus,
          statusHistory: List.from(_statusHistory),
        ));
      }
    } catch (e) {
      emit(OrderTrackingError('Failed to start tracking: $e'));
    }
  }
  
  Future<void> _onStopOrderTracking(
    StopOrderTracking event,
    Emitter<OrderTrackingState> emit,
  ) async {
    try {
      _trackingService.stopTracking(event.orderId);
      _trackingSubscription?.cancel();
      _currentOrderId = null;
      emit(OrderTrackingInitial());
    } catch (e) {
      emit(OrderTrackingError('Failed to stop tracking: $e'));
    }
  }
  
  Future<void> _onOrderStatusUpdated(
    OrderStatusUpdated event,
    Emitter<OrderTrackingState> emit,
  ) async {
    try {
      final trackingData = event.trackingData;
      
      // Add to history if not already present
      if (!_statusHistory.any((data) => 
          data.status == trackingData.status && 
          data.orderId == trackingData.orderId)) {
        _statusHistory.add(trackingData);
      }
      
      // Check if order is delivered
      if (trackingData.status == OrderStatus.delivered) {
        emit(OrderDelivered(
          finalStatus: trackingData,
          completeHistory: List.from(_statusHistory),
        ));
      } else {
        emit(OrderTrackingActive(
          currentStatus: trackingData,
          statusHistory: List.from(_statusHistory),
        ));
      }
    } catch (e) {
      emit(OrderTrackingError('Failed to update order status: $e'));
    }
  }
  
  Future<void> _onLoadOrderHistory(
    LoadOrderHistory event,
    Emitter<OrderTrackingState> emit,
  ) async {
    try {
      emit(OrderTrackingLoading());
      
      final history = _trackingService.getOrderHistory(event.orderId);
      
      if (history.isNotEmpty) {
        final currentStatus = history.last;
        
        if (currentStatus.status == OrderStatus.delivered) {
          emit(OrderDelivered(
            finalStatus: currentStatus,
            completeHistory: history,
          ));
        } else {
          emit(OrderTrackingActive(
            currentStatus: currentStatus,
            statusHistory: history,
          ));
        }
      } else {
        emit(OrderTrackingInitial());
      }
    } catch (e) {
      emit(OrderTrackingError('Failed to load order history: $e'));
    }
  }
  
  @override
  Future<void> close() {
    _trackingSubscription?.cancel();
    return super.close();
  }
}
