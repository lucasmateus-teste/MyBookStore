import '../response/http_response.dart';

abstract interface class HttpClient {
  HttpClient get auth;
  HttpClient get unauth;

  Future<HttpResponse> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  });

  Future<HttpResponse> post(String path, {Map<String, dynamic>? data});

  Future<HttpResponse> put(String path, {Map<String, dynamic>? data});

  Future<HttpResponse> delete(String path, {Map<String, dynamic>? data});
}
