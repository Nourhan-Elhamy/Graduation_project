class CartItemModel {
  final String cartId;
  final String medicineId;
  final int quantity;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? message; // أضفنا الرسالة هنا

  CartItemModel({
    required this.cartId,
    required this.medicineId,
    required this.quantity,
    required this.createdAt,
    required this.updatedAt,
    this.message,

  });

  factory CartItemModel.fromJson(Map<String, dynamic> json,{String? message}) {
    return CartItemModel(
      cartId: json['cartId'],
      medicineId: json['medicineId'],
      quantity: json['quantity'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      message: message,

    );
  }}