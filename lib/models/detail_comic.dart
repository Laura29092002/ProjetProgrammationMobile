class Person {
  final String name;
  final String role;

  Person({
    required this.name,
    required this.role
  });

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      name: json['name'] ?? 'Unknown',
      role: json['role'] ?? 'Unknown',
    );
  }
}

class CharacterName {
  final String name;

  CharacterName({required this.name,});

  factory CharacterName.fromJson(Map<String, dynamic> json) {
    return CharacterName(
      name: json['name'] ?? '',
    );
  }
}


class ComicDetail {
  final String characters;
  final String personsInfo;
  final String description;

  ComicDetail({
    required this.characters,
    required this.personsInfo,
    required this.description,
  });

  factory ComicDetail.fromJson(Map<String, dynamic> json){
    String characterNames = "";
    if (json['character_credits'] != null) {
      characterNames = json['character_credits'].map((v) => CharacterName.fromJson(v).name).join('\n ');
    }

    String personsInfo = "";

    if (json['person_credits'] != null) {
      List<String> infoList = [];
      json['person_credits'].forEach((v) {
        Person person = Person.fromJson(v);

        infoList.add("${person.name} \n ${person.role} \n");
      });

      personsInfo = infoList.join(' \n');
    }

    return ComicDetail(
      description: json['description'] ?? '',
      characters: characterNames,
      personsInfo: personsInfo,
    );
  }
}
