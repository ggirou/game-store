library game_store.activities.games;

import 'dart:html';

import 'package:game_store/web.dart';
import 'package:game_store/entity.dart';

import '../api/games_api_client.dart';

class GamesActivity implements Activity {
  Element component;

  GamesApiClient gamesApiClient;

  GamesActivity(this.component, this.gamesApiClient);
  
  start(Element e, _) {
    e.children = [component];
    document.title = "Games";
    
    gamesApiClient.all.then((List<Game> games) => component.xtag.games = games);
  }
}
