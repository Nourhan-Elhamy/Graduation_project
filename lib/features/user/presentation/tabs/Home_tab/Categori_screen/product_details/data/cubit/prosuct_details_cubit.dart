import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/features/user/presentation/tabs/Home_tab/Categori_screen/product_details/data/cubit/product_details_states.dart';

import '../repos/prosuct_details_repo.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit() : super(ProductDetailsInitial());

  void fetchProductDetails(String id) async {
    try {
      emit(ProductDetailsLoading());
      final product = await ProductDetailsService.fetchProductById(id);
      emit(ProductDetailsLoaded(product));
    } catch (e) {
      emit(ProductDetailsError('فشل تحميل تفاصيل المنتج'));
    }
  }
}

