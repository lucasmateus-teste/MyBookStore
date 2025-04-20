import 'package:my_book_store/src/data/models/book_model.dart';

abstract interface class BookRepository {
  Future<List<BookModel>> getAll(int storeId);
  Future<BookModel> create(int storeId, BookModel book);
  Future<void> update(int storeId, BookModel book);
  Future<void> remove(int storeId, int id);
  Future<List<BookModel>> searchBooks(int storeId, String query);
}
