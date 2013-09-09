part of game_store.activities;

class GamesActivity implements Activity {
  Element component;

  GamesActivity(Element this.component);
  
  start(Element e) {
    e.children = [component];
    document.title = "Games";
  }
}
