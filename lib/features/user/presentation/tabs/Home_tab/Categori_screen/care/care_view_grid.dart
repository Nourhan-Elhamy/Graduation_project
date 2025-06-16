import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';

import 'package:graduation_project/core/utils/services/Api_service.dart';
import 'package:graduation_project/features/user/data/models/care/care/datum.dart';
import 'package:graduation_project/shared_widgets/product_list.dart';
import '../../../wish_tab/data/controller/wishlist_cubit.dart';
import '../../../wish_tab/data/controller/wishlist_states.dart';
import '../product_details/presentation/product_details_screen.dart';

class CareViewGrid extends StatefulWidget {
  const CareViewGrid({super.key});

  @override
  State<CareViewGrid> createState() => _CareViewGridState();
}

class _CareViewGridState extends State<CareViewGrid> {
  List<Catum> careItems = [];
  int page = 1;
  bool isLoading = false;
  bool hasMore = true;

  @override
  void initState() {
    super.initState();
    _fetchCare();
  }

  Future<void> _fetchCare() async {
    if (isLoading || !hasMore) return;

    setState(() => isLoading = true);

    try {
      final newItems = await ApiService(Dio()).getCare(page: page);
      setState(() {
        careItems.addAll(newItems);
        isLoading = false;
        page++;
        if (newItems.length < 20) hasMore = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WishlistCubit, WishlistState>(
      builder: (context, state) {
        final wishlistCubit = context.read<WishlistCubit>();

        return SliverGrid(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              if (index == careItems.length - 1 && hasMore && !isLoading) {
                _fetchCare();
              }

              if (index == careItems.length && isLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (index >= careItems.length) return const SizedBox.shrink();

              final medicine = careItems[index];
              final isFavorite = wishlistCubit.isFavorite(medicine.id!);

              return ProductList(
                icon: isFavorite
                    ? Icons.favorite
                    : Icons.favorite_border_outlined,
                onIconPressed: () {
                  isFavorite
                      ? wishlistCubit.removeFromWishlist(medicine.id!)
                      : wishlistCubit.addToWishlist(medicine.id!);
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
            childCount: careItems.length + (isLoading ? 1 : 0),
          ),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: 0.7,
          ),
        );
      },
    );
  }
}
