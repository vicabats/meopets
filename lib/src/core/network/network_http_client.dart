import 'package:http/http.dart' as http;
import 'package:meopets/config/environment.dart';
import 'package:meopets/src/core/network/network.dart';

class NetworkHttpClient extends AppNetwork {
  final http.Client client;
  final Environment environment;

  NetworkHttpClient({
    required this.client,
    required this.environment,
  });

  Uri _endpoint(String path) {
    const apiUrl = String.fromEnvironment('API_URL');
    final completeUrl = '$apiUrl$path';
    return Uri.parse(completeUrl);
  }

  @override
  Future<http.Response> get(
    String url, {
    Map<String, String>? headers,
  }) async {
    return client.get(
      _endpoint(url),
      headers: headers,
    );
  }

  @override
  Future<http.Response> post(
    String url, {
    Map<String, String>? headers,
    Object? body,
  }) async {
    return client.post(
      _endpoint(url),
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
    String url, {
    Map<String, String>? headers,
    Object? body,
  }) async {
    return client.delete(
      _endpoint(url),
      headers: headers,
      body: body,
    );
  }
}
