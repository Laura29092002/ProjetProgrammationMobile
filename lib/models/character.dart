class Character {
  final String name;
  final String imageUrl;
  final String apiDetailUrl;

  Character({
    required this.name,
    required this.imageUrl,
    required this.apiDetailUrl,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      name: json['name'] ?? 'Unknown',
      imageUrl: json['image']?['original_url'] ?? '', // Utilisation de ? pour gérer le cas où 'image' serait null
      apiDetailUrl: json['api_detail_url'] ?? '',
    );
  }
}