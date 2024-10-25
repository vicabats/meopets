import 'package:http/http.dart' as http;
import 'package:meopets/src/core/app-environment/environment.dart';
import 'package:meopets/src/core/app-network/app_network.dart';

class NetworkHttpClient extends AppNetwork {
  final http.Client client;
  final Environment environment;

  NetworkHttpClient({
    required this.client,
    required this.environment,
  });

  Uri _endpoint(String url) {
    return Uri.parse('${environment.apiUrl}/$url');
  }

  @override
  Future<http.Response> get(
    Uri url, {
    Map<String, String>? headers,
  }) async {
    return client.get(
      _endpoint(url.path),
      headers: headers,
    );
  }

  @override
  Future<http.Response> post(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
  }) async {
    return client.post(
      _endpoint(url.path),
      headers: headers,
      body: body,
    );
  }

  @override
  Future<http.Response> patch(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
  }) async {
    return client.patch(
      _endpoint(url.path),
      headers: headers,
      body: body,
    );
  }

  @override
  Future<http.Response> delete(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
  }) async {
    return client.delete(
      _endpoint(url.path),
      headers: headers,
      body: body,
    );
  }
}
