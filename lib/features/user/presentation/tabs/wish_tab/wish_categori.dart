// ignore_for_file: unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/utils/app_colors.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../Home_tab/Categori_screen/product_details/presentation/product_details_screen.dart';
import 'data/controller/wishlist_cubit.dart';
import 'data/controller/wishlist_states.dart';


class WishCategori extends StatefulWidget {
  const WishCategori({super.key});

  @override
  State<WishCategori> createState() => _WishCategoriState();
}

class _WishCategoriState extends State<WishCategori> {
  @override
  void initState() {
    super.initState();
    context.read<WishlistCubit>().fetchWishlist();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        title:  Text(
          'Wish List',
          style: TextStyle(
            color: AppColors.blue,
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocBuilder<WishlistCubit, WishlistState>(
        builder: (context, state) {
          if (state is WishlistLoading) {
            return  Center(child: CircularProgressIndicator(
              color: AppColors.blue,

            ));
          } else if (state is WishlistFailure) {
            return Center(child: Text('Error: ${state.error}'));
          } else {
            final items = context.read<WishlistCubit>().wishlistItems;
            if (items.isEmpty) {
              return Center(
                child: Image.asset("assets/images/favorite_image.png"),
              );
            }

            return ListView.separated(
              padding:  EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              itemCount: items.length,
              separatorBuilder: (context, index) =>  SizedBox(height: 10.h),
              itemBuilder: (context, index) {
                final item = items[index];
                return GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (c){
                      return ProductDetailsScreen(productId: item.id);
                    }));
                  },
                  child: Container(
                    padding:  EdgeInsets.all(8.r),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.15),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        // Image
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            item.image,
                            width: width * 0.22,
                            height: width * 0.22,
                            fit: BoxFit.contain,
                          ),
                        ),
                      SizedBox(width: 12.w),
                        // Name and price
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.name,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.grey,
                                  fontSize: 16.sp,
                                ),
                              ),
                               SizedBox(height: 4.h),
                              Text(
                                '${item.price}',
                                style: TextStyle(
                                  color: AppColors.grey,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Delete icon
                        IconButton(
                          onPressed: () {
                            context
                                .read<WishlistCubit>()
                                .removeFromWishlist(item.id);
                          },
                          icon: const Icon(Icons.delete, color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
