import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/item_model.dart';
import '../models/order_model.dart';

class CartCubit extends Cubit<List<Item>> {
  CartCubit() : super([]);

  void addItem(Item item) {
    final existingItemIndex =
        state.indexWhere((i) => i.productId == item.productId);
    if (existingItemIndex == -1) {
      item.quantity = 1;
      state.add(item);
    } else {
      state[existingItemIndex].quantity++;
    }
    emit(List.from(state));
  }

  void decreaseQuantity(Item item) {
    final existingItemIndex =
        state.indexWhere((i) => i.productId == item.productId);
    if (existingItemIndex != -1) {
      if (state[existingItemIndex].quantity > 1) {
        state[existingItemIndex].quantity--;
      } else {
        state[existingItemIndex].quantity = 0;
      }
      emit(List.from(state));
    }
  }

  void removeItem(Item item) {
    state.removeWhere((i) => i.productId == item.productId);
    emit(List.from(state));
  }

  double get totalAmount {
    return state.fold(0.0, (sum, item) => sum + item.totalPrice);
  }

  Order completeOrder() {
    final orderId = DateTime.now().millisecondsSinceEpoch.toString();
    return Order(
      orderId: orderId,
      items: List.from(state),
      totalAmount: totalAmount,
      createdAt: DateTime.now(),
    );
  }

  void clearCart() {
    emit([]);
  }
}
