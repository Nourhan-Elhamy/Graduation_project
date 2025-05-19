abstract class WishlistState {}

class WishlistInitial extends WishlistState {}

class WishlistLoading extends WishlistState {}

class WishlistSuccess extends WishlistState {}

class WishlistFailure extends WishlistState {
  final String error;
  WishlistFailure(this.error);
}
