import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:projet/models/actualité.dart';


Future<List<Article>> fetchArticles(int nombresElements) async {
  final apiKey = '3319a9e5340d57520db6a482a2e8be1c966f46a7';
  final url = Uri.parse('http://www.gamespot.com/api/articles/?api_key=$apiKey&format=json&limit=$nombresElements');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    List articles = json.decode(response.body)['results'];
    return articles.map((article) => Article.fromJson(article)).toList();
  } else {
    throw Exception('Failed to load characters');
  }
}