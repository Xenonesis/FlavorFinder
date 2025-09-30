import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:food_delivery_app/features/food_ordering/domain/entities/order.dart';
import 'package:food_delivery_app/features/food_ordering/domain/entities/restaurant.dart';
import 'package:food_delivery_app/features/food_ordering/domain/entities/food_item.dart';
import 'package:food_delivery_app/features/food_ordering/domain/entities/cart_item.dart';
import 'package:food_delivery_app/features/food_ordering/domain/repositories/order_repository.dart';
import 'package:food_delivery_app/features/food_ordering/presentation/bloc/order/order_bloc.dart';
import 'package:food_delivery_app/features/food_ordering/presentation/bloc/order/order_event.dart';
import 'package:food_delivery_app/features/food_ordering/presentation/bloc/order/order_state.dart';

class MockOrderRepository extends Mock implements OrderRepository {}

void main() {
  group('OrderBloc', () {
    late OrderBloc orderBloc;
    late MockOrderRepository mockRepository;

    setUp(() {
      mockRepository = MockOrderRepository();
      orderBloc = OrderBloc(repository: mockRepository);
    });

    tearDown(() {
      orderBloc.close();
    });

    const tRestaurant = Restaurant(
      id: '1',
      name: 'Test Restaurant',
      imageUrl: 'test_image.jpg',
      cuisine: 'Italian',
      rating: 4.5,
      deliveryTime: 30,
      deliveryFee: 2.99,
      minimumOrder: 15.0,
      isOpen: true,
      address: 'Test Address',
      menu: [],
    );

    const tFoodItem = FoodItem(
      id: '1',
      name: 'Test Pizza',
      description: 'Test Description',
      price: 12.99,
      imageUrl: 'test_pizza.jpg',
      category: 'Pizza',
      preparationTime: 20,
    );

    final tOrder = Order(
      id: '1',
      restaurant: tRestaurant,
      items: const [CartItem(foodItem: tFoodItem, quantity: 1)],
      subtotal: 12.99,
      deliveryFee: 2.99,
      tax: 1.04,
      total: 17.02,
      status: OrderStatus.pending,
      orderTime: DateTime.now(),
      deliveryAddress: 'Test Address',
      estimatedDeliveryTime: 30,
    );

    final tPlacedOrder = tOrder.copyWith(status: OrderStatus.confirmed);

    test('initial state is OrderInitial', () {
      expect(orderBloc.state, OrderInitial());
    });

    group('PlaceOrder', () {
      blocTest<OrderBloc, OrderState>(
        'emits [OrderPlacing, OrderPlaced] when order is placed successfully',
        build: () {
          when(() => mockRepository.placeOrder(any()))
              .thenAnswer((_) async => tPlacedOrder);
          return orderBloc;
        },
        act: (bloc) => bloc.add(PlaceOrder(order: tOrder)),
        expect: () => [
          OrderPlacing(),
          OrderPlaced(order: tPlacedOrder),
        ],
      );

      blocTest<OrderBloc, OrderState>(
        'emits [OrderPlacing, OrderError] when placing order fails',
        build: () {
          when(() => mockRepository.placeOrder(any()))
              .thenThrow(Exception('Payment failed'));
          return orderBloc;
        },
        act: (bloc) => bloc.add(PlaceOrder(order: tOrder)),
        expect: () => [
          OrderPlacing(),
          const OrderError(message: 'Exception: Payment failed'),
        ],
      );
    });

    group('ResetOrderState', () {
      blocTest<OrderBloc, OrderState>(
        'resets to OrderInitial',
        build: () => orderBloc,
        seed: () => OrderPlaced(order: tPlacedOrder),
        act: (bloc) => bloc.add(ResetOrderState()),
        expect: () => [
          OrderInitial(),
        ],
      );
    });
  });
}