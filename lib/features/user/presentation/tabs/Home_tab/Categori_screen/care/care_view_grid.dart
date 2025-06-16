import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';

import 'package:graduation_project/core/utils/services/Api_service.dart';
import 'package:graduation_project/features/user/data/models/care/care/datum.dart';
import 'package:graduation_project/shared_widgets/product_list.dart';
import '../../../../../data/models/medicine/medicine/datum.dart';
import '../../../wish_tab/data/controller/wishlist_cubit.dart';
import '../../../wish_tab/data/controller/wishlist_states.dart';
import '../product_details/presentation/product_details_screen.dart';
class CareViewGrid extends StatefulWidget {
  const CareViewGrid({super.key});

  @override
  State<CareViewGrid> createState() => _CareViewGridState();
}

class _CareViewGridState extends State<CareViewGrid> {
  final ScrollController _scrollController = ScrollController();
  List<Datum> _careItems = [];
  int _currentPage = 1;
  bool _isLoading = false;
  bool _hasMore = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _fetchCare();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200 &&
        !_isLoading &&
        _hasMore &&
        !_hasError) {
      _fetchCare();
    }
  }

  Future<void> _fetchCare() async {
    setState(() {
      _isLoading = true;
      _hasError = false;
    });
    try {
      final newItems = await ApiService(Dio()).getCare(page: _currentPage);
      if (newItems.isEmpty) {
        _hasMore = false;
      } else {
        setState(() {
          _careItems.addAll(newItems);
          _currentPage++;
        });
      }
    } catch (e) {
      debugPrint("Error loading care items: $e");
      _hasError = true;
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _retry() {
    _fetchCare();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final wishlistCubit = context.read<WishlistCubit>();

    return BlocBuilder<WishlistCubit, WishlistState>(
      builder: (context, state) {
        if (_careItems.isEmpty && _isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (_careItems.isEmpty && _hasError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Failed to load data, please try again."),
                ElevatedButton(
                  onPressed: _retry,
                  child: const Text("Retry"),
                ),
              ],
            ),
          );
        }

        if (_careItems.isEmpty) {
          return const Center(child: Text('There are no care items currently.'));
        }

        return GridView.builder(
          controller: _scrollController,
          padding: const EdgeInsets.all(8),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 10,
            mainAxisExtent: 250,
          ),
          itemCount: _careItems.length + (_hasMore || _hasError ? 1 : 0),
          itemBuilder: (context, index) {
            if (index < _careItems.length) {
              final item = _careItems[index];
              final isFavorite = wishlistCubit.isFavorite(item.id!);

              return ProductList(
                icon: isFavorite
                    ? Icons.favorite
                    : Icons.favorite_border_outlined,
                onIconPressed: () {
                  if (isFavorite) {
                    wishlistCubit.removeFromWishlist(item.id!);
                  } else {
                    wishlistCubit.addToWishlist(item.id!);
                  }
                },
                image: item.image ?? '',
                name: item.name ?? '',
                egp: "EGP",
                price: item.price.toString(),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          ProductDetailsScreen(productId: item.id!),
                    ),
                  );
                },
              );
            } else if (_hasError) {
              return Center(
                child: TextButton(
                  onPressed: _retry,
                  child: const Text("An error occurred, tap to retry"),
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        );
      },
    );
  }
}
