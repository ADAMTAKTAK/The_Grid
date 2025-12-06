import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:the_grid/models/models.dart';

class GamesProvider extends ChangeNotifier {
  
  final String _baseUrl = 'api.rawg.io';
  final String _apiKey = '4d9afe5126254639808570016f0c869b';

  List<Game> onDisplayGames = [];
  List<Game> popularGames = [];
  
  int _popularPage = 0;

  GamesProvider() {
    getOnDisplayGames();
    getPopularGames();
  }

  Future<String> _getJsonData(String endpoint, [int? page]) async {
    final Map<String, dynamic> params = {'key': _apiKey, 'page_size': '20'};
    if (page != null) {
      params['page'] = '$page';
    }

    final url = Uri.https(_baseUrl, endpoint, params);
    final response = await http.get(url);
    return response.body;
  }

  Future<void> getOnDisplayGames() async {
    final jsonData = await _getJsonData('/api/games');
    final gameResponse = GameResponse.fromJson(jsonData);
    
    onDisplayGames = gameResponse.results
        .where((game) => game.backgroundImage != null)
        .toList();
        
    notifyListeners();
  }

  Future<void> getPopularGames() async {
    _popularPage++;
    
    final jsonData = await _getJsonData('/api/games', _popularPage);
    final gameResponse = GameResponse.fromJson(jsonData);

    popularGames = [...popularGames, ...gameResponse.results];
    notifyListeners();
  }

  Future<Game> getGameDetails(int id) async {
    final jsonData = await _getJsonData('/api/games/$id');
    return Game.fromJson(json.decode(jsonData));
  }

  Future<List<Game>> searchGames(String query) async {
    final url = Uri.https(_baseUrl, '/api/games', {
      'key': _apiKey,
      'search': query,
    });

    final response = await http.get(url);
    final gameResponse = GameResponse.fromJson(response.body);
    
    return gameResponse.results
        .where((game) => game.backgroundImage != null)
        .toList();
  }
}