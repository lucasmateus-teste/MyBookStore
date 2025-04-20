import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_book_store/src/services/book_service.dart';
import 'package:my_book_store/src/features/books/saved/bloc/saved_books_bloc.dart';

import '../../../../../mocks/app_mocks.dart';
import '../../../../../mocks/service_mocks.dart';

void main() {
  late BookService bookService;
  late SavedBooksBloc bloc;

  setUp(() {
    bookService = MockBookService();
    bloc = SavedBooksBloc(bookService: bookService);
  });

  group('SavedBooksBloc', () {
    blocTest<SavedBooksBloc, SavedBooksState>(
      'Emits SavedBooksLoadedState when saved books are fetched successfully',
      build: () {
        when(
          () => bookService.getSavedBooks(),
        ).thenAnswer((_) async => [AppMocks.book]);
        return bloc;
      },
      act: (bloc) => bloc.add(const SavedBooksGetBooksEvent()),
      expect:
          () => [isA<SavedBooksLoadingState>(), isA<SavedBooksLoadedState>()],
    );

    blocTest<SavedBooksBloc, SavedBooksState>(
      'Emits SavedBooksFailureState when fetching saved books fails',
      build: () {
        when(() => bookService.getSavedBooks()).thenThrow(Exception());
        return bloc;
      },
      act: (bloc) => bloc.add(const SavedBooksGetBooksEvent()),
      expect:
          () => [isA<SavedBooksLoadingState>(), isA<SavedBooksFailureState>()],
    );
  });
}
