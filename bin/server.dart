import 'dart:io';
import 'packages/path/path.dart' as Path;

startServer(String basePath) {
  var address = '127.0.0.1';
  var port = 8080;
  HttpServer.bind(address, port).then((server) {
    log("Server started on http://$address:$port");
    log("Basepath: $basePath");
    server.listen((HttpRequest request) {
      String path = request.uri.path;
      
      String stringPath = path == '/' ? '/index.html' : path;
      File file = new File(Path.normalize('${basePath}${stringPath}'));
      if(!file.path.startsWith(basePath)) {
        _sendNotFound(request, file);
        return;
      }
      
      file.exists().then((bool found) {
        if (found) {
          log("200 - ${request.method} ${request.uri} - $file");
          file.openRead().pipe(request.response).catchError(log);
        } else {
          _sendNotFound(request, file);
        }
      });
    });
  });
}

log(value) => print("${new DateTime.now()} - $value");

_sendNotFound(HttpRequest request, File file) {
  log("404 - ${request.method} ${request.uri} - $file");
  request.response.statusCode = HttpStatus.NOT_FOUND;
  request.response.close();
}

main() {
  // Compute base path for the request based on the location of the
  // script and then start the server.
  File script = new File(new File(new Options().script).fullPathSync());
  startServer(Path.normalize("${script.directory.path}/../web"));
}
