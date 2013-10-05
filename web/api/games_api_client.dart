library game_store.api.games_api_client;

import 'dart:html';
import 'dart:async';
import 'dart:convert';

import 'package:game_store/entity.dart';

var toto;

Game _mapToGame(Map m) => new Game()
    ..id = m["id"]
    ..name = m["name"]
    ..genre = m["genre"]
    ..image = m["image"]
    ..players = m["players"]
    ..description = m["description"];

class GamesApiClient {
  String rootUrl = ".";
  
  Future<List<Game>> get all => HttpRequest.getString("$rootUrl/api/games.json")
      .then(JSON.decode)
      .then((List<Map> games) => games.map(_mapToGame).toList());
  
  Future<Game> getById(int id) => HttpRequest.getString("$rootUrl/api/games/$id.json")
      .then(JSON.decode)
      .then(_mapToGame)
      .catchError((e) => null, test: (e) => e is ProgressEvent && e.target.status == 404);
}