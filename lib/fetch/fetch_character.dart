import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:projet/models/character.dart';


Future<List<Character>> fetchCharacters(int nombresElements) async {
  final apiKey = '3319a9e5340d57520db6a482a2e8be1c966f46a7';
  final url = Uri.parse('http://comicvine.gamespot.com/api/characters/?api_key=$apiKey&format=json&limit=$nombresElements');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    List characters = json.decode(response.body)['results'];
    return characters.map((character) => Character.fromJson(character)).toList();
  } else {
    throw Exception('Failed to load characters');
  }
}