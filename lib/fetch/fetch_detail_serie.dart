import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:projet/models/detail_serie.dart';

Future<SerieDetail> fetchSerieDetail(String apiDetailUrl) async {
  final apiKey = '3319a9e5340d57520db6a482a2e8be1c966f46a7';
  final url = Uri.parse('$apiDetailUrl?api_key=$apiKey&format=json');
  final response = await http.get(url);
  print('Response body: ${response.body}');

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);
    final serieData = data['results'];
    return SerieDetail.fromJson(serieData);
  } else {
    throw Exception('Failed to load comic details');
  }
}

Future<Episode> fetchEpisodeDetail(String episodeUrl) async {
  final apiKey = '3319a9e5340d57520db6a482a2e8be1c966f46a7';
  final url = Uri.parse('$episodeUrl?api_key=$apiKey&format=json');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body)['results'];
    return Episode.fromJson(data);
  } else {
    throw Exception('Failed to load episode details');
  }
}

Future<List<Episode>> fetchAllEpisodes(List<String> episodeUrls) async {
  // Prendre seulement les 5 premières URLs d'épisodes pour réduire le nombre de requêtes
  var firstFiveUrls = episodeUrls.take(5).toList();

  return Future.wait(firstFiveUrls.map(fetchEpisodeDetail));
}