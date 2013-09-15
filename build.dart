import 'dart:io';
import 'package:polymer/component_build.dart' as polymer;
// import 'package:discovery_api_client_generator/generator.dart';

void main() {
  // TODO: generate Rest client from json hyper-schema files (http://json-schema.org)
  // loadDocumentFromFile("meta/simple_service.json").then((String doc) => generateLibraryFromSource(doc, "lib/src/rest/simple_service/"));
  
  polymer.build(new Options().arguments, ['web/index.html']);
//  build(entryPoints: ['web/index.html'])
}
