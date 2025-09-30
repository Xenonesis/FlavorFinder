import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:food_delivery_app/features/food_ordering/domain/entities/food_item.dart';
import 'package:food_delivery_app/features/food_ordering/domain/entities/cart_item.dart';
import 'package:food_delivery_app/features/food_ordering/presentation/bloc/cart/cart_bloc.dart';
import 'package:food_delivery_app/features/food_ordering/presentation/bloc/cart/cart_event.dart';
import 'package:food_delivery_app/features/food_ordering/presentation/bloc/cart/cart_state.dart';

void main() {
  group('CartBloc', () {
    late CartBloc cartBloc;

    setUp(() {
      cartBloc = CartBloc();
    });

    tearDown(() {
      cartBloc.close();
    });

    const tFoodItem = FoodItem(
      id: '1',
      name: 'Test Pizza',
      description: 'Test Description',
      price: 12.99,
      imageUrl: 'test_pizza.jpg',
      category: 'Pizza',
      preparationTime: 20,
    );

    const tFoodItem2 = FoodItem(
      id: '2',
      name: 'Test Burger',
      description: 'Test Burger Description',
      price: 8.99,
      imageUrl: 'test_burger.jpg',
      category: 'Burgers',
      preparationTime: 15,
    );

    test('initial state is empty cart', () {
      expect(cartBloc.state, const CartState());
    });

    group('AddToCart', () {
      blocTest<CartBloc, CartState>(
        'adds new item to empty cart',
        build: () => cartBloc,
        act: (bloc) => bloc.add(const AddToCart(foodItem: tFoodItem, quantity: 2)),
        expect: () => [
          CartState(
            items: const [
              CartItem(foodItem: tFoodItem, quantity: 2),
            ],
            subtotal: 25.98,
            totalItems: 2,
          ),
        ],
      );

      blocTest<CartBloc, CartState>(
        'increases quantity when adding existing item',
        build: () => cartBloc,
        seed: () => const CartState(
          items: [CartItem(foodItem: tFoodItem, quantity: 1)],
          subtotal: 12.99,
          totalItems: 1,
        ),
        act: (bloc) => bloc.add(const AddToCart(foodItem: tFoodItem, quantity: 1)),
        expect: () => [
          CartState(
            items: const [
              CartItem(foodItem: tFoodItem, quantity: 2),
            ],
            subtotal: 25.98,
            totalItems: 2,
          ),
        ],
      );

      blocTest<CartBloc, CartState>(
        'adds multiple different items',
        build: () => cartBloc,
        act: (bloc) {
          bloc.add(const AddToCart(foodItem: tFoodItem, quantity: 1));
          bloc.add(const AddToCart(foodItem: tFoodItem2, quantity: 2));
        },
        expect: () => [
          CartState(
            items: const [
              CartItem(foodItem: tFoodItem, quantity: 1),
            ],
            subtotal: 12.99,
            totalItems: 1,
          ),
          CartState(
            items: const [
              CartItem(foodItem: tFoodItem, quantity: 1),
              CartItem(foodItem: tFoodItem2, quantity: 2),
            ],
            subtotal: 30.97,
            totalItems: 3,
          ),
        ],
      );
    });

    group('RemoveFromCart', () {
      blocTest<CartBloc, CartState>(
        'removes item from cart',
        build: () => cartBloc,
        seed: () => const CartState(
          items: [
            CartItem(foodItem: tFoodItem, quantity: 1),
            CartItem(foodItem: tFoodItem2, quantity: 2),
          ],
          subtotal: 30.97,
          totalItems: 3,
        ),
        act: (bloc) => bloc.add(const RemoveFromCart(foodItemId: '1')),
        expect: () => [
          CartState(
            items: const [
              CartItem(foodItem: tFoodItem2, quantity: 2),
            ],
            subtotal: 17.98,
            totalItems: 2,
          ),
        ],
      );
    });

    group('UpdateCartItemQuantity', () {
      blocTest<CartBloc, CartState>(
        'updates item quantity',
        build: () => cartBloc,
        seed: () => const CartState(
          items: [CartItem(foodItem: tFoodItem, quantity: 1)],
          subtotal: 12.99,
          totalItems: 1,
        ),
        act: (bloc) => bloc.add(const UpdateCartItemQuantity(foodItemId: '1', quantity: 3)),
        expect: () => [
          CartState(
            items: const [
              CartItem(foodItem: tFoodItem, quantity: 3),
            ],
            subtotal: 38.97,
            totalItems: 3,
          ),
        ],
      );

      blocTest<CartBloc, CartState>(
        'removes item when quantity is set to 0',
        build: () => cartBloc,
        seed: () => const CartState(
          items: [CartItem(foodItem: tFoodItem, quantity: 2)],
          subtotal: 25.98,
          totalItems: 2,
        ),
        act: (bloc) => bloc.add(const UpdateCartItemQuantity(foodItemId: '1', quantity: 0)),
        expect: () => [
          const CartState(),
        ],
      );
    });

    group('UpdateCartItemInstructions', () {
      blocTest<CartBloc, CartState>(
        'updates item special instructions',
        build: () => cartBloc,
        seed: () => const CartState(
          items: [CartItem(foodItem: tFoodItem, quantity: 1)],
          subtotal: 12.99,
          totalItems: 1,
        ),
        act: (bloc) => bloc.add(
          const UpdateCartItemInstructions(
            foodItemId: '1',
            specialInstructions: 'Extra cheese',
          ),
        ),
        expect: () => [
          CartState(
            items: const [
              CartItem(
                foodItem: tFoodItem,
                quantity: 1,
                specialInstructions: 'Extra cheese',
              ),
            ],
            subtotal: 12.99,
            totalItems: 1,
          ),
        ],
      );
    });

    group('ClearCart', () {
      blocTest<CartBloc, CartState>(
        'clears all items from cart',
        build: () => cartBloc,
        seed: () => const CartState(
          items: [
            CartItem(foodItem: tFoodItem, quantity: 1),
            CartItem(foodItem: tFoodItem2, quantity: 2),
          ],
          subtotal: 30.97,
          totalItems: 3,
        ),
        act: (bloc) => bloc.add(ClearCart()),
        expect: () => [
          const CartState(),
        ],
      );
    });
  });
}