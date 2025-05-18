class CartModel {
  final String id;
  final String userId;
  final bool isActive;
  final List<CartItem> items;
  final double totalPrice;
  final int itemCount;

  CartModel({
    required this.id,
    required this.userId,
    required this.isActive,
    required this.items,
    required this.totalPrice,
    required this.itemCount,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['cart']['id'],
      userId: json['cart']['userId'],
      isActive: json['cart']['isActive'],
      items: List<CartItem>.from(json['items'].map((item) => CartItem.fromJson(item))),
      totalPrice: double.parse(json['totalPrice']),
      itemCount: json['itemCount'],
    );
  }
}

class CartItem {
  final int quantity;
  final Medicine medicine;

  CartItem({
    required this.quantity,
    required this.medicine,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      quantity: json['quantity'],
      medicine: Medicine.fromJson(json['medicine']),
    );
  }
}

class Medicine {
  final String id;
  final String name;
  final String description;
  final String price;
  final String image;

  Medicine({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
  });

  factory Medicine.fromJson(Map<String, dynamic> json) {
    return Medicine(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      image: json['image'],
    );
  }
}