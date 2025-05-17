import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/shared_widgets/custom_button.dart';
import '../../../../../../../../../core/utils/app_colors.dart';
import '../../../../../pharmacie_tab/pharmacy_list/controller/pharmacy_cubit.dart';
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
                      child: CustomButton(
                        title: "Add To Cart",
                        color: AppColors.blue,
                        textcolor: AppColors.white,
                        onPressed: () {},
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.blue),
                        borderRadius: BorderRadius.circular(14)
                      ),
                      child: IconButton(
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? AppColors.blue : AppColors.blue,
                          size: 40,
                        ),
                        onPressed: () {
                          setState(() {
                            isFavorite = !isFavorite;
                          });
                        },
                      ),
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