part of game_store.activities;

class GameActivity implements Activity {
  Element component;
 
  GameActivity(Element this.component);
  
  start(Element e) {
    e.children = [component];
    document.title = "Game";
  }
}
