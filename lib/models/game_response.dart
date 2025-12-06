import 'dart:convert';
import 'package:the_grid/models/game.dart';

class GameResponse {
  final int count;
  final String? next;
  final String? previous;
  final List<Game> results;

  GameResponse({
    required this.count,
    this.next,
    this.previous,
    required this.results,
  });

  factory GameResponse.fromJson(String str) => 
      GameResponse.fromMap(json.decode(str) as Map<String, dynamic>);

  factory GameResponse.fromMap(Map<String, dynamic> json) => GameResponse(
    count: (json["count"] as int?) ?? 0,
    next: json["next"],
    previous: json["previous"],
    results: json["results"] != null 
        ? List<Game>.from(json["results"].map((x) => Game.fromJson(x))) 
        : [],
  );
}