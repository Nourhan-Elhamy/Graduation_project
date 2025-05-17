class Pharmacy {
  final String id;
  final String name;
  final String description;
  final String address;
  final String phone;
  final String email;
  final String image;
  final bool isActive;
  final String? ownerId;
  final String createdAt;
  final String updatedAt;

  Pharmacy({
    required this.id,
    required this.name,
    required this.description,
    required this.address,
    required this.phone,
    required this.email,
    required this.image,
    required this.isActive,
    this.ownerId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Pharmacy.fromJson(Map<String, dynamic> json) {
    return Pharmacy(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      address: json['address']?.toString() ?? '',
      phone: json['phone']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      image: json['image']?.toString() ?? '',
      isActive: json['isActive'] ?? false,
      ownerId: json['ownerId']?.toString(),
      createdAt: json['createdAt']?.toString() ?? '',
      updatedAt: json['updatedAt']?.toString() ?? '',
    );
  }
}