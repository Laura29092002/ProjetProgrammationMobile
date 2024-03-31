class CharacterName {
  final String name;

  CharacterName({required this.name,});

  factory CharacterName.fromJson(Map<String, dynamic> json) {
    return CharacterName(
      name: json['name'] ?? '',
    );
  }
}

class TeamName {
  final String name;

  TeamName({required this.name,});

  factory TeamName.fromJson(Map<String, dynamic> json) {
    return TeamName(
      name: json['name'] ?? '',
    );
  }
}

class WriterName {
  final String name;

  WriterName({required this.name,});

  factory WriterName.fromJson(Map<String, dynamic> json) {
    return WriterName(
      name: json['name'] ?? '',
    );
  }
}

class ProducerName {
  final String name;

  ProducerName({required this.name,});

  factory ProducerName.fromJson(Map<String, dynamic> json) {
    return ProducerName(
      name: json['name'] ?? '',
    );
  }
}

class StudioName {
  final String name;

  StudioName({required this.name,});

  factory StudioName.fromJson(Map<String, dynamic> json) {
    return StudioName(
      name: json['name'] ?? '',
    );
  }
}


class FilmDetail {
  final String description;
  final String personnages;
  final String rating;
  final String teams;
  final String writers;
  final String producers;
  final String studios;
  final String budget;
  final String boxOfficeRevenue;
  final String totalRevenue;


  FilmDetail({
    required this.description,
    required this.boxOfficeRevenue,
    required this.budget,
    required this.personnages,
    required this.producers,
    required this.rating,
    required this.studios,
    required this.teams,
    required this.totalRevenue,
    required this.writers,
  });

  factory FilmDetail.fromJson(Map<String, dynamic> json){
    String characterNames = "";
    if (json['characters'] != null) {
      characterNames = json['characters'].map((v) => CharacterName.fromJson(v).name).join('\n ');
    }

    String teamsNames = "";
    if (json['teams'] != null) {
      teamsNames = json['teams'].map((v) => TeamName.fromJson(v).name).join('\n ');
    }

    String writersNames = "";
    if (json['writers'] != null) {
      writersNames = json['writers'].map((v) => WriterName.fromJson(v).name).join('\n ');
    }

    String producersNames = "";
    if (json['producers'] != null) {
      producersNames = json['producers'].map((v) => ProducerName.fromJson(v).name).join('\n ');
    }

    String studiosNames = "";
    if (json['studios'] != null) {
      studiosNames = json['studios'].map((v) => StudioName.fromJson(v).name).join('\n ');
    }



    return FilmDetail(
      description: json['description'] ?? '',
      personnages: characterNames,
      rating: json['rating'] ?? '',
      teams: teamsNames,
      writers: writersNames,
      producers: producersNames,
      studios: studiosNames,
      budget: json['budget'] ?? '',
      boxOfficeRevenue: json['box_office_revenue'] ?? '',
      totalRevenue: json['total_revenue'] ?? '',

    );
  }
}
