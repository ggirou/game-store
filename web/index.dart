import 'package:route/client.dart';

final homeUrl = new UrlPattern(r'/(.*)#/welcome');
final gamesUrl = new UrlPattern(r'/(.*)#/games');
final gameUrl = new UrlPattern(r'/(.*)#/game/(\d+)');
final allUrls = [homeUrl, gamesUrl, gameUrl];

void main() {
  var router = new Router()
    ..addHandler(homeUrl, printIt("Home"))
    ..addHandler(gamesUrl, printIt("Games"))
    ..addHandler(gameUrl, showGame)
    ..listen();
}

void showGame(String path) {
  var articleId = gameUrl.parse(path)[1];
  // show article page with loading indicator
  // load article from server, then render article
  print("Game $articleId");
}

printIt(value) => (_) => print(value);
