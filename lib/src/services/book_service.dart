import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:my_book_store/src/core/constants/local_storage_constants.dart';
import 'package:my_book_store/src/core/exceptions/my_book_store_exceptions.dart';
import 'package:my_book_store/src/core/local_storage/local_storage.dart';
import 'package:my_book_store/src/data/models/book_model.dart';
import 'package:my_book_store/src/data/repositories/book/book_repository.dart';

class BookService {
  BookService({required this.repository, required this.localStorage});

  @protected
  final BookRepository repository;
  @protected
  final LocalStorage localStorage;

  Future<void> save(BookModel book) async {
    final savedBooks = _getSavedBooksIds();
    savedBooks.add(book.id!);
    await localStorage.save(
      LocalStorageConstants.savedBooks,
      jsonEncode(savedBooks.toList()),
    );
  }

  Future<void> removeSaved(BookModel book) async {
    final savedBooks = _getSavedBooksIds();
    savedBooks.remove(book.id!);
    await localStorage.save(
      LocalStorageConstants.savedBooks,
      jsonEncode(savedBooks.toList()),
    );
  }

  Future<List<BookModel>> getBooks() async {
    final storeId = getStoreId();
    final books = await repository.getAll(storeId);
    final savedBooks = _getSavedBooksIds();

    return books.map((book) {
      if (savedBooks.contains(book.id)) {
        return book.copyWith(isSaved: true);
      }
      return book;
    }).toList();
  }

  Future<List<BookModel>> getSavedBooks() async {
    final storeId = getStoreId();
    final books = await repository.getAll(storeId);
    final savedBooks = _getSavedBooksIds();

    return books
        .where((book) => savedBooks.contains(book.id))
        .map((book) => book.copyWith(isSaved: true))
        .toList();
  }

  Set<int> _getSavedBooksIds() {
    final result = localStorage.get(LocalStorageConstants.savedBooks);
    if (result != null) {
      return Set<int>.from(jsonDecode(result));
    }
    return <int>{};
  }

  Future<void> updateBook(BookModel book) async {
    final storeId = getStoreId();
    await repository.update(storeId, book);
  }

  Future<void> delete(BookModel book) async {
    final storeId = getStoreId();
    final savedBooks = _getSavedBooksIds();
    if (savedBooks.contains(book.id)) {
      savedBooks.remove(book.id!);
      _saveBooksLocalStorage(savedBooks);
    }
    await repository.remove(storeId, book.id!);
  }

  Future<BookModel> create(BookModel book) async {
    final storeId = getStoreId();
    return await repository.create(storeId, book);
  }

  int getStoreId() {
    final result = localStorage.get(LocalStorageConstants.storeId);
    if (result != null) {
      return int.parse(result);
    }
    throw MyBookStoreException('Erro ao buscar o storeId');
  }

  Future<void> _saveBooksLocalStorage(Set<int> books) async {
    await localStorage.save(
      LocalStorageConstants.savedBooks,
      jsonEncode(books.toList()),
    );
  }
}
