import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:projet/models/detail_film.dart';

Future<FilmDetail> fetchFilmDetail(String apiDetailUrl) async {
  final apiKey = '3319a9e5340d57520db6a482a2e8be1c966f46a7';
  final url = Uri.parse('$apiDetailUrl?api_key=$apiKey&format=json');
  final response = await http.get(url);
  print('Response body: ${response.body}');

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);
    final filmData = data['results'];
    return FilmDetail.fromJson(filmData);
  } else {
    throw Exception('Failed to load comic details');
  }
}