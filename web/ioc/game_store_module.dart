library game_store.ioc.game_store_module;

import 'dart:html';

import 'package:dado/dado.dart';
import 'package:polymer/polymer.dart';

import 'package:game_store/web.dart';

import '../activities/game.dart';
import '../activities/games.dart';
import '../api/games_api_client.dart';

const gameComponent = const ComponentRef("components/game/game.html", "x-game");
const gamesComponent = const ComponentRef("components/game/games.html", "x-games");

class GameStoreModule extends Module {
  // TODO: use parameters injection instead when reflection on parameter metadata will work
  GameActivity newGameActivity() => bindTo(GameActivity).providedBy(() => new GameActivity(newXGame(), newGamesApiClient())).newInstance();
  GamesActivity newGamesActivity() => bindTo(GamesActivity).providedBy(() => new GamesActivity(newXGames())).newInstance();

  Element newXGame() => bindTo(Element, annotatedWith: gameComponent).providedBy(() => _createComponent(gameComponent)).newInstance();
  Element newXGames() => bindTo(Element, annotatedWith: gamesComponent).providedBy(() => _createComponent(gamesComponent)).newInstance();

  GamesApiClient newGamesApiClient() => bindTo(GamesApiClient).providedBy(() => new GamesApiClient()).newInstance();
}

_createComponent(ComponentRef componentRef) {
  var link = document.head.children.firstWhere((e) => e is LinkElement
      && e.attributes['rel'] == 'import'
      && e.attributes['href'] == componentRef.htmlUrl, orElse: () => null);

  // Add link for the keysets if missing from the document. Force a layout change after resolving the import of the link.
  if(link == null) {
    //  // Layout has not beeen loaded yet.
    link = new LinkElement()
        ..attributes['rel'] = 'import'
        ..attributes['href'] = componentRef.htmlUrl;
    document.head.children.add(link);
  
    // TODO: See equivalent issue https://code.google.com/p/chromium/issues/detail?id=260278
    //  // Load content for the new link element.
    //  var self = this;
    //  HTMLImports.importer.load(document, function() {
    //    HTMLImports.parser.parseLink(link);
    //    self.layoutChanged();
    //  });
  }

  return createElement(componentRef.tagName);
}