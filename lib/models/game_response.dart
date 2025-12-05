import 'dart:convert';
import 'package:the_grid/models/game.dart';

class GameResponse {
  final List<Game> results;

  GameResponse({required this.results});

  factory GameResponse.fromJson(String str) => 
      GameResponse.fromMap(json.decode(str) as Map<String, dynamic>);

  factory GameResponse.fromMap(Map<String, dynamic> json) => GameResponse(
    results: json["results"] != null 
        ? List<Game>.from(json["results"].map((x) => Game.fromJson(x))) 
        : [],
  );
}