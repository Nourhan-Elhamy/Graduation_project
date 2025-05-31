// ignore_for_file: use_super_parameters, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/shared_widgets/custom_button.dart';
import '../../../../../../../../../core/utils/app_colors.dart';
import '../../../../../cart/presentation/controller/cart_cubit.dart';
import '../../../../../cart/presentation/controller/cart_states.dart';
import '../../../../../pharmacie_tab/pharmacy_list/controller/pharmacy_cubit.dart';
import '../../../../../wish_tab/data/controller/wishlist_cubit.dart';
import '../../../../../wish_tab/data/controller/wishlist_states.dart';
import '../../data/repos/models.dart';
class ProductPreviewCard extends StatefulWidget {
  final ProductDetails product;

  const ProductPreviewCard({Key? key, required this.product}) : super(key: key);

  @override
  _ProductPreviewCardState createState() => _ProductPreviewCardState();
}

class _ProductPreviewCardState extends State<ProductPreviewCard> {
  String? selectedPharmacy;
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(15.r)),
              child: AspectRatio(
                aspectRatio: 1,
                child: Image.network(
                  widget.product.image,
                  width: double.infinity,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Positioned(
              top: 8.h,
              left: 8.w,
              child: CircleAvatar(
                backgroundColor: Colors.white70,
                child: IconButton(
                  icon: Icon(Icons.arrow_back_ios_new, size: 20.sp),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.all(10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                widget.product.name,
                style: TextStyle(
                  fontSize: 30.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.grey,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Active Ingredient :",
                    style: TextStyle(
                      fontSize: 20.sp,
                      color: AppColors.grey,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Flexible(
                    child: Text(
                      widget.product.substance,
                      style: TextStyle(
                        fontSize: 17.sp,
                        color: AppColors.grey.withOpacity(0.8),
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 6.h),
              Text(
                widget.product.description,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: AppColors.grey.withOpacity(0.8),
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 20.h),

              Row(
                children: [
                  Text(
                    "From",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.sp,
                      color: AppColors.grey,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    "EGP ${widget.product.price}",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 30.sp,
                      color: AppColors.grey,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 0.02.h),
              BlocBuilder<PharmacyCubit, PharmacyState>(
                builder: (context, state) {
                  if (state is PharmacyLoading) {
                    return const CircularProgressIndicator();
                  } else if (state is PharmacyLoaded) {
                    return SizedBox(
                      height: 0.07.sh,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.pharmacies.length,
                        separatorBuilder: (_, __) => SizedBox(width: 10.w),
                        itemBuilder: (context, index) {
                          final pharmacy = state.pharmacies[index];
                          final isSelected = selectedPharmacy == pharmacy.name;

                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedPharmacy = pharmacy.name;
                              });
                            },
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 200),
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 8.h,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppColors.blue
                                    : AppColors.blue.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                child: Text(
                                  pharmacy.name,
                                  style: TextStyle(
                                    color: isSelected
                                        ? Colors.white
                                        : Color(0xff00A3E0),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  } else if (state is PharmacyError) {
                    return Text("Failed to load pharmacies",
                        style: TextStyle(color: Colors.red, fontSize: 14.sp));
                  } else {
                    return SizedBox.shrink();
                  }
                },
              ),
              SizedBox(height: 0.01.sh),
              Row(
                children: [
                  Expanded(
                    child: BlocConsumer<CartCubit, CartState>(
                      listener: (context, state) {
                        if (state is CartItemAdded) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                state.cartItem.message ?? "",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16.sp),
                              ),
                              backgroundColor: Colors.green.withOpacity(0.9),
                              behavior: SnackBarBehavior.floating,
                              margin: EdgeInsets.symmetric(
                                  horizontal: 20.w, vertical: 10.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.r),
                              ),
                              duration: Duration(seconds: 3),
                            ),
                          );
                        } else if (state is CartFailure) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                state.error,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16.sp),
                              ),
                              backgroundColor: Colors.green.withOpacity(0.9),
                              behavior: SnackBarBehavior.floating,
                              margin: EdgeInsets.symmetric(
                                  horizontal: 20.w, vertical: 10.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.r),
                              ),
                              duration: Duration(seconds: 3),
                            ),
                          );
                        }
                      },
                      builder: (context, state) {
                        return CustomButton(
                          title: state is CartLoading
                              ? "Trying add item to cart.."
                              : "Add To Cart",
                          color: AppColors.blue,
                          textcolor: AppColors.white,
                          onPressed: state is CartLoading
                              ? null
                              : () {
                            if (selectedPharmacy == null) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "Please select a pharmacy first.",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.sp),
                                  ),
                                  backgroundColor:
                                  Colors.red.withOpacity(0.9),
                                  behavior: SnackBarBehavior.floating,
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 20.w, vertical: 10.h),
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(15.r),
                                  ),
                                  duration: Duration(seconds: 3),
                                ),
                              );
                              return;
                            }

                            context.read<CartCubit>().addToCart(
                              widget.product.id,
                              1,
                            );
                          },
                        );
                      },
                    ),
                  ),
                  SizedBox(width: 10.w),
                  BlocConsumer<WishlistCubit, WishlistState>(
                    listener: (context, state) {
                      if (state is WishlistSuccess) {
                      } else if (state is WishlistFailure) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.error, style: TextStyle(fontSize: 14.sp)),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      final cubit = context.read<WishlistCubit>();
                      final isFavorite = cubit.isFavorite(widget.product.id);

                      return Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.blue),
                          borderRadius: BorderRadius.circular(14.r),
                        ),
                        child: IconButton(
                          icon: Icon(
                            isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: AppColors.blue,
                            size: 40.sp,
                          ),
                          onPressed: () {
                            if (isFavorite) {
                              cubit.removeFromWishlist(widget.product.id);
                            } else {
                              cubit.addToWishlist(widget.product.id);
                            }
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
