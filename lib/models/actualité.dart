class Article {
  final String title;
  final String imageUrl;
  final String siteDetailUrl;

  Article({
    required this.title,
    required this.imageUrl,
    required this.siteDetailUrl,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'] ?? 'Unknown',
      imageUrl: json['image']['original'] ?? '',
      siteDetailUrl: json['site_detail_url'] ?? '',
    );
  }
}