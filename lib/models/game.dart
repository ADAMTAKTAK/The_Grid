class Game {
  final int id;
  final String name;
  final String? backgroundImage;
  final double rating;
  final String? released;
  final String? descriptionRaw; 
  final List<String>? developers; 
  
  String? heroId;

  Game({
    required this.id,
    required this.name,
    this.backgroundImage,
    required this.rating,
    this.released,
    this.descriptionRaw,
    this.developers,
    this.heroId,
  });

  String get fullBackgroundImage {
    if (backgroundImage != null) return backgroundImage!;
    return 'https://i.imgur.com/27x2753.png'; 
  }

  factory Game.fromJson(Map<String, dynamic> json) => Game(
    id: (json["id"] as int?) ?? 0,
    name: json["name"] ?? 'Unknown Title',
    backgroundImage: json["background_image"],
    rating: (json["rating"] as num?)?.toDouble() ?? 0.0, 
    released: json["released"],
    descriptionRaw: json["description_raw"],
    developers: json["developers"] != null 
      ? List<String>.from(json["developers"].map((x) => x["name"])) 
      : [],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "background_image": backgroundImage,
    "rating": rating,
    "released": released,
    "description_raw": descriptionRaw,
  };
}