library game_store.components.game.game;

import 'dart:html';

import 'package:polymer/polymer.dart';
import 'package:game_store/web.dart';

@CustomTag('x-grid')
class XGrid extends CustomPolymerElement {
  bool get applyAuthorStyles => true;
  
  @observable List columns = toObservable([]);
  @observable List values = toObservable([]);

  XGrid.created() : super.created() {
    ContentElement content = shadowRoot.querySelector("content#templates");
    var templates = content.getDistributedNodes();
    
    shadowRoot.children.addAll(templates);
  }

  newGridColumnHeader(column) => new GridColumnHeader(column);
  newGridCell(column, data) => new GridCell(column, data);
}

@CustomTag('x-grid-column-header')
class GridColumnHeader extends CustomPolymerElement {
  @observable String column;
  GridColumnHeader(this.column) : super.created();
}

@CustomTag('x-grid-cell')
class GridCell extends CustomPolymerElement {
  @observable String column;
  @observable var data;
  GridCell(this.column, this.data) : super.created();
}
