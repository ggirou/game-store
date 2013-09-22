library game_store.activities.grid;

import 'dart:html';

import 'package:polymer/polymer.dart';

import 'package:game_store/web.dart';

@CustomTag('grid-activity')
class GridActivity extends CustomPolymerElement with ObservableMixin implements Activity {
  bool get applyAuthorStyles => true;

  @observable List _columns = toObservable(["fruit", "color","button"]);
  @observable List _values = toObservable([{"fruit": "Banana", "color": "yellow"}, 
                  {"fruit": "Peer", "color": "green"}, 
                  {"fruit": "Apple", "color": "red"}]);

  start(Element e, int gameId) {
    e.children = [host];
  }

  onCustomClick(Event e, var detail, Element target) => window.alert("Hello Coucou");
}
