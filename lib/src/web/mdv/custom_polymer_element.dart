part of game_store.web;

class CustomPolymerElement extends PolymerElement {
  static BindingDelegate _polymerSyntax = new PolymerExpressions(globals: globalFilters);
      
  DocumentFragment instanceTemplate(Element template) => template.createInstance(this, _polymerSyntax);
}
