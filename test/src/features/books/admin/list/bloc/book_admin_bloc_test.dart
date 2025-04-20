import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_book_store/src/services/book_service.dart';
import 'package:my_book_store/src/features/books/admin/list/bloc/book_admin_bloc.dart';

import '../../../../../../mocks/app_mocks.dart';
import '../../../../../../mocks/service_mocks.dart';

void main() {
  late BookService bookService;
  late BookAdminBloc bloc;

  setUp(() {
    bookService = MockBookService();
    bloc = BookAdminBloc(bookService: bookService);
  });

  group('BookAdminBloc', () {
    blocTest<BookAdminBloc, BookAdminState>(
      'Emits BookAdminLoadedState when books are fetched successfully',
      build: () {
        when(
          () => bookService.getBooks(),
        ).thenAnswer((_) async => [AppMocks.book]);
        return bloc;
      },
      act: (bloc) => bloc.add(const BookAdminGetBooksEvent()),
      expect: () => [isA<BookAdminLoadingState>(), isA<BookAdminLoadedState>()],
    );

    blocTest<BookAdminBloc, BookAdminState>(
      'Emits BookAdminFailureState when an exception is thrown',
      build: () {
        when(() => bookService.getBooks()).thenThrow(Exception());
        return bloc;
      },
      act: (bloc) => bloc.add(const BookAdminGetBooksEvent()),
      expect:
          () => [isA<BookAdminLoadingState>(), isA<BookAdminFailureState>()],
    );
  });
}
