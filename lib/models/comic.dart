import 'package:intl/intl.dart';


class Comic {
  final String name;
  final String issueNumber;
  final String imageUrl;
  String coverDate;
  final String apiDetailUrl;

  Comic({
    required this.name,
    required this.issueNumber,
    required this.imageUrl,
    required this.coverDate,
    required this.apiDetailUrl,
  }) {
    this.coverDate = _formatDate(coverDate);
  }


  static String _formatDate(String date) {
    try {
      final DateTime parsedDate = DateFormat('yyyy-MM-dd').parse(date);
      return DateFormat('yMMMM').format(parsedDate);
    } catch (e) {
      return date;
    }
  }

  factory Comic.fromJson(Map<String, dynamic> json) {
    return Comic(
      name: json['volume']['name'] ?? 'Unknown',
      issueNumber: json['issue_number'] ?? 'N/A',
      imageUrl: json['image']['original_url'] ?? '',
      coverDate: json['cover_date'] ?? 'Not Available',
      apiDetailUrl: json['api_detail_url'] ?? '',
    );
  }
}