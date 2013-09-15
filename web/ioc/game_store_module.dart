library game_store.ioc.game_store_module;

import 'dart:html';

import 'package:dado/dado.dart';
import 'package:polymer/polymer.dart';

import 'package:game_store/web.dart';

import '../api/games_api_client.dart';
import '../activities/game.dart';
import '../activities/games.dart';
import '../activities/grid.dart';

const gameActivity = const ComponentRef("activities/game.html", "game-activity");
const gamesActivity = const ComponentRef("activities/games.html", "games-activity");
const gridActivity = const ComponentRef("activities/grid.html", "grid-activity");

class GameStoreModule extends Module {
  // TODO: use parameters injection instead, when reflection on parameter metadata will work
  GameActivity newGameActivity() => bindTo(GamesActivity)
      .providedBy(() => _createComponent(gameActivity).xtag..gamesApiClient = newGamesApiClient()).newInstance();
  GamesActivity newGamesActivity() => bindTo(GamesActivity)
      .providedBy(() => _createComponent(gamesActivity).xtag..gamesApiClient = newGamesApiClient()).newInstance();
  GridActivity newGridActivity() => bindTo(GridActivity)
      .providedBy(() => _createComponent(gridActivity).xtag).newInstance();

  GamesApiClient newGamesApiClient() => bindTo(GamesApiClient).providedBy(() => new GamesApiClient()).newInstance();
}

final globals = {
  'uppercase': (String v) => v.toUpperCase(),
};

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