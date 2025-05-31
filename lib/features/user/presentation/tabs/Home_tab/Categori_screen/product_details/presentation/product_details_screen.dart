import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/features/user/presentation/tabs/Home_tab/Categori_screen/product_details/presentation/widgets/product_card.dart';
import '../../../../pharmacie_tab/pharmacy_list/controller/pharmacy_cubit.dart';
import '../../../../pharmacie_tab/pharmacy_list/data/repos/pharmacy_implementation_repo.dart';
import '../data/cubit/product_details_states.dart';
import '../data/cubit/prosuct_details_cubit.dart';
class ProductDetailsScreen extends StatelessWidget {
  final String productId;

  const ProductDetailsScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ProductDetailsCubit()..fetchProductDetails(productId),
        ),
        BlocProvider(
          create: (_) => PharmacyCubit(pharmacyRepo: PharmacyRepoImplementationFromApi())..fetchPharmacies(),
        ),
      ],
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(10.0.r),
            child: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
              builder: (context, state) {
                if (state is ProductDetailsLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ProductDetailsLoaded) {
                  return ProductPreviewCard(product: state.product);
                } else if (state is ProductDetailsError) {
                  return Center(child: Text(state.message));
                }
                return const SizedBox.shrink();
              },

            ),
          ),
        ),

      ),
    );
  }
}
