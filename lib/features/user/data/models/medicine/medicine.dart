class Medicine {
  int? id;
  String? name;
  String? imageUrl;
  int? price;
  String? effectiveSubstance;
  int? count;

  Medicine({
    this.id,
    this.name,
    this.imageUrl,
    this.price,
    this.effectiveSubstance,
    this.count,
  });

  factory Medicine.fromJson(Map<String, dynamic> json) => Medicine(
        id: json['id'] as int?,
        name: json['name'] as String?,
        imageUrl: json['imageURL'] as String? ?? '',
        price: json['price'] as int?,
        effectiveSubstance: json['effectiveSubstance'] as String?,
        count: json['count'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'imageURL': imageUrl,
        'price': price,
        'effectiveSubstance': effectiveSubstance,
        'count': count,
      };
}
