library game_store.activities.game;

import 'dart:html';

import 'package:game_store/web.dart';
import 'package:game_store/entity.dart';

import '../api/games_api_client.dart';

class GameActivity implements Activity {
  Element component;
  
  GamesApiClient gamesApiClient;
 
  GameActivity(this.component, this.gamesApiClient);
  
  start(Element e, int gameId) {
    e.children = [component];
    document.title = "Game";
    
    gamesApiClient.getById(gameId).then((Game game) {
      document.title = game == null ? "No game" : game.name;
      
      component.xtag.game = game;
    });
  }
}
