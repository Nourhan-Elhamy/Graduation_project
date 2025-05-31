import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/utils/services/Api_service.dart';

import 'package:graduation_project/features/user/data/models/medicine/medicine/datum.dart';
import 'package:graduation_project/shared_widgets/product_list.dart';

import 'package:dio/dio.dart';

import '../../../wish_tab/data/controller/wishlist_cubit.dart';
import '../../../wish_tab/data/controller/wishlist_states.dart';
import '../product_details/presentation/product_details_screen.dart';
class DrugViewGrid extends StatelessWidget {
  const DrugViewGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Datum>>(
      future: ApiService(Dio()).getMedicines(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('error: ${snapshot.error}'));
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('There are no medications'));
        }

        final List<Datum> medicines = snapshot.data!;

        return BlocBuilder<WishlistCubit, WishlistState>(
          builder: (context, state) {
            final wishlistCubit = context.read<WishlistCubit>();

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.w, // ريسبونسف
                mainAxisSpacing: 10.h, // ريسبونسف
                mainAxisExtent: 250.h, // لو بتحبي تثبتي الارتفاع
              ),
              itemCount: medicines.length,
              itemBuilder: (context, index) {
                final medicine = medicines[index];
                final isFavorite = wishlistCubit.isFavorite(medicine.id!);

                return ProductList(
                  icon: isFavorite
                      ? Icons.favorite
                      : Icons.favorite_border_outlined,
                  onIconPressed: () {
                    if (isFavorite) {
                      wishlistCubit.removeFromWishlist(medicine.id!);
                    } else {
                      wishlistCubit.addToWishlist(medicine.id!);
                    }
                  },
                  image: medicine.image ?? '',
                  name: medicine.name ?? '',
                  egp: "EGP",
                  price: medicine.price.toString(),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            ProductDetailsScreen(productId: medicine.id!),
                      ),
                    );
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}
