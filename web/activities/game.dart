library game_store_game;

import 'package:polymer/polymer.dart';
import 'package:game_store/game_store.dart';

@CustomTag('x-game')
class XGame extends PolymerElement with ObservableMixin implements Activity {
  bool get applyAuthorStyles => true;

  @observable String gameId = "World";
  
  @observable Game game = new Game()
    ..name = "Half-Life"
    ..genre = "Action"
    ..releaseDate = new DateTime(1998, 11, 8)
    ..description = "Named Game of the Year by over 50 publications, Valve's debut title blends action and adventure with award-winning technology to create a frighteningly realistic world where players must think to survive. Also includes an exciting multiplayer mode that allows you to play against friends and enemies around the world."
    ;
  
  start() {
    
  }
}
