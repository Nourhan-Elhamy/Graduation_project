import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repos/cart_repo.dart';
import 'cart_states.dart';

class CartCubit extends Cubit<CartState> {
  final CartRepo cartRepo;

  CartCubit(this.cartRepo) : super(CartInitial());

  Future<void> getCart() async {
    emit(CartLoading());
    try {
      final cart = await cartRepo.getCart();
      emit(CartSuccess(cart));
    } catch (e) {
      emit(CartFailure(e.toString()));
    }
  }

  Future<void> addToCart(String medicineId, int quantity) async {
    emit(CartLoading());
    try {
      final cartItem = await cartRepo.addToCart(
        medicineId: medicineId,
        quantity: quantity,
      );
      emit(CartItemAdded(cartItem));

      // بعد الإضافة، يمكن تحديث السلة لجلب البيانات الجديدة
      await getCart();
    } catch (e) {
      emit(CartFailure(e.toString()));
    }
  }

  Future<void> deleteFromCart(String itemId) async {
    emit(CartLoading());
    try {
      await cartRepo.deleteCartItem(itemId);
      emit(CartItemDeleted(itemId));
      // بعد الحذف، تحديث السلة
      await getCart();
    } catch (e) {
      emit(CartFailure(e.toString()));
    }
  }

  Future<void> clearCart() async {
    emit(CartLoading()); // ضروري علشان BlocBuilder يعيد البناء
    try {
      await cartRepo.clearCart();
      final updatedCart = await cartRepo.getCart();
      emit(CartSuccess(updatedCart));
    } catch (e) {
      emit(CartFailure(e.toString()));
    }
  }
}
