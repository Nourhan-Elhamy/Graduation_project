// lib/cubits/order/order_state.dart
import '../../data/models/orders_models.dart';

abstract class OrderState {}

class OrderInitial extends OrderState {}

class OrderLoading extends OrderState {}

class OrderSuccess extends OrderState {}

class OrderFailure extends OrderState {
  final String error;
  OrderFailure(this.error);
}

class OrdersLoaded extends OrderState {
  final List<Order> orders;
  OrdersLoaded(this.orders);
}

class OrderDetailLoaded extends OrderState {
  final OrderDetail orderDetail;
  OrderDetailLoaded(this.orderDetail);
}

