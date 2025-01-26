class Pharmacy {
  final int id;
  final String name;
  final String imageURL;
  final String phoneNumbers;
  final String whatsUrl;
  final String location;
  final String mapsLocation;
  final String workTime;
  final List<Medicine> medicines;
  final List<Care> care;

  Pharmacy({
    required this.id,
    required this.name,
    required this.imageURL,
    required this.phoneNumbers,
    required this.whatsUrl,
    required this.location,
    required this.mapsLocation,
    required this.workTime,
    required this.medicines,
    required this.care,
  });

  factory Pharmacy.fromJson(Map<String, dynamic> json) {
    var medicinesJson = json['medicines'] as List;
    var careJson = json['care'] as List;

    return Pharmacy(
      id: json['id'],
      name: json['name'],
      imageURL: json['imageURL'],
      phoneNumbers: json['phoneNumbers'],
      whatsUrl: json['whatsUrl'],
      location: json['location'],
      mapsLocation: json['mapsLocation'],
      workTime: json['workTime'],
      medicines: medicinesJson.map((i) => Medicine.fromJson(i)).toList(),
      care: careJson.map((i) => Care.fromJson(i)).toList(),
    );
  }
}

class Medicine {
  final int id;
  final String name;
  final String imageURL;
  final double price;
  final String effectiveSubstance;
  final int count;

  Medicine({
    required this.id,
    required this.name,
    required this.imageURL,
    required this.price,
    required this.effectiveSubstance,
    required this.count,
  });

  factory Medicine.fromJson(Map<String, dynamic> json) {
    return Medicine(
      id: json['id'],
      name: json['name'],
      imageURL: json['imageURL'],
      price: json['price'].toDouble(),
      effectiveSubstance: json['effectiveSubstance'],
      count: json['count'],
    );
  }
}

class Care {
  final int id;
  final String name;
  final String imageURL;
  final double price;
  final String brand;
  final int count;

  Care({
    required this.id,
    required this.name,
    required this.imageURL,
    required this.price,
    required this.brand,
    required this.count,
  });

  factory Care.fromJson(Map<String, dynamic> json) {
    return Care(
      id: json['id'],
      name: json['name'],
      imageURL: json['imageURL'],
      price: json['price'].toDouble(),
      brand: json['brand'],
      count: json['count'],
    );
  }
}

