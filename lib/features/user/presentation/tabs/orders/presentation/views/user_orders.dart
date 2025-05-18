import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/utils/app_colors.dart';
import 'package:graduation_project/features/user/presentation/tabs/orders/presentation/views/user_order_details.dart';

import '../controller/orders_cubit.dart';
import '../controller/orders_states.dart';
class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({super.key});

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  @override
  void initState() {
    super.initState();
    context.read<OrderCubit>().getOrders();
  }

  Future<void> _viewOrderDetails(String orderId) async {
    // تحميل تفاصيل الطلب
    await context.read<OrderCubit>().getOrderDetails(orderId);

    final currentState = context.read<OrderCubit>().state;
    if (currentState is OrderDetailLoaded) {
      // فتح صفحة التفاصيل وانتظار رجوع المستخدم
      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => OrderDetailsPage(orderDetail: currentState.orderDetail),
        ),
      );

      // بعد الرجوع من صفحة التفاصيل: جلب الطلبات من جديد
      context.read<OrderCubit>().getOrders();
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xfff6f7fb),
      appBar: AppBar(
        title: Text(
          "All Orders",
          style: TextStyle(color: AppColors.blue),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: BlocBuilder<OrderCubit, OrderState>(
        builder: (context, state) {
          if (state is OrderLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is OrdersLoaded) {
            if (state.orders.isEmpty) {
              return const Center(child: Text("You have no orders."));
            }

            return ListView.builder(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.05,
                vertical: 16,
              ),
              itemCount: state.orders.length,
              itemBuilder: (context, index) {
                final order = state.orders[index];

                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.blue),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.grey.withOpacity(0.04),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Order ID and Status
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              "Order : ${order.id}",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: width * 0.04,
                                color: AppColors.grey,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(Icons.circle,
                                  size: 20, color: Colors.amberAccent),
                              const SizedBox(width: 4),
                              Text(
                                order.status,
                                style: TextStyle(
                                  color: Colors.amberAccent,
                                  fontWeight: FontWeight.w500,
                                  fontSize: width * 0.035,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      // Total price
                      Text(
                        "Total Price: ${order.totalAmount} EGP",
                        style: TextStyle(
                            fontSize: width * 0.038, color: AppColors.grey),
                      ),
                      const SizedBox(height: 4),

                      // Action buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () => _viewOrderDetails(order.id),
                            child: Text(
                              "View Details",
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.w500,
                                fontSize: width * 0.035,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
            );
          } else if (state is OrderFailure) {
            return Center(child: Text("Error: ${state.error}"));
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
