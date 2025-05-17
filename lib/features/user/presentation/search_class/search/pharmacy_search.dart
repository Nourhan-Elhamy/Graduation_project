class PharmacySearch {
  final String? id;
  final String? name;
  final String? image;

  const PharmacySearch({this.id, this.name, this.image});

  factory PharmacySearch.fromJson(Map<String, dynamic> json) => PharmacySearch(
        id: json['id'] as String?,
        name: json['name'] as String?,
        image: json['image'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'image': image,
      };
}
