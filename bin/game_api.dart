library game_store.server.game_api;

import 'dart:async';
import 'dart:io';
import 'dart:convert';

List<Map> _games = [];

Future loadGames(String webPath) {
  return new File(webPath + "/api/games.json").readAsString()
    .then(JSON.decode).then(_games.addAll);
}

Future<List<Map>> get all => new Future.value(_games);
Future<Map> getById(int id) => new Future(() =>_games.firstWhere((game) => game["id"] == id, orElse: () => null));