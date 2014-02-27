library game_store.components.game.game;

import 'package:polymer/polymer.dart';
import 'package:game_store/entity.dart';
import 'package:game_store/web.dart';

@CustomTag('x-game')
class XGame extends CustomPolymerElement {
  bool get applyAuthorStyles => true;

  @observable Game game;
  
  XGame.created() : super.created();
}
