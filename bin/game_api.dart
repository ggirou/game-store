library game_store.server.game_api;

import 'dart:async';

List<Map> _games = [
  {"id": 1, "name": "Darts", "genre": "Pub game", "image": "darts.jpg", 
    "description": "Darts is a form of throwing game in which small missiles are thrown at a circular target (dartboard) fixed to a wall. Though various boards and rules have been used in the past, the term \"darts\" usually now refers to a standardised game involving a specific board design and set of rules."},
  {"id": 2, "name": "Chess", "genre": "Board game", "image": "chess.jpg", "players": "2", 
    "description": "Chess is a two-player strategy board game played on a chessboard, a checkered gameboard with 64 squares arranged in an eight-by-eight grid. It is one of the world's most popular games, played by millions of people worldwide at home, in clubs, online, by correspondence, and in tournaments."},
  {"id": 3, "name": "Dices", "genre": "Random game", "image": "dice.jpg", 
    "description": "Dice are small throwable objects with multiple resting positions, used for generating random numbers. This makes dice suitable as gambling devices for games like craps, or for use in non-gambling tabletop games."},
];

Future<List<Map>> get all => new Future.value(_games);
Future<Map> getById(int id) => new Future(() =>_games.firstWhere((game) => game["id"] == id, orElse: () => null));