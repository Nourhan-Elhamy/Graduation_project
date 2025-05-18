class WishlistItem {
  final String id;
  final String name;
  final String description;
  final String price;
  final String image;

  WishlistItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
  });

  factory WishlistItem.fromJson(Map<String, dynamic> json) {
    return WishlistItem(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      image: json['image'],
    );
  }
}
