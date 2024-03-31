import 'package:intl/intl.dart';

class CharacterName {
  final String name;

  CharacterName({required this.name,});

  factory CharacterName.fromJson(Map<String, dynamic> json) {
    return CharacterName(
      name: json['name'] ?? '',
    );
  }
}

class Episode {
  final String episodeNumber;
  final String name;
  String airDate;
  final String imageUrl;

  Episode({
    required this.episodeNumber,
    required this.airDate,
    required this.imageUrl,
    required this.name,
  }){
    this.airDate = _formatDate(airDate);
  }

  static String _formatDate(String date) {
    try {
      final DateTime parsedDate = DateFormat('yyyy-MM-dd').parse(date);
      return DateFormat('yMMMMd').format(parsedDate);
    } catch (e) {
      return date;
    }
  }

  factory Episode.fromJson(Map<String, dynamic> json) {
    return Episode(
      episodeNumber: json['episode_number'].toString(),
      airDate: json['air_date'] ?? '',
      imageUrl: json['image'] != null ? json['image']['original_url'] ?? '' : '',
      name: json['name'] ?? '',
    );
  }
}


class EpisodeUrl {
  final String url;

  EpisodeUrl({required this.url,});

  factory EpisodeUrl.fromJson(Map<String, dynamic> json) {
    return EpisodeUrl(
      url: json['api_detail_url'] ?? '',
    );
  }
}


class SerieDetail {
  final String characters;
  final List<String> episodeUrls;
  final String description;

  SerieDetail({
    required this.characters,
    required this.episodeUrls,
    required this.description,
  });

  factory SerieDetail.fromJson(Map<String, dynamic> json) {
    String characterNames = "";
    if (json['characters'] != null) {
      characterNames = json['characters'].map((v) => CharacterName.fromJson(v).name).join('\n ');
    }

    // Extraction des URLs d'épisodes
    List<String> episodeUrls = [];
    if (json['episodes'] != null) {
      json['episodes'].forEach((v) {
        EpisodeUrl episodeUrl = EpisodeUrl.fromJson(v);
        episodeUrls.add(episodeUrl.url);
      });
    }

    return SerieDetail(
      description: json['description'] ?? '',
      characters: characterNames,
      episodeUrls: episodeUrls,
    );
  }
}