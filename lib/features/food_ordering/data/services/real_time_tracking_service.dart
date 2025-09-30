import 'dart:async';
import 'dart:math';
import 'package:socket_io_client/socket_io_client.dart' as IO;

enum OrderStatus {
  placed,
  confirmed,
  preparing,
  ready,
  pickedUp,
  onTheWay,
  delivered,
  cancelled
}

class OrderTrackingData {
  final String orderId;
  final OrderStatus status;
  final String message;
  final DateTime timestamp;
  final double? latitude;
  final double? longitude;
  final int? estimatedDeliveryTime;
  final String? driverName;
  final String? driverPhone;

  OrderTrackingData({
    required this.orderId,
    required this.status,
    required this.message,
    required this.timestamp,
    this.latitude,
    this.longitude,
    this.estimatedDeliveryTime,
    this.driverName,
    this.driverPhone,
  });

  factory OrderTrackingData.fromJson(Map<String, dynamic> json) {
    return OrderTrackingData(
      orderId: json['orderId'],
      status: OrderStatus.values.firstWhere(
        (e) => e.toString().split('.').last == json['status'],
        orElse: () => OrderStatus.placed,
      ),
      message: json['message'],
      timestamp: DateTime.parse(json['timestamp']),
      latitude: json['latitude']?.toDouble(),
      longitude: json['longitude']?.toDouble(),
      estimatedDeliveryTime: json['estimatedDeliveryTime'],
      driverName: json['driverName'],
      driverPhone: json['driverPhone'],
    );
  }
}

class RealTimeTrackingService {
  static final RealTimeTrackingService _instance = RealTimeTrackingService._internal();
  factory RealTimeTrackingService() => _instance;
  RealTimeTrackingService._internal();

  IO.Socket? _socket;
  final StreamController<OrderTrackingData> _trackingController = 
      StreamController<OrderTrackingData>.broadcast();
  
  Stream<OrderTrackingData> get trackingStream => _trackingController.stream;
  
  Timer? _simulationTimer;
  final Map<String, OrderTrackingData> _orderStatuses = {};

  Future<void> connect() async {
    try {
      _socket = IO.io('ws://localhost:3000', <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': false,
      });

      _socket!.connect();
      
      _socket!.on('connect', (_) {
        print('Connected to tracking server');
      });

      _socket!.on('orderUpdate', (data) {
        final trackingData = OrderTrackingData.fromJson(data);
        _orderStatuses[trackingData.orderId] = trackingData;
        _trackingController.add(trackingData);
      });

      _socket!.on('disconnect', (_) {
        print('Disconnected from tracking server');
      });
    } catch (e) {
      print('Failed to connect to tracking server: $e');
      // Fallback to simulation mode
      _startSimulation();
    }
  }

  void startTracking(String orderId) {
    if (_socket?.connected == true) {
      _socket!.emit('startTracking', {'orderId': orderId});
    } else {
      _simulateOrderTracking(orderId);
    }
  }

  void stopTracking(String orderId) {
    if (_socket?.connected == true) {
      _socket!.emit('stopTracking', {'orderId': orderId});
    }
    _simulationTimer?.cancel();
  }

  OrderTrackingData? getCurrentStatus(String orderId) {
    return _orderStatuses[orderId];
  }

  void _startSimulation() {
    // Simulation mode for demo purposes
    print('Starting simulation mode for order tracking');
  }

  void _simulateOrderTracking(String orderId) {
    final statuses = [
      OrderStatus.placed,
      OrderStatus.confirmed,
      OrderStatus.preparing,
      OrderStatus.ready,
      OrderStatus.pickedUp,
      OrderStatus.onTheWay,
      OrderStatus.delivered,
    ];

    int currentStatusIndex = 0;
    
    _simulationTimer = Timer.periodic(Duration(seconds: 30), (timer) {
      if (currentStatusIndex >= statuses.length) {
        timer.cancel();
        return;
      }

      final status = statuses[currentStatusIndex];
      final trackingData = _createSimulatedTrackingData(orderId, status);
      
      _orderStatuses[orderId] = trackingData;
      _trackingController.add(trackingData);
      
      currentStatusIndex++;
    });

    // Send initial status immediately
    final initialData = _createSimulatedTrackingData(orderId, OrderStatus.placed);
    _orderStatuses[orderId] = initialData;
    _trackingController.add(initialData);
  }

  OrderTrackingData _createSimulatedTrackingData(String orderId, OrderStatus status) {
    final messages = {
      OrderStatus.placed: 'Order placed successfully',
      OrderStatus.confirmed: 'Restaurant confirmed your order',
      OrderStatus.preparing: 'Your food is being prepared',
      OrderStatus.ready: 'Order is ready for pickup',
      OrderStatus.pickedUp: 'Driver has picked up your order',
      OrderStatus.onTheWay: 'Driver is on the way to your location',
      OrderStatus.delivered: 'Order delivered successfully',
    };

    final estimatedTimes = {
      OrderStatus.placed: 45,
      OrderStatus.confirmed: 40,
      OrderStatus.preparing: 35,
      OrderStatus.ready: 20,
      OrderStatus.pickedUp: 15,
      OrderStatus.onTheWay: 10,
      OrderStatus.delivered: 0,
    };

    // Simulate driver location for on-the-way status
    double? lat, lng;
    if (status == OrderStatus.onTheWay || status == OrderStatus.pickedUp) {
      lat = 37.7749 + (Random().nextDouble() - 0.5) * 0.01;
      lng = -122.4194 + (Random().nextDouble() - 0.5) * 0.01;
    }

    return OrderTrackingData(
      orderId: orderId,
      status: status,
      message: messages[status]!,
      timestamp: DateTime.now(),
      latitude: lat,
      longitude: lng,
      estimatedDeliveryTime: estimatedTimes[status],
      driverName: status.index >= OrderStatus.pickedUp.index ? 'John Doe' : null,
      driverPhone: status.index >= OrderStatus.pickedUp.index ? '+1234567890' : null,
    );
  }

  List<OrderTrackingData> getOrderHistory(String orderId) {
    // In a real app, this would fetch from a database
    return _orderStatuses.values
        .where((data) => data.orderId == orderId)
        .toList()
      ..sort((a, b) => a.timestamp.compareTo(b.timestamp));
  }

  void disconnect() {
    _socket?.disconnect();
    _simulationTimer?.cancel();
  }

  void dispose() {
    disconnect();
    _trackingController.close();
  }
}
