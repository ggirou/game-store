library game_store;

import 'package:mdv/mdv.dart' as mdv;
import 'package:route/client.dart';
import 'dart:html';

final homeUrl = new UrlPattern(r'/(.*)#/welcome');
final gamesUrl = new UrlPattern(r'/(.*)#/games');
final myGamesUrl = new UrlPattern(r'/(.*)#/mygames');
final gameUrl = new UrlPattern(r'/(.*)#/game/(\d+)');

void main() {
  mdv.initialize();

  var router = new Router()
    ..addHandler(homeUrl, routeChanged(homeUrl, "Home", "game.html", "x-game"))
    ..addHandler(gamesUrl, routeChanged(gamesUrl, "Games", "games.html", "x-games"))
    ..addHandler(myGamesUrl, routeChanged(myGamesUrl, "My Games", "game.html", "x-game"))
    ..addHandler(gameUrl, routeChanged(gameUrl, "Game", "game.html", "x-game"))
    ..listen();
  
  try {
    router.handle("${window.location.pathname}${window.location.hash}");
  } on ArgumentError catch(e) {
    router.gotoPath("${window.location.pathname}#/welcome", "");
  }
}

routeChanged(UrlPattern pattern, String title, String componentPath, String componentName) => (path) {
  var pageContainer = query('#container').xtag;
  pageContainer.componentPath = componentPath;
  pageContainer.componentName = componentName;
  document.title = title;
  return print("Changed page container for $title");
};
