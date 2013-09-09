library game_store.ioc.game_store_module;

import 'dart:html';

import 'package:dado/dado.dart';
import 'package:polymer/polymer.dart';

import 'package:game_store/web.dart';

import '../activities/activities.dart';

const gameComponent = const ComponentRef("components/game/game.html", "x-game");
const gamesComponent = const ComponentRef("components/game/games.html", "x-games");

class GameStoreModule extends Module {
  GameActivity newGameActivity() => bindTo(GameActivity).providedBy(() => new GameActivity(newXGame())).newInstance();
  GamesActivity newGamesActivity() => bindTo(GamesActivity).providedBy(() => new GamesActivity(newXGames())).newInstance();

  Element newXGame() => bindTo(Element, annotatedWith: gameComponent).providedBy(() => _createComponent(gameComponent)).newInstance();
  Element newXGames() => bindTo(Element, annotatedWith: gamesComponent).providedBy(() => _createComponent(gamesComponent)).newInstance();
}

_createComponent(ComponentRef componentRef) {
  var link = document.head.children.firstWhere((e) => e is LinkElement
      && e.attributes['rel'] == 'import'
      && e.attributes['href'] == componentRef.htmlUrl, orElse: () => null);

  if(link == null) {
    link = new LinkElement()
        ..attributes['rel'] = 'import'
        ..attributes['href'] = componentRef.htmlUrl;
    document.head.children.add(link);
  }
  
  return createElement(componentRef.tagName);
}