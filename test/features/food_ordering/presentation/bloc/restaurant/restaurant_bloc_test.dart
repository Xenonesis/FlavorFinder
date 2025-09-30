import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:food_delivery_app/features/food_ordering/domain/entities/restaurant.dart';
import 'package:food_delivery_app/features/food_ordering/domain/entities/food_item.dart';
import 'package:food_delivery_app/features/food_ordering/domain/repositories/restaurant_repository.dart';
import 'package:food_delivery_app/features/food_ordering/presentation/bloc/restaurant/restaurant_bloc.dart';
import 'package:food_delivery_app/features/food_ordering/presentation/bloc/restaurant/restaurant_event.dart';
import 'package:food_delivery_app/features/food_ordering/presentation/bloc/restaurant/restaurant_state.dart';

class MockRestaurantRepository extends Mock implements RestaurantRepository {}

void main() {
  group('RestaurantBloc', () {
    late RestaurantBloc restaurantBloc;
    late MockRestaurantRepository mockRepository;

    setUp(() {
      mockRepository = MockRestaurantRepository();
      restaurantBloc = RestaurantBloc(repository: mockRepository);
    });

    tearDown(() {
      restaurantBloc.close();
    });

    const tRestaurants = [
      Restaurant(
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
        menu: [
          FoodItem(
            id: '1',
            name: 'Test Pizza',
            description: 'Test Description',
            price: 12.99,
            imageUrl: 'test_pizza.jpg',
            category: 'Pizza',
            preparationTime: 20,
          ),
        ],
      ),
    ];

    test('initial state is RestaurantInitial', () {
      expect(restaurantBloc.state, RestaurantInitial());
    });

    group('LoadRestaurants', () {
      blocTest<RestaurantBloc, RestaurantState>(
        'emits [RestaurantLoading, RestaurantLoaded] when restaurants are loaded successfully',
        build: () {
          when(() => mockRepository.getRestaurants())
              .thenAnswer((_) async => tRestaurants);
          return restaurantBloc;
        },
        act: (bloc) => bloc.add(LoadRestaurants()),
        expect: () => [
          RestaurantLoading(),
          const RestaurantLoaded(restaurants: tRestaurants),
        ],
      );

      blocTest<RestaurantBloc, RestaurantState>(
        'emits [RestaurantLoading, RestaurantError] when loading restaurants fails',
        build: () {
          when(() => mockRepository.getRestaurants())
              .thenThrow(Exception('Failed to load restaurants'));
          return restaurantBloc;
        },
        act: (bloc) => bloc.add(LoadRestaurants()),
        expect: () => [
          RestaurantLoading(),
          const RestaurantError(message: 'Exception: Failed to load restaurants'),
        ],
      );
    });

    group('RefreshRestaurants', () {
      blocTest<RestaurantBloc, RestaurantState>(
        'emits [RestaurantLoaded] when restaurants are refreshed successfully',
        build: () {
          when(() => mockRepository.getRestaurants())
              .thenAnswer((_) async => tRestaurants);
          return restaurantBloc;
        },
        act: (bloc) => bloc.add(RefreshRestaurants()),
        expect: () => [
          const RestaurantLoaded(restaurants: tRestaurants),
        ],
      );

      blocTest<RestaurantBloc, RestaurantState>(
        'emits [RestaurantError] when refreshing restaurants fails',
        build: () {
          when(() => mockRepository.getRestaurants())
              .thenThrow(Exception('Network error'));
          return restaurantBloc;
        },
        act: (bloc) => bloc.add(RefreshRestaurants()),
        expect: () => [
          const RestaurantError(message: 'Exception: Network error'),
        ],
      );
    });
  });
}