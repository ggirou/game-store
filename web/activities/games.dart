library game_store.activities.games;

import 'dart:html';

import 'package:game_store/web.dart';

class GamesActivity implements Activity {
  Element component;

  GamesActivity(Element this.component);
  
  start(Element e, _) {
    e.children = [component];
    document.title = "Games";
  }
}
