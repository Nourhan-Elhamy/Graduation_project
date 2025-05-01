class Catum {
  final String? id;
  final String? name;
  final String? description;
  final String? price;
  final String? image;
  final String? substance;
  final dynamic categoryId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Catum({
    this.id,
    this.name,
    this.description,
    this.price,
    this.image,
    this.substance,
    this.categoryId,
    this.createdAt,
    this.updatedAt,
  });

  factory Catum.fromJson(Map<String, dynamic> json) => Catum(
        id: json['id'] as String?,
        name: json['name'] as String?,
        description: json['description'] as String?,
        price: json['price'] as String?,
        image: json['image'] as String?,
        substance: json['substance'] as String?,
        categoryId: json['categoryId'] as dynamic,
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt'] as String),
        updatedAt: json['updatedAt'] == null
            ? null
            : DateTime.parse(json['updatedAt'] as String),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'price': price,
        'image': image,
        'substance': substance,
        'categoryId': categoryId,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
      };
}
