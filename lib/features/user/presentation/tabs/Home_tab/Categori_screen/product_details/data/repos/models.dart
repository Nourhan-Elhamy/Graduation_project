class ProductDetails {
  final String id;
  final String name;
  final String description;
  final String price;
  final String image;
  final String substance;
  final String category;

  ProductDetails({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    required this.substance,
    required this.category,
  });

  factory ProductDetails.fromJson(Map<String, dynamic> json) {
    return ProductDetails(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      image: json['image'],
      substance: json['substance'],
      category: json['category'],
    );
  }
}
