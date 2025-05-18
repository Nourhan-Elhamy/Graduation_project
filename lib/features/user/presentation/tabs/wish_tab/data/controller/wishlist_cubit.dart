import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/features/user/presentation/tabs/wish_tab/data/controller/wishlist_states.dart';

import '../repo/wishlist_model.dart';
import '../repo/wishlist_repo.dart';

class WishlistCubit extends Cubit<WishlistState> {
  final WishlistRepository repository;

  // بدلاً من Set<String> استخدم List<WishlistItem>
  List<WishlistItem> _wishlistItems = [];

  WishlistCubit(this.repository) : super(WishlistInitial());

  List<WishlistItem> get wishlistItems => _wishlistItems;

  bool isFavorite(String id) => _wishlistItems.any((item) => item.id == id);

  Future<void> addToWishlist(String medicineId) async {
    try {
      emit(WishlistLoading());
      await repository.addToWishlist(medicineId);
      // ممكن تستدعي fetchWishlist بعد الإضافة عشان تحدث القائمة بالكامل
      await fetchWishlist();
      emit(WishlistSuccess());
    } catch (e) {
      emit(WishlistFailure(e.toString()));
    }
  }

  Future<void> removeFromWishlist(String medicineId) async {
    try {
      emit(WishlistLoading());
      await repository.removeFromWishlist(medicineId);
      _wishlistItems.removeWhere((item) => item.id == medicineId);
      emit(WishlistSuccess());
    } catch (e) {
      emit(WishlistFailure(e.toString()));
    }
  }

  Future<void> fetchWishlist() async {
    try {
      emit(WishlistLoading());
      final items = await repository.fetchWishlist();
      _wishlistItems = items;
      emit(WishlistSuccess());
    } catch (e) {
      emit(WishlistFailure(e.toString()));
    }
  }
}


