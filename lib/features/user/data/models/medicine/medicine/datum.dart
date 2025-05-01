class Datum {
  final String? id;
  final String? name;
  final String? description;
  final String? price;
  final String? image;
  final String? substance;
  final int? categoryId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Datum({
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

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json['id'] as String?,
        name: json['name'] as String?,
        description: json['description'] as String?,
        price: json['price'] as String?,
        image: json['image'] as String?,
        substance: json['substance'] as String?,
        categoryId: json['categoryId'] is int
            ? json['categoryId'] as int
            : int.tryParse(json['categoryId']?.toString() ?? ''),
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.tryParse(json['createdAt']),
        updatedAt: json['updatedAt'] == null
            ? null
            : DateTime.tryParse(json['updatedAt']),
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
