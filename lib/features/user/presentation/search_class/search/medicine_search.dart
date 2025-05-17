class MedicineSearch {
  final String? id;
  final String? name;
  final String? image;

  const MedicineSearch({this.id, this.name, this.image});

  factory MedicineSearch.fromJson(Map<String, dynamic> json) => MedicineSearch(
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
