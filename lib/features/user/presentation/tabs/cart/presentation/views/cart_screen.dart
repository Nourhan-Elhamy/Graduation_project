// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:graduation_project/features/user/presentation/tabs/orders/presentation/views/order_screen.dart';
import 'package:graduation_project/shared_widgets/custom_button.dart';
import '../../../../../../../core/utils/app_colors.dart';

import '../controller/cart_cubit.dart';
import '../controller/cart_states.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: [
          TextButton(
              onPressed: () async {
                final confirmed = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Confirm'),
                    content: const Text('Are you sure you want to delete cart'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: const Text('No'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        child: const Text('Yes'),
                      ),
                    ],
                  ),
                );

                if (confirmed == true) {
                  context.read<CartCubit>().clearCart();
                }
              },
              child: Text("Clear All",
                  style: TextStyle(color: Colors.red, fontSize: 20)))
        ],
        title: const Text(
          "Cart",
          style: TextStyle(color: Colors.blue, fontSize: 30),
        ),
      ),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CartSuccess) {
            final cart = state.cart;
            if (cart.items.isEmpty) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/3x/cartImage.png",
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.4,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "No Items in Your Cart",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              );
            } else {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: cart.items.length,
                        itemBuilder: (context, index) {
                          final item = cart.items[index];
                          return Card(
                            child: ListTile(
                              leading: Image.network(item.medicine.image),
                              title: Text(item.medicine.name),
                              subtitle: Text(
                                'Quantity: ${item.quantity}',
                                maxLines: 2,
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    item.medicine.price,
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.delete_outline,
                                        color: Colors.red),
                                    onPressed: () {
                                      context.read<CartCubit>().deleteFromCart(
                                          item.medicine
                                              .id); // هنا ID العنصر في السلة
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Sub Total:',
                            style: TextStyle(fontSize: 16)),
                        Text('${cart.totalPrice} EGP'),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('Shipping:', style: TextStyle(fontSize: 16)),
                        Text('20 EGP'),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('TOTAL:',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        Text('${cart.totalPrice + 20} EGP',
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                        width: double.infinity,
                        child: CustomButton(
                          title: "Checkout",
                          color: AppColors.blue,
                          textcolor: AppColors.white,
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (c) {
                              return CreateOrderScreen();
                            }));
                          },
                        )),
                  ],
                ),
              );
            }
          } else if (state is CartFailure) {
            return Center(child: Text("Error: ${state.error}"));
          } else {
            return const Center(child: Text("Something went wrong"));
          }
        },
      ),
    );
  }
}
