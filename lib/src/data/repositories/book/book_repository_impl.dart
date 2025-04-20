import 'package:flutter/foundation.dart';
import 'package:my_book_store/src/core/http/client/http_client.dart';
import 'package:my_book_store/src/data/models/book_model.dart';

import './book_repository.dart';

class BookRepositoryImpl implements BookRepository {
  BookRepositoryImpl({required this.httpClient});

  @protected
  final HttpClient httpClient;

  @override
  Future<BookModel> create(int storeId, BookModel book) async {
    final response = await httpClient.auth.post(
      'v1/store/$storeId/book',
      data: book.toMap(),
    );
    return BookModel.fromMap(response.data as Map<String, dynamic>);
  }

  @override
  Future<List<BookModel>> getAll(int storeId) async {
    final response = await httpClient.auth.get('v1/store/$storeId/book?');
    final books = response.data as List<dynamic>;

    return books.map((e) => BookModel.fromMap(e)).toList();
  }

  @override
  Future<void> remove(int storeId, int id) async {
    await httpClient.auth.delete('v1/store/$storeId/book/$id');
  }

  @override
  Future<List<BookModel>> searchBooks(int storeId, String query) {
    // TODO: implement searchBooks
    throw UnimplementedError();
  }

  @override
  Future<void> update(int storeId, BookModel book) async {
    await httpClient.auth.put(
      'v1/store/$storeId/book/${book.id}',
      data: book.toMap(),
    );
  }
}
