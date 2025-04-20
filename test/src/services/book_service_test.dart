import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_book_store/src/core/constants/local_storage_constants.dart';
import 'package:my_book_store/src/core/exceptions/my_book_store_exceptions.dart';
import 'package:my_book_store/src/services/book_service.dart';

import '../../mocks/app_mocks.dart';
import '../../mocks/local_storage_mock.dart';
import '../../mocks/repository_mocks.dart';

void main() {
  late BookService bookService;
  late MockBookRepository bookRepository;
  late MockLocalStorage localStorage;

  setUp(() {
    bookRepository = MockBookRepository();
    localStorage = MockLocalStorage();
    bookService = BookService(
      repository: bookRepository,
      localStorage: localStorage,
    );
  });

  group('BookService', () {
    test('save adds book ID to savedBooks in local storage', () async {
      final book = AppMocks.book;

      when(
        () => localStorage.get(LocalStorageConstants.savedBooks),
      ).thenReturn(null);
      when(() => localStorage.save(any(), any())).thenAnswer((_) async => {});

      await bookService.save(book);

      verify(
        () => localStorage.save(
          LocalStorageConstants.savedBooks,
          jsonEncode([book.id]),
        ),
      ).called(1);
    });

    test(
      'removeSaved removes book ID from savedBooks in local storage',
      () async {
        final book = AppMocks.book;

        when(
          () => localStorage.get(LocalStorageConstants.savedBooks),
        ).thenReturn(jsonEncode([book.id]));
        when(() => localStorage.save(any(), any())).thenAnswer((_) async => {});

        await bookService.removeSaved(book);

        verify(
          () => localStorage.save(
            LocalStorageConstants.savedBooks,
            jsonEncode([]),
          ),
        ).called(1);
      },
    );

    test('getBooks fetches books and marks saved books', () async {
      final book = AppMocks.book;

      when(
        () => localStorage.get(LocalStorageConstants.storeId),
      ).thenReturn('1');
      when(() => bookRepository.getAll(1)).thenAnswer((_) async => [book]);
      when(
        () => localStorage.get(LocalStorageConstants.savedBooks),
      ).thenReturn(jsonEncode([book.id]));

      final books = await bookService.getBooks();

      expect(books.first.isSaved, true);
    });

    test('getSavedBooks fetches only saved books', () async {
      final book = AppMocks.book;

      when(
        () => localStorage.get(LocalStorageConstants.storeId),
      ).thenReturn('1');
      when(() => bookRepository.getAll(1)).thenAnswer((_) async => [book]);
      when(
        () => localStorage.get(LocalStorageConstants.savedBooks),
      ).thenReturn(jsonEncode([book.id]));

      final savedBooks = await bookService.getSavedBooks();

      expect(savedBooks.length, 1);
      expect(savedBooks.first.isSaved, true);
    });

    test(
      'updateBook calls repository update with correct parameters',
      () async {
        final book = AppMocks.book;

        when(
          () => localStorage.get(LocalStorageConstants.storeId),
        ).thenReturn('1');
        when(() => bookRepository.update(1, book)).thenAnswer((_) async => {});

        await bookService.updateBook(book);

        verify(() => bookRepository.update(1, book)).called(1);
      },
    );

    test(
      'delete removes book from savedBooks and calls repository remove',
      () async {
        final book = AppMocks.book;

        when(
          () => localStorage.get(LocalStorageConstants.storeId),
        ).thenReturn('1');
        when(
          () => localStorage.get(LocalStorageConstants.savedBooks),
        ).thenReturn(jsonEncode([book.id]));
        when(() => localStorage.save(any(), any())).thenAnswer((_) async => {});
        when(
          () => bookRepository.remove(1, book.id!),
        ).thenAnswer((_) async => {});

        await bookService.delete(book);

        verify(
          () => localStorage.save(
            LocalStorageConstants.savedBooks,
            jsonEncode([]),
          ),
        ).called(1);
        verify(() => bookRepository.remove(1, book.id!)).called(1);
      },
    );

    test('create calls repository create and returns created book', () async {
      final book = AppMocks.book;

      when(
        () => localStorage.get(LocalStorageConstants.storeId),
      ).thenReturn('1');
      when(() => bookRepository.create(1, book)).thenAnswer((_) async => book);

      final createdBook = await bookService.create(book);

      expect(createdBook, book);
      verify(() => bookRepository.create(1, book)).called(1);
    });

    test('getStoreId throws exception if storeId is not found', () {
      when(
        () => localStorage.get(LocalStorageConstants.storeId),
      ).thenReturn(null);

      expect(
        () => bookService.getStoreId(),
        throwsA(isA<MyBookStoreException>()),
      );
    });

    test('getStoreId returns storeId if found', () {
      when(
        () => localStorage.get(LocalStorageConstants.storeId),
      ).thenReturn('1');

      final storeId = bookService.getStoreId();

      expect(storeId, 1);
    });
  });
}
