import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lottie/lottie.dart';
import '../bloc/order_tracking_bloc.dart';
import '../../data/services/real_time_tracking_service.dart';

class OrderTrackingPage extends StatefulWidget {
  final String orderId;
  
  const OrderTrackingPage({Key? key, required this.orderId}) : super(key: key);
  
  @override
  State<OrderTrackingPage> createState() => _OrderTrackingPageState();
}

class _OrderTrackingPageState extends State<OrderTrackingPage>
    with TickerProviderStateMixin {
  GoogleMapController? _mapController;
  late AnimationController _pulseController;
  
  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    )..repeat();
  }
  
  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrderTrackingBloc()
        ..add(StartOrderTracking(widget.orderId)),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Track Order'),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: BlocBuilder<OrderTrackingBloc, OrderTrackingState>(
          builder: (context, state) {
            if (state is OrderTrackingLoading) {
              return _buildLoadingView();
            } else if (state is OrderTrackingActive) {
              return _buildTrackingView(state);
            } else if (state is OrderDelivered) {
              return _buildDeliveredView(state);
            } else if (state is OrderTrackingError) {
              return _buildErrorView(state.message);
            }
            return _buildInitialView();
          },
        ),
      ),
    );
  }
  
  Widget _buildLoadingView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/animations/loading.json',
            width: 200,
            height: 200,
          ),
          SizedBox(height: 16),
          Text(
            'Connecting to tracking system...',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
  
  Widget _buildTrackingView(OrderTrackingActive state) {
    return Column(
      children: [
        _buildOrderStatusCard(state.currentStatus),
        if (state.currentStatus.latitude != null && 
            state.currentStatus.longitude != null)
          _buildMapView(state.currentStatus),
        Expanded(
          child: _buildStatusTimeline(state.statusHistory),
        ),
      ],
    );
  }
  
  Widget _buildOrderStatusCard(OrderTrackingData status) {
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.orange.shade400, Colors.deepOrange.shade600],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withOpacity(0.3),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _buildStatusIcon(status.status),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _getStatusTitle(status.status),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      status.message,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (status.estimatedDeliveryTime != null) ...[
            SizedBox(height: 16),
            Row(
              children: [
                Icon(Icons.access_time, color: Colors.white, size: 20),
                SizedBox(width: 8),
                Text(
                  'Estimated delivery: ${status.estimatedDeliveryTime} min',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
          if (status.driverName != null) ...[
            SizedBox(height: 12),
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, color: Colors.orange),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        status.driverName!,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'Your delivery driver',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => _callDriver(status.driverPhone!),
                  icon: Icon(Icons.phone, color: Colors.white),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
  
  Widget _buildStatusIcon(OrderStatus status) {
    Widget icon;
    switch (status) {
      case OrderStatus.placed:
        icon = Icon(Icons.receipt_long, color: Colors.white, size: 24);
        break;
      case OrderStatus.confirmed:
        icon = Icon(Icons.check_circle, color: Colors.white, size: 24);
        break;
      case OrderStatus.preparing:
        icon = Icon(Icons.restaurant, color: Colors.white, size: 24);
        break;
      case OrderStatus.ready:
        icon = Icon(Icons.done_all, color: Colors.white, size: 24);
        break;
      case OrderStatus.pickedUp:
        icon = Icon(Icons.local_shipping, color: Colors.white, size: 24);
        break;
      case OrderStatus.onTheWay:
        icon = AnimatedBuilder(
          animation: _pulseController,
          builder: (context, child) {
            return Transform.scale(
              scale: 1.0 + (_pulseController.value * 0.2),
              child: Icon(Icons.delivery_dining, color: Colors.white, size: 24),
            );
          },
        );
        break;
      case OrderStatus.delivered:
        icon = Icon(Icons.home, color: Colors.white, size: 24);
        break;
      case OrderStatus.cancelled:
        icon = Icon(Icons.cancel, color: Colors.white, size: 24);
        break;
    }
    return icon;
  }
  
  String _getStatusTitle(OrderStatus status) {
    switch (status) {
      case OrderStatus.placed:
        return 'Order Placed';
      case OrderStatus.confirmed:
        return 'Order Confirmed';
      case OrderStatus.preparing:
        return 'Preparing Your Food';
      case OrderStatus.ready:
        return 'Ready for Pickup';
      case OrderStatus.pickedUp:
        return 'Order Picked Up';
      case OrderStatus.onTheWay:
        return 'On the Way';
      case OrderStatus.delivered:
        return 'Delivered';
      case OrderStatus.cancelled:
        return 'Order Cancelled';
    }
  }
  
  Widget _buildMapView(OrderTrackingData status) {
    return Container(
      height: 200,
      margin: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(status.latitude!, status.longitude!),
            zoom: 15,
          ),
          markers: {
            Marker(
              markerId: MarkerId('driver'),
              position: LatLng(status.latitude!, status.longitude!),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueOrange,
              ),
              infoWindow: InfoWindow(
                title: 'Driver Location',
                snippet: status.driverName ?? 'Delivery Driver',
              ),
            ),
          },
          onMapCreated: (controller) {
            _mapController = controller;
          },
        ),
      ),
    );
  }
  
  Widget _buildStatusTimeline(List<OrderTrackingData> history) {
    return Container(
      margin: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Order Timeline',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: history.length,
              itemBuilder: (context, index) {
                final item = history[index];
                final isLast = index == history.length - 1;
                
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            shape: BoxShape.circle,
                          ),
                        ),
                        if (!isLast)
                          Container(
                            width: 2,
                            height: 40,
                            color: Colors.orange.withOpacity(0.3),
                          ),
                      ],
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _getStatusTitle(item.status),
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            item.message,
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            _formatTime(item.timestamp),
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildDeliveredView(OrderDelivered state) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/animations/delivery_success.json',
            width: 200,
            height: 200,
          ),
          SizedBox(height: 24),
          Text(
            'Order Delivered!',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Your order has been successfully delivered',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 32),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Back to Home'),
          ),
        ],
      ),
    );
  }
  
  Widget _buildErrorView(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 64, color: Colors.red),
          SizedBox(height: 16),
          Text(
            'Tracking Error',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          SizedBox(height: 8),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey[600]),
          ),
          SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              context.read<OrderTrackingBloc>()
                  .add(StartOrderTracking(widget.orderId));
            },
            child: Text('Retry'),
          ),
        ],
      ),
    );
  }
  
  Widget _buildInitialView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search, size: 64, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            'No tracking information available',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
  
  String _formatTime(DateTime dateTime) {
    return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }
  
  void _callDriver(String phoneNumber) {
    // In a real app, this would use url_launcher to make a phone call
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Calling $phoneNumber...')),
    );
  }
}
