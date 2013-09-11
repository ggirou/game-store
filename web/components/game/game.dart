library game_store.components.game.game;

import 'package:polymer/polymer.dart';
import 'package:game_store/entity.dart';
import 'package:game_store/web.dart';

@CustomTag('x-game')
class XGame extends CustomPolymerElement with ObservableMixin {
  bool get applyAuthorStyles => true;

  @observable String gameId = "World";
  
  @observable Game game;

  @observable bool isEmpty = true;
  
  void created() {
    super.created();
    
    bindProperty(this, const Symbol('game'), () => isEmpty = game == null);
  }
}
