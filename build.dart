import 'package:polymer/component_build.dart';
import 'dart:io';

void main() {
  build(new Options().arguments, ['web/index.html']);
  // TODO: generate Rest client from wadl files
}
