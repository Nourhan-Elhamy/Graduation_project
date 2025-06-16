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

class DrugViewGrid extends StatefulWidget {
  const DrugViewGrid({super.key});

  @override
  State<DrugViewGrid> createState() => _DrugViewGridState();
}

class _DrugViewGridState extends State<DrugViewGrid> {
  final ScrollController _scrollController = ScrollController();
  List<Datum> _medicines = [];
  int _currentPage = 1;
  bool _isLoading = false;
  bool _hasMore = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _fetchMedicines();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        !_isLoading &&
        _hasMore &&
        !_hasError) {
      _fetchMedicines();
    }
  }

  Future<void> _fetchMedicines() async {
    setState(() {
      _isLoading = true;
      _hasError = false;
    });
    try {
      final newMedicines =
          await ApiService(Dio()).getMedicines(page: _currentPage);
      if (newMedicines.isEmpty) {
        _hasMore = false;
      } else {
        setState(() {
          _medicines.addAll(newMedicines);
          _currentPage++;
        });
      }
    } catch (e) {
      debugPrint("Error loading medicines: $e");
      _hasError = true;
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _retry() {
    _fetchMedicines();
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
        if (_medicines.isEmpty && _isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (_medicines.isEmpty && _hasError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Failed to load data, please try again."),
                SizedBox(height: 10.h),
                ElevatedButton(
                  onPressed: _retry,
                  child: const Text("Retry"),
                ),
              ],
            ),
          );
        }

        if (_medicines.isEmpty) {
          return const Center(
              child: Text('There are no medications currentlyy'));
        }

        return GridView.builder(
          controller: _scrollController,
          padding: EdgeInsets.all(8.w),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.w,
            mainAxisSpacing: 10.h,
            mainAxisExtent: 250.h,
          ),
          itemCount: _medicines.length + (_hasMore || _hasError ? 1 : 0),
          itemBuilder: (context, index) {
            if (index < _medicines.length) {
              final medicine = _medicines[index];
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
