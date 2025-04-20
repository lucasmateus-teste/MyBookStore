import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_book_store/src/services/book_service.dart';
import 'package:my_book_store/src/features/books/admin/form/bloc/book_admin_form_bloc.dart';
import 'package:my_book_store/src/data/models/book_model.dart';

import '../../../../../../mocks/app_mocks.dart';
import '../../../../../../mocks/service_mocks.dart';

void main() {
  late BookService bookService;
  late BookAdminFormBloc bloc;
  late BookModel book;

  setUp(() {
    bookService = MockBookService();
    bloc = BookAdminFormBloc(bookService: bookService);
    book = AppMocks.book;
  });

  group('BookAdminFormBloc', () {
    blocTest<BookAdminFormBloc, BookAdminFormState>(
      'Emits BookAdminFormCreatedState when a book is created successfully',
      build: () {
        when(() => bookService.create(book)).thenAnswer((_) async => book);
        return bloc;
      },
      act: (bloc) => bloc.add(BookAdminFormCreateEvent(book: book)),
      expect:
          () => [
            isA<BookAdminFormLoadingState>(),
            isA<BookAdminFormCreatedState>(),
          ],
    );

    blocTest<BookAdminFormBloc, BookAdminFormState>(
      'Emits BookAdminFormUpdatedState when a book is updated successfully',
      build: () {
        when(() => bookService.updateBook(book)).thenAnswer((_) async => {});
        return bloc;
      },
      act: (bloc) => bloc.add(BookAdminFormUpdateEvent(book: book)),
      expect:
          () => [
            isA<BookAdminFormLoadingState>(),
            isA<BookAdminFormUpdatedState>(),
          ],
    );

    blocTest<BookAdminFormBloc, BookAdminFormState>(
      'Emits BookAdminFormFailureState when an exception is thrown during book creation',
      build: () {
        when(
          () => bookService.create(book),
        ).thenThrow(Exception('Error creating book'));
        return bloc;
      },
      act: (bloc) => bloc.add(BookAdminFormCreateEvent(book: book)),
      expect:
          () => [
            isA<BookAdminFormLoadingState>(),
            isA<BookAdminFormFailureState>(),
          ],
    );

    blocTest<BookAdminFormBloc, BookAdminFormState>(
      'Emits BookAdminFormFailureState when an exception is thrown during book update',
      build: () {
        when(
          () => bookService.updateBook(book),
        ).thenThrow(Exception('Error updating book'));
        return bloc;
      },
      act: (bloc) => bloc.add(BookAdminFormUpdateEvent(book: book)),
      expect:
          () => [
            isA<BookAdminFormLoadingState>(),
            isA<BookAdminFormFailureState>(),
          ],
    );
  });
}
