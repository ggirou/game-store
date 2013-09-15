library game_store.components.game.games;

import 'dart:html';

import 'package:polymer/polymer.dart';
import 'package:game_store/entity.dart';
import 'package:game_store/web.dart';

@CustomTag('x-games')
class XGames extends CustomPolymerElement with ObservableMixin {
  bool get applyAuthorStyles => true;

  List<Game> _games = toObservable([]);

  List<Game> get games => _games; 
  set games(List<Game> values) => _games..clear()..addAll(values); 
  
  void addGame(Event e, var detail, Element target) {
    var game = target.attributes['data'];
    print("Click on addGame $game");

    dispatchEvent(new CustomEvent("add-game", detail: game));
  }
}
