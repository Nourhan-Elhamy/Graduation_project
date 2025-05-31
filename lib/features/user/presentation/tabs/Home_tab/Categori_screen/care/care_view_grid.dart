import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/utils/services/Api_service.dart';
import 'package:graduation_project/features/user/data/models/care/care/datum.dart';

import 'package:graduation_project/shared_widgets/product_list.dart';

import 'package:dio/dio.dart';

import '../../../wish_tab/data/controller/wishlist_cubit.dart';
import '../../../wish_tab/data/controller/wishlist_states.dart';
import '../product_details/presentation/product_details_screen.dart';


class CareViewGrid extends StatelessWidget {
  const CareViewGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Catum>>(
      future: ApiService(Dio()).getCare(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('error: ${snapshot.error}'));
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('There are no medications  '));
        }

        final List<Catum> care = snapshot.data!;

        return BlocBuilder<WishlistCubit, WishlistState>(
          builder: (context, state) {
            final wishlistCubit = context.read<WishlistCubit>();

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 0.1,
                mainAxisSpacing: 5,
              ),
              itemCount: care.length,
              itemBuilder: (context, index) {
                final medicine = care[index];
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
