library game_store;

import 'dart:html';
import 'package:mdv/mdv.dart' as mdv;
import 'package:route/client.dart';
import 'package:dado/dado.dart';
import 'package:game_store/web.dart';

import 'ioc/game_store_module.dart';
import 'activities/game.dart';
import 'activities/games.dart';
import 'activities/grid.dart';

final homeUrl = new UrlPattern(r'/(.*)#/welcome');
final gamesUrl = new UrlPattern(r'/(.*)#/games');
final myBucketUrl = new UrlPattern(r'/(.*)#/mybucket');
final myGamesUrl = new UrlPattern(r'/(.*)#/mygames');
final gameUrl = new UrlPattern(r'/(.*)#/games/(\d+)');
final gridUrl = new UrlPattern(r'/(.*)#/grid');

final injector = new Injector([GameStoreModule]);

void main() {
  mdv.initialize();

  var router = new Router()
    ..addHandler(homeUrl, routeChanged(GameActivity, (_) => 1))
    ..addHandler(gamesUrl, routeChanged(GamesActivity, (_) => null))
    ..addHandler(myBucketUrl, routeChanged(GamesActivity, (_) => null))
    ..addHandler(myGamesUrl, routeChanged(GameActivity, (_) => 1))
    ..addHandler(gameUrl, routeChanged(GameActivity, (path) => int.parse(gameUrl.parse(path)[1])))
    ..addHandler(gridUrl, routeChanged(GridActivity, (_) => 1))
    ..listen();
  
  try {
    router.handle("${window.location.pathname}${window.location.hash}");
  } on ArgumentError catch(e) {
    router.gotoPath("${window.location.pathname}#/welcome", "");
  }
}

routeChanged(Type type, placeParser(_path)) => (path) {
  var place = placeParser(path);

  Activity activity = injector.getInstanceOf(type);
  activity.start(query('#container'), place);
  
  return print("Changed page container for $type($place)");
};

