class Serie {
  final String name;
  final String imageUrl;
  final String countOfEpisodes;
  final String publisherName;
  final String startYear;
  final String apiDetailUrl;

  Serie({
    required this.name,
    required this.imageUrl,
    required this.countOfEpisodes,
    required this.publisherName,
    required this.startYear,
    required this.apiDetailUrl,
  });

  factory Serie.fromJson(Map<String, dynamic> json) {
    return Serie(
      name: json['name'] ?? 'Unknown',
      imageUrl: json['image'] != null ? json['image']['original_url'] ?? '' : '',
      countOfEpisodes: json['count_of_episodes'].toString() ?? 'Unknown',
      publisherName: json['publisher'] != null ? json['publisher']['name'] ?? 'Unknown Publisher' : 'Unknown Publisher',
      startYear: json['start_year'] ?? 'Unknown Year',
      apiDetailUrl: json['api_detail_url'] ?? '',
    );
  }
}