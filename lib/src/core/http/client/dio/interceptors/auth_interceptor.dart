import 'package:dio/dio.dart';
import 'package:my_book_store/src/core/config/dependencies.dart';
import 'package:my_book_store/src/core/constants/local_storage_constants.dart';
import 'package:my_book_store/src/core/local_storage/local_storage.dart';

final class AuthInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final RequestOptions(:headers, :extra) = options;

    const authHeaderKey = 'Authorization';
    headers.remove(authHeaderKey);

    if (extra case {'DIO_AUTH_KEY': true}) {
      final localStorage = getIt.get<LocalStorage>();
      final accessToken = localStorage.get(LocalStorageConstants.accessToken);

      headers.addAll({authHeaderKey: 'Bearer $accessToken'});
    }
    handler.next(options);
  }
}
