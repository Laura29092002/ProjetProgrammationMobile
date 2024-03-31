import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:projet/models/serie.dart';

Future<List<Serie>> fetchSeries(int nombresElements) async {
  final apiKey = '3319a9e5340d57520db6a482a2e8be1c966f46a7';
  final url = Uri.parse('http://comicvine.gamespot.com/api/series_list/?api_key=$apiKey&format=json&limit=$nombresElements');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    List series = json.decode(response.body)['results'];
    return series.map((serie) => Serie.fromJson(serie)).toList();
  } else {
    throw Exception('Failed to load series');
  }
}
