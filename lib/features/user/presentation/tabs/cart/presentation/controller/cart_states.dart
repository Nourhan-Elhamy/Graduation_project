import 'package:equatable/equatable.dart';
import '../../data/models/cart_model.dart';
import '../../data/models/getcart_model.dart';
abstract class CartState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartSuccess extends CartState {
  final CartModel cart;

  CartSuccess(this.cart);

  @override
  List<Object?> get props => [cart];
}

class CartItemAdded extends CartState {
  final CartItemModel cartItem;

  CartItemAdded(this.cartItem);

  @override
  List<Object?> get props => [cartItem];
}

class CartItemDeleted extends CartState {
  final String deletedItemId;

  CartItemDeleted(this.deletedItemId);

  @override
  List<Object?> get props => [deletedItemId];
}

class CartFailure extends CartState {
  final String error;

  CartFailure(this.error);

  @override
  List<Object?> get props => [error];
}
