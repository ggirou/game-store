part of game_store.web;

final globalFilters = {
  'uppercase': (String v) => v.toUpperCase(),
  'notEmpty': (v) => v != null && v != '',
};

