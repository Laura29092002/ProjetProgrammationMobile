import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:projet/models/detail_character.dart';

Future<CharacterDetail> fetchCharacterDetail(String apiDetailUrl) async {
  final apiKey = '3319a9e5340d57520db6a482a2e8be1c966f46a7';
  final url = Uri.parse('$apiDetailUrl?api_key=$apiKey&format=json');
  final response = await http.get(url);
  print('Response body: ${response.body}');

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);
    final characterData = data['results'];
    return CharacterDetail.fromJson(characterData);
  } else {
    throw Exception('Failed to load character details');
  }
}