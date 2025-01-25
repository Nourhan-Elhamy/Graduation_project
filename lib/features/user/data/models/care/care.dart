class Care {
  int? id;
  String? name;
  String? imageUrl;
  int? price;
  String? brand;
  int? count;

  Care({
    this.id,
    this.name,
    this.imageUrl,
    this.price,
    this.brand,
    this.count,
  });

  factory Care.fromJson(Map<String, dynamic> json) => Care(
        id: json['id'] as int?,
        name: json['name'] as String?,
        imageUrl: json['imageURL'] as String?,
        price: json['price'] as int?,
        brand: json['brand'] as String?,
        count: json['count'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'imageURL': imageUrl,
        'price': price,
        'brand': brand,
        'count': count,
      };
}
