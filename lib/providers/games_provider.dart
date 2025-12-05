import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:the_grid/models/models.dart';

class GamesProvider extends ChangeNotifier {
  
  final String _baseUrl = 'api.rawg.io';
  final String _apiKey = '4d9afe5126254639808570016f0c869b';

  List<Game> onDisplayGames = [];
  List<Game> popularGames = [];
  
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
    onDisplayGames = gameResponse.results;
    notifyListeners();
  }

  Future<void> getPopularGames() async {
    final jsonData = await _getJsonData('/api/games', 2);
    final gameResponse = GameResponse.fromJson(jsonData);
    popularGames = gameResponse.results;
    notifyListeners();
  }
}