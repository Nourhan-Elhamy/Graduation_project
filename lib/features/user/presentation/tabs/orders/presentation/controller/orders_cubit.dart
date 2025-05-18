// lib/cubits/order/order_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/orders_models.dart';
import '../../data/repo/orders_repo.dart';
import 'orders_states.dart';

class OrderCubit extends Cubit<OrderState> {
  final OrderRepo orderRepo;

  OrderCubit(this.orderRepo) : super(OrderInitial());

  Future<void> createOrder(CreateOrderRequest request) async {
    emit(OrderLoading());
    try {
      await orderRepo.createOrder(request);
      emit(OrderSuccess());
    } catch (e) {
      emit(OrderFailure(e.toString()));
    }
  }
  Future<void> getOrders() async {
    emit(OrderLoading());
    try {
      final orders = await orderRepo.getOrders();
      emit(OrdersLoaded(orders));
    } catch (e) {
      emit(OrderFailure(e.toString()));
    }
  }

  Future<void> getOrderDetails(String orderId) async {
    emit(OrderLoading());
    try {
      final orderDetail = await orderRepo.getOrderById(orderId);
      emit(OrderDetailLoaded(orderDetail));
    } catch (e) {
      emit(OrderFailure(e.toString()));
    }
  }

}
