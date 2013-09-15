part of game_store.web;

final globalFilters = {
  'uppercase': (String v) => v.toUpperCase(),
  'notEmpty': notEmpty,
  'isEmpty': isEmpty,
};

bool notEmpty(v) => v != null && v != '';
bool isEmpty(v) => v == null || v == '';
