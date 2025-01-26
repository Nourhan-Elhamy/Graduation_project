class Article {
  final String name;
  final String description;

  Article({required this.name, required this.description});

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      name: json['name'],
      description: json['description'],
    );
  }
}
