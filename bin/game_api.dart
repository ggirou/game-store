library game_store.server.game_api;

import 'dart:async';

List<Map> _games = [
  {"id": 1, "name": "Half-Life", "genre": "Action", "image": "half-life.jpg", "releaseDate": "1998-11-08", "description": "Named Game of the Year by over 50 publications, Valve's debut title blends action and adventure with award-winning technology to create a frighteningly realistic world where players must think to survive. Also includes an exciting multiplayer mode that allows you to play against friends and enemies around the world."},
  {"id": 2, "name": "Half-Life 2", "genre": "Action", "image": "half-life_2.jpg", "releaseDate": "2004-11-16", "description": "1998. HALF-LIFE sends a shock through the game industry with its combination of pounding action and continuous, immersive storytelling. Valve's debut title wins more than 50 game-of-the-year awards on its way to being named \"Best PC Game Ever\" by PC Gamer, and launches a franchise with more than eight million retail units sold worldwide."},
];

Future<List<Map>> get all => new Future.value(_games);
Future<Map> getById(int id) => new Future(() =>_games.firstWhere((game) => game["id"] == id, orElse: () => null));