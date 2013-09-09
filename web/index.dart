library game_store;

import 'dart:html';
import 'package:mdv/mdv.dart' as mdv;
import 'package:route/client.dart';
import 'package:dado/dado.dart';
import 'package:game_store/web.dart';

import 'activities/activities.dart';
import 'ioc/game_store_module.dart';

final homeUrl = new UrlPattern(r'/(.*)#/welcome');
final gamesUrl = new UrlPattern(r'/(.*)#/games');
final myGamesUrl = new UrlPattern(r'/(.*)#/mygames');
final gameUrl = new UrlPattern(r'/(.*)#/game/(\d+)');

final injector = new Injector([GameStoreModule]);

void main() {
  mdv.initialize();

  var router = new Router()
    ..addHandler(homeUrl, routeChanged(homeUrl, GameActivity))
    ..addHandler(gamesUrl, routeChanged(gamesUrl, GamesActivity))
    ..addHandler(myGamesUrl, routeChanged(myGamesUrl, GameActivity))
    ..addHandler(gameUrl, routeChanged(gameUrl, GameActivity))
    ..listen();
  
  try {
    router.handle("${window.location.pathname}${window.location.hash}");
  } on ArgumentError catch(e) {
    router.gotoPath("${window.location.pathname}#/welcome", "");
  }
}

routeChanged(UrlPattern pattern, Type type) => (path) {
  Activity activity = injector.getInstanceOf(type);
  activity.start(query('#container'));
  
  return print("Changed page container for $type");
};

