import 'package:intl/intl.dart';


class Film {
  final String name;
  final String imageUrl;
  String dateAdded;
  final String runTime;
  final String apiDetailUrl;

  Film({
    required this.name,
    required this.imageUrl,
    required this.dateAdded,
    required this.runTime,
    required this.apiDetailUrl,
  }){
    this.dateAdded = _formatDate(dateAdded);
  }

  static String _formatDate(String date) {
    try {
      final DateTime parsedDate = DateFormat('yyyy-MM-dd').parse(date);
      return DateFormat('y').format(parsedDate);
    } catch (e) {
      return date;
    }
  }

  factory Film.fromJson(Map<String, dynamic> json) {
    return Film(
      name: json['name'] ?? 'Unknown',
      imageUrl: json['image']['original_url'] ?? '',
      dateAdded: json['date_added'] ?? 'Not Available',
      runTime: json['runtime'].toString() ?? 'Unknown',
      apiDetailUrl: json['api_detail_url'] ?? '',
    );
  }
}