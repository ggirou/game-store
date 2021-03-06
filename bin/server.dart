library game_store.server;

import 'dart:io';
import 'dart:convert';
import 'dart:async';

import 'package:path/path.dart' as Path;

import 'package:route/server.dart';

import 'game_api.dart' as GameApi;

final gameApiUrl = new UrlPattern(r'/api/games/(\d+).json');
final gamesApiUrl = new UrlPattern(r'/api/games.json');
final assetUrl = new UrlPattern(r'/(.+/)?asset/(.*)');
final homeUrl = new UrlPattern(r'/(.*)');

Future startServer(address, int port, String basePath, String assetPath) {
  basePath = Path.normalize(basePath);
  assetPath = Path.normalize(assetPath);
  
  return HttpServer.bind(address, port).then((HttpServer server) {
    log("Server started on http://$address:$port - Try it: http://${Platform.localHostname}:$port");
    log("Basepath: $basePath; Assetpath: $assetPath");

    var router = new Router(server)
      ..serve(gameApiUrl, method: 'GET').listen(safeServe(serveApiGame))
      ..serve(gamesApiUrl, method: 'GET').listen(safeServe(serveApiGames))
      ..serve(assetUrl).listen(safeServe(serveFile(assetPath, (uri) => '/${assetUrl.parse(uri.path)[1]}')))
      ..serve(homeUrl).listen(safeServe(serveFile(basePath, (uri) => uri.path.endsWith('/') ? '${uri.path}index.html' : uri.path)))
      ;
  });
}

safeServe(Future serve(HttpRequest request)) => (HttpRequest request) {
  return serve(request).catchError((e) => _sendError(request, e));
};

serveFile(String basePath, String filePathFromUri(Uri _)) => (HttpRequest request) {
  String filePath = filePathFromUri(request.uri);

  File file = new File(Path.normalize('${basePath}${filePath}'));
  if(!file.path.startsWith(basePath)) {
    return _sendNotFound(request, file);
  }
  
  return file.exists().then((bool found) {
    if (found) {
      log("200 - ${request.method} ${request.uri} - $file");
      return file.openRead().pipe(request.response);
    } else {
      return _sendNotFound(request, file);
    }
  });
};

Future serveApiGame(HttpRequest request) {
  int id = int.parse(gameApiUrl.parse(request.uri.path).first);
  return GameApi.getById(id).then((result) => _sendJSON(request, result));
}

Future serveApiGames(HttpRequest request) {
  return GameApi.all.then((result) => _sendJSON(request, result));
}

log(value) => print("${new DateTime.now()} - $value");

Future _sendNotFound(HttpRequest request, data) {
  log("404 - ${request.method} ${request.uri} - $data");
  request.response.statusCode = HttpStatus.NOT_FOUND;
  return request.response.close();
}

Future _sendError(HttpRequest request, Error error) {
  log("500 - ${request.method} ${request.uri} - ERROR: $error\n${error.stackTrace}");
  request.response.statusCode = HttpStatus.INTERNAL_SERVER_ERROR;
  return request.response.close();
}

Future _sendJSON(HttpRequest request, data) {
  if(data == null) {
    return _sendNotFound(request, "");
  } else {
    log("200 - ${request.method} ${request.uri}");

    var result = JSON.encode(data);
    request.response.write(result);
    return request.response.close();
  }
}

main() {
  // Compute base path for the request based on the location of the script and then start the server.
  var scriptDir = new File(new File(new Options().script).fullPathSync()).directory.path;

  var args = new Options().arguments;
  var address = '0.0.0.0';
  var port = args.length > 0 ? int.parse(args[0]) : 8080;
  var webPath = args.length > 1 ? args[1] : "$scriptDir/../web";
  
  GameApi.loadGames(webPath).then((_) => 
    startServer(address, port, webPath, "$scriptDir/../asset")
  );
}
