class Creator {
  final String name;

  Creator({required this.name, });

  factory Creator.fromJson(Map<String, dynamic> json) {
    return Creator(
      name: json['name'] ?? 'Unknown',
    );
  }
}

class CharacterDetail {
  final String name;
  final String realName;
  final String imageUrl;
  final String aliases;
  final String publisher;
  final String creators;
  final String gender;
  final String? birth;
  final String description;

  CharacterDetail({
    required this.name,
    required this.imageUrl,
    required this.realName,
    required this.aliases,
    required this.publisher,
    required this.creators,
    required this.gender,
    this.birth,
    required this.description,


  });

  factory CharacterDetail.fromJson(Map<String, dynamic> json) {

    String creatorsNames = "";

    if (json['creators'] != null) {

      creatorsNames = json['creators'].map((v) => Creator.fromJson(v).name).join(', ');
    }


    return CharacterDetail(
      name: json['name'] ?? 'Unknown',
      imageUrl: json['image']?['original_url'] ?? '',
      realName: json['real_name'] ?? 'Unknown',
      aliases: json['aliases'] ?? 'None',
      publisher: json['publisher']['name'] ?? 'Unknown',
      creators: creatorsNames,
      birth: json['birth'], // birth peut être null, donc pas besoin de ?? 'Unknown'
      gender: json['gender'] == 1 ? 'Male' : 'Female',
      description: json['description'] ?? '',

    );
  }
}
