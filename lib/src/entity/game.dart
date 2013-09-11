part of game_store.entity;

class Game {
  int id;
  String name;
  String genre;
  String image;
  String players;
  String description;
  
  String toString() => "Game{id: $id, name: $name}";
}