library game_store.components.game.game;

import 'dart:html';

import 'package:polymer/polymer.dart';
import 'package:game_store/web.dart';

@CustomTag('x-grid')
class XGrid extends CustomPolymerElement with ObservableMixin {
  bool get applyAuthorStyles => true;
  
  List _columns = toObservable(['a','b']);
//  @observable List columns;
  List get columns => _columns;
  set columns(List values) => _columns..clear()..addAll(_colvaluesumns);

  List _values = toObservable([]);
//  @observable List values;
  List get values => _values;
  set values(List values) => _values..clear()..addAll(values);

  void created() {
    super.created();

//    bindProperty(this, const Symbol('columns'), () => _columns..clear()..addAll(_columns));
//    bindProperty(this, const Symbol('values'), () => _values..clear()..addAll(values));
    
    var root = getShadowRoot('x-grid');
    ContentElement content = root.query("content#templates");
    var templates = content.getDistributedNodes();
    
    root.children.addAll(templates);
  }
}
