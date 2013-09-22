part of game_store.web;

class CustomPolymerElement extends PolymerElement {
  static BindingDelegate _polymerSyntax = new PolymerExpressions(globals: globalFilters);
  
  BindingDelegate polymerSyntax = _polymerSyntax;
  DocumentFragment instanceTemplate(Element template) => template.createInstance(this, polymerSyntax);
  
  // TODO: check if overriding is still needed
  Events get on => host.on;
}
