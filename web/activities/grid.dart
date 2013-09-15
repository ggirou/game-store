library game_store.activities.grid;

import 'dart:html';

import 'package:polymer/polymer.dart';
import 'package:game_store/web.dart';

@CustomTag('grid-activity')
class GridActivity extends CustomPolymerElement with ObservableMixin implements Activity {
  bool get applyAuthorStyles => true;

  List _columns = ["a", "b"];
  List _values = ["Banana", "Peer", "Apple"];

  start(Element e, int gameId) {
    e.children = [host];
    
    var grid = getShadowRoot("grid-activity").query("#grid").xtag;
    grid.values = _columns;
    grid.values = _values;
  }
}
