library game_store.activities.game;

import 'dart:html';

import 'package:polymer/polymer.dart';
import 'package:game_store/web.dart';
import 'package:game_store/entity.dart';

import '../api/games_api_client.dart';

@CustomTag('game-activity')
class GameActivity extends CustomPolymerElement with ObservableMixin implements Activity {
  bool get applyAuthorStyles => true;

  GamesApiClient gamesApiClient;

  @observable Game game;

  start(Element e, int gameId) {
    e.children = [host];
    
    gamesApiClient.getById(gameId).then((Game game) {
      document.title = game == null ? "Unknown game" : game.name;
      this.game = game;
    });
  }
}
