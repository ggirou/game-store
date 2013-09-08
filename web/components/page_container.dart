library game_store_game;

import 'package:polymer/polymer.dart';
import 'dart:html';

const _componentName = 'page-container';

@CustomTag(_componentName)
class PageContainer extends PolymerElement with ObservableMixin {
  @observable String componentName = "";
  
  String get componentPath => _link.attributes['href'];
  set componentPath(String value) => _link.attributes['href'] = value;
  
  DivElement get container => getShadowRoot(_componentName).query("#container");
  
  LinkElement _link = new LinkElement()
    ..attributes['rel'] = 'import';
  
  Element get _component => container.children.first;
  set _component(Element component) => container.children..clear()..add(component);
  
  void _show() {
    _component = createElement(componentName);
  }

  void created() {
    super.created();
    document.head.children.add(_link);
    bindProperty(this, const Symbol('componentName'), _show);
  }
}
