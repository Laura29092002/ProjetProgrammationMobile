import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  Future<Map<String, dynamic>> searchComicVine(String searchTerm) async {
    final apiKey = '3319a9e5340d57520db6a482a2e8be1c966f46a7';
    final responses = await Future.wait([
      http.get(Uri.parse('https://comicvine.gamespot.com/api/movies/?api_key=$apiKey&format=json&filter=name:$searchTerm')),
      http.get(Uri.parse('https://comicvine.gamespot.com/api/series_list/?api_key=$apiKey&format=json&filter=name:$searchTerm')),
      http.get(Uri.parse('https://comicvine.gamespot.com/api/issues/?api_key=$apiKey&format=json&filter=name:$searchTerm')),
      http.get(Uri.parse('https://comicvine.gamespot.com/api/characters/?api_key=$apiKey&format=json&filter=name:$searchTerm')),
    ]);

    final movieResults = json.decode(responses[0].body)['results'];
    final seriesResults = json.decode(responses[1].body)['results'];
    final comicsResults = json.decode(responses[2].body)['results'];
    final charactersResults = json.decode(responses[3].body)['results'];

    return {
      'movies': movieResults,
      'series': seriesResults,
      'comics': comicsResults,
      'characters': charactersResults,
    };
  }
}
