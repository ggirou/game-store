part of game_store.web;

const globalFilters = const {
  'toUpperCase': toUpperCase,
  'notEmpty': notEmpty,
  'isEmpty': isEmpty,
  'hostPageBaseUrl': hostPageBaseUrl,
};

String toUpperCase(String v) => v.toUpperCase();
bool notEmpty(v) => v != null && v != '';
bool isEmpty(v) => v == null || v == '';
String hostPageBaseUrl(String path) => Uri.parse(window.location.toString()).resolveUri(Uri.parse(path)).toString();
