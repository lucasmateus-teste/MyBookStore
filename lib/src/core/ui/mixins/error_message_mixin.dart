import 'package:my_book_store/src/core/exceptions/my_book_store_exceptions.dart';

mixin ErrorMessageMixin {
  Exception get exception;

  String get error {
    final exception = this.exception;

    if (exception is MyBookStoreException) {
      return exception.message;
    }
    return exception.toString();
  }
}
