import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    return  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
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
                top: 8,
                left: 8,
                child: CircleAvatar(
                  backgroundColor: Colors.white70,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ),

            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget.product.name,
                  style: TextStyle(
                    fontSize: 30,
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
                        fontSize: 20,
                        color: AppColors.grey,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      widget.product.substance,
                      style: TextStyle(
                        fontSize: 17,
                        color: AppColors.grey.withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  widget.product.description,
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.grey.withOpacity(0.8),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 10),
                SizedBox(height: MediaQuery.of(context).size.height*0.1),

                Row(
                  children: [
                    Text(
                      "From",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: AppColors.grey,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      "EGP ${widget.product.price}",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 30,
                        color: AppColors.grey,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: MediaQuery.of(context).size.height*0.02),

                BlocBuilder<PharmacyCubit, PharmacyState>(
                  builder: (context, state) {
                    if (state is PharmacyLoading) {
                      return const CircularProgressIndicator();
                    } else if (state is PharmacyLoaded) {
                      return SizedBox(
                        height: MediaQuery.of(context).size.height*0.05,
                        child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: state.pharmacies.length,
                            separatorBuilder: (_, __) => const SizedBox(width: 10),
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
                              duration: const Duration(milliseconds: 200),
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                color: isSelected ? AppColors.blue : AppColors.blue.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),

                              ),
                              child: Center(
                                child: Text(
                                  pharmacy.name,
                                  style: TextStyle(
                                    color: isSelected ? Colors.white : Color(0xff00A3E0),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                    } else if (state is PharmacyError) {
                    return Text("Failed to load pharmacies", style: TextStyle(color: Colors.red));
                    } else {
                    return const SizedBox.shrink();
                    }
                  },
                ),
                SizedBox(height: MediaQuery.of(context).size.height*0.01),

                Row(
                  children: [

                    Expanded(
                      child: BlocConsumer<CartCubit, CartState>(
                        listener: (context, state) {
                          if (state is CartItemAdded) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                state.cartItem.message?? "" ,
                                  style: const TextStyle(color: Colors.white, fontSize: 16),
                                ),
                                backgroundColor: Colors.green.withOpacity(0.9),
                                behavior: SnackBarBehavior.floating,
                                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                duration: const Duration(seconds: 3),
                              ),
                            );
                          } else if (state is CartFailure) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('${state.error}', style: const TextStyle(color: Colors.white, fontSize: 16),)
                                ,  backgroundColor: Colors.green.withOpacity(0.9),
                              behavior: SnackBarBehavior.floating,
                              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              duration: const Duration(seconds: 3),
                            ),
                            );
                          }
                        },
                        builder: (context, state) {
                          return CustomButton(
                            title: state is CartLoading ? "Trying add item to cart.." : "Add To Cart",
                            color: AppColors.blue,
                            textcolor: AppColors.white,
                            onPressed: state is CartLoading
                                ? null
                                : () {
                              context.read<CartCubit>().addToCart(
                                widget.product.id,
                                1,
                              );
                            },
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    BlocConsumer<WishlistCubit, WishlistState>(
                      listener: (context, state) {
                        if (state is WishlistSuccess) {

                        } else if (state is WishlistFailure) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(state.error),
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
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: IconButton(
                            icon: Icon(
                              isFavorite ? Icons.favorite : Icons.favorite_border,
                              color: AppColors.blue,
                              size: 40,
                            ),
                            onPressed: state is WishlistLoading
                                ? null
                                : () {
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