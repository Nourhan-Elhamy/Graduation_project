// drug_view_horizontal.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/utils/services/Api_service.dart';

import 'package:graduation_project/features/user/data/models/medicine/medicine/datum.dart';
import 'package:graduation_project/shared_widgets/product_list.dart';

import 'package:dio/dio.dart';

import '../../../cart/presentation/controller/cart_cubit.dart';
import '../../../cart/presentation/controller/cart_states.dart';
import '../product_details/presentation/product_details_screen.dart';
class DrugViewHorizontal extends StatelessWidget {
  const DrugViewHorizontal({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Datum>>(
      future: ApiService(Dio()).getMedicines(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          debugPrint('Snapshot Error: ${snapshot.error}');
          return Center(child: Text('error: ${snapshot.error}'));
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('  There are no medications'));
        }

        final List<Datum> medicines = snapshot.data!;

        return BlocListener<CartCubit, CartState>(
          listener: (context, state) {
            if (state is CartItemAdded) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.cartItem.message ?? "",
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  backgroundColor: Colors.green.withOpacity(0.9),
                  behavior: SnackBarBehavior.floating,
                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  duration: const Duration(seconds: 2),
                ),
              );
            } else if (state is CartFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.error,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  backgroundColor: Colors.red.withOpacity(0.9),
                  behavior: SnackBarBehavior.floating,
                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  duration: const Duration(seconds: 2),
                ),
              );
            }
          },
          child: SizedBox(
            height: 210,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: medicines.length,
              itemBuilder: (context, index) {
                final medicine = medicines[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Builder(
                    builder: (context) {
                      return BlocBuilder<CartCubit, CartState>(
                        builder: (context, state) {
                          return ProductList(
                            icon: Icons.add,
                            onIconPressed: state is CartLoading
                                ? null
                                : () {
                              context.read<CartCubit>().addToCart(
                                medicine.id!,
                                1,
                              );
                            },
                            image: medicine.image ?? '',
                            name: medicine.name ?? '',
                            egp: "EGP",
                            price: medicine.price.toString(),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => ProductDetailsScreen(
                                    productId: medicine.id!,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
