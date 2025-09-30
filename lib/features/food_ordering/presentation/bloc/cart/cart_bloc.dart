import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/cart_item.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const CartState()) {
    on<AddToCart>(_onAddToCart);
    on<RemoveFromCart>(_onRemoveFromCart);
    on<UpdateCartItemQuantity>(_onUpdateCartItemQuantity);
    on<UpdateCartItemInstructions>(_onUpdateCartItemInstructions);
    on<ClearCart>(_onClearCart);
  }

  void _onAddToCart(AddToCart event, Emitter<CartState> emit) {
    final existingItemIndex = state.items.indexWhere(
      (item) => item.foodItem.id == event.foodItem.id,
    );

    List<CartItem> updatedItems;
    
    if (existingItemIndex >= 0) {
      // Update existing item quantity
      updatedItems = List.from(state.items);
      final existingItem = updatedItems[existingItemIndex];
      updatedItems[existingItemIndex] = existingItem.copyWith(
        quantity: existingItem.quantity + event.quantity,
        specialInstructions: event.specialInstructions ?? existingItem.specialInstructions,
      );
    } else {
      // Add new item
      updatedItems = [
        ...state.items,
        CartItem(
          foodItem: event.foodItem,
          quantity: event.quantity,
          specialInstructions: event.specialInstructions,
        ),
      ];
    }

    _emitUpdatedState(emit, updatedItems);
  }

  void _onRemoveFromCart(RemoveFromCart event, Emitter<CartState> emit) {
    final updatedItems = state.items
        .where((item) => item.foodItem.id != event.foodItemId)
        .toList();
    
    _emitUpdatedState(emit, updatedItems);
  }

  void _onUpdateCartItemQuantity(
    UpdateCartItemQuantity event,
    Emitter<CartState> emit,
  ) {
    if (event.quantity <= 0) {
      add(RemoveFromCart(foodItemId: event.foodItemId));
      return;
    }

    final updatedItems = state.items.map((item) {
      if (item.foodItem.id == event.foodItemId) {
        return item.copyWith(quantity: event.quantity);
      }
      return item;
    }).toList();

    _emitUpdatedState(emit, updatedItems);
  }

  void _onUpdateCartItemInstructions(
    UpdateCartItemInstructions event,
    Emitter<CartState> emit,
  ) {
    final updatedItems = state.items.map((item) {
      if (item.foodItem.id == event.foodItemId) {
        return item.copyWith(specialInstructions: event.specialInstructions);
      }
      return item;
    }).toList();

    _emitUpdatedState(emit, updatedItems);
  }

  void _onClearCart(ClearCart event, Emitter<CartState> emit) {
    emit(const CartState());
  }

  void _emitUpdatedState(Emitter<CartState> emit, List<CartItem> items) {
    final subtotal = items.fold<double>(
      0.0,
      (sum, item) => sum + item.totalPrice,
    );
    
    final totalItems = items.fold<int>(
      0,
      (sum, item) => sum + item.quantity,
    );

    emit(CartState(
      items: items,
      subtotal: subtotal,
      totalItems: totalItems,
    ));
  }
}