library game_store.activities.games;

import 'dart:html';

import 'package:polymer/polymer.dart';
import 'package:game_store/web.dart';
import 'package:game_store/entity.dart';

import '../api/games_api_client.dart';

@CustomTag('games-activity')
class GamesActivity extends CustomPolymerElement with ObservableMixin implements Activity {
  bool get applyAuthorStyles => true;

  Element get gamesComponent => getShadowRoot('games-activity').query("#games");

  GamesApiClient gamesApiClient;

  void created() {
    super.created();
    
    gamesComponent.on['add-game'].listen((CustomEvent e) => print('Received addGame Event ${e.detail}'));
  }
  
  start(Element e, _) {
    e.children = [host];
    document.title = "Games";
    
    gamesApiClient.all.then((List<Game> games) => gamesComponent.xtag.games = games);
  }
}
