abstract class AppNetwork {
  Future<dynamic> get(Uri url, {Map<String, String>? headers});

  Future<dynamic> post(Uri url, {Map<String, String>? headers, Object? body});

  Future<dynamic> patch(Uri url, {Map<String, String>? headers, Object? body});

  Future<dynamic> delete(Uri url, {Map<String, String>? headers, Object? body});
}
