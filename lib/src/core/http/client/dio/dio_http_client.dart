import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:my_book_store/src/core/exceptions/my_book_store_exceptions.dart';
import 'package:my_book_store/src/core/http/client/dio/interceptors/auth_interceptor.dart';
import 'package:my_book_store/src/core/http/client/http_client.dart';
import 'package:my_book_store/src/core/http/response/http_response.dart';

final class DioHttpClient implements HttpClient {
  @protected
  final Dio dio;
  DioHttpClient(String baseUrl)
    : dio = Dio(
        BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 30),
        ),
      ) {
    dio.interceptors.addAll([
      LogInterceptor(requestBody: true, responseBody: true),
      AuthInterceptor(),
    ]);
  }

  @override
  DioHttpClient get auth {
    dio.options.extra['DIO_AUTH_KEY'] = true;
    return this;
  }

  @override
  DioHttpClient get unauth {
    dio.options.extra['DIO_AUTH_KEY'] = false;
    return this;
  }

  @override
  Future<HttpResponse> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await dio.get(path, queryParameters: queryParameters);

      return HttpResponse(
        // data: response.data as Map<String, dynamic>,
        data: response.data,
        statusCode: response.statusCode ?? 200,
      );
    } on DioException catch (e) {
      _handleResponseError(e);
    }
  }

  @override
  Future<HttpResponse> post(String path, {Map<String, dynamic>? data}) async {
    try {
      debugPrint(jsonEncode(data));
      final response = await dio.post(path, data: data);

      return HttpResponse(
        data: response.data as Map<String, dynamic>,
        statusCode: response.statusCode ?? 200,
      );
    } on DioException catch (e) {
      _handleResponseError(e);
    }
  }

  @override
  Future<HttpResponse> put(String path, {Map<String, dynamic>? data}) async {
    try {
      final response = await dio.put(path, data: data);

      return HttpResponse(
        data: response.data as Map<String, dynamic>,
        statusCode: response.statusCode ?? 200,
      );
    } on DioException catch (e) {
      _handleResponseError(e);
    }
  }

  @override
  Future<HttpResponse> delete(String path, {Map<String, dynamic>? data}) async {
    try {
      final response = await dio.delete(path, data: data);

      return HttpResponse(
        data: response.data as Map<String, dynamic>,
        statusCode: response.statusCode ?? 200,
      );
    } on DioException catch (e) {
      _handleResponseError(e);
    }
  }

  Never _handleResponseError(DioException e) {
    final statusCode = e.response?.statusCode;

    if (statusCode != null) {
      switch (statusCode) {
        case 401:
          throw AuthUnauthorizedException();
        default:
          throw MyBookStoreException('Unexpected error: ${e.message}');
      }
    }

    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        throw ConnectionTimeoutException();
      default:
        throw MyBookStoreException('Unexpected error: ${e.message}');
    }
  }
}
