import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_book_store/src/services/book_service.dart';
import 'package:my_book_store/src/features/books/details/bloc/book_details_bloc.dart';
import 'package:my_book_store/src/data/models/book_model.dart';

import '../../../../../mocks/app_mocks.dart';
import '../../../../../mocks/service_mocks.dart';

void main() {
  late BookService bookService;
  late BookDetailsBloc bloc;
  late BookModel book;

  setUp(() {
    bookService = MockBookService();
    book = AppMocks.book;
    bloc = BookDetailsBloc(book: book, bookService: bookService);
  });

  setUpAll(() {
    registerFallbackValue(AppMocks.book);
  });

  group('BookDetailsBloc', () {
    blocTest<BookDetailsBloc, BookDetailsState>(
      'Emits BookDetailsLoadedState when availability is toggled successfully',
      build: () {
        when(() => bookService.updateBook(any())).thenAnswer((_) async {});
        return bloc;
      },
      act: (bloc) => bloc.add(const BookDetailsChangeIsAvailableEvent()),
      expect: () => [isA<BookDetailsLoadedState>()],
    );

    blocTest<BookDetailsBloc, BookDetailsState>(
      'Emits BookDetailsFailureState when toggling availability fails',
      build: () {
        when(() => bookService.updateBook(any())).thenThrow(Exception());
        return bloc;
      },
      act: (bloc) => bloc.add(const BookDetailsChangeIsAvailableEvent()),
      expect: () => [isA<BookDetailsFailureState>()],
    );

    blocTest<BookDetailsBloc, BookDetailsState>(
      'Emits BookDetailsLoadedState when rating is changed successfully',
      build: () {
        when(() => bookService.updateBook(book)).thenAnswer((_) async => {});
        return bloc;
      },
      act: (bloc) => bloc.add(const BookDetailsChangeRatingEvent(rating: 5)),
      expect: () => [isA<BookDetailsLoadedState>()],
    );

    blocTest<BookDetailsBloc, BookDetailsState>(
      'Emits BookDetailsFailureState when changing rating fails',
      build: () {
        when(() => bookService.updateBook(book)).thenThrow(Exception());
        return bloc;
      },
      act: (bloc) => bloc.add(const BookDetailsChangeRatingEvent(rating: 5)),
      expect: () => [isA<BookDetailsFailureState>()],
    );

    blocTest<BookDetailsBloc, BookDetailsState>(
      'Emits BookDetailsLoadedState when book is saved successfully',
      build: () {
        when(() => bookService.save(any())).thenAnswer((_) async => {});
        return bloc;
      },
      act: (bloc) => bloc.add(const BookDetailsChangeIsSavedEvent()),
      expect: () => [isA<BookDetailsLoadedState>()],
    );

    blocTest<BookDetailsBloc, BookDetailsState>(
      'Emits BookDetailsFailureState when saving book fails',
      build: () {
        when(() => bookService.save(any())).thenThrow(Exception());
        return bloc;
      },
      act: (bloc) => bloc.add(const BookDetailsChangeIsSavedEvent()),
      expect: () => [isA<BookDetailsFailureState>()],
    );

    blocTest<BookDetailsBloc, BookDetailsState>(
      'Emits BookDetailsDeletedState when book is deleted successfully',
      build: () {
        when(() => bookService.delete(book)).thenAnswer((_) async => {});
        return bloc;
      },
      act: (bloc) => bloc.add(BookDetailsDeleteBookEvent(book)),
      expect: () => [isA<BookDetailsDeletedState>()],
    );

    blocTest<BookDetailsBloc, BookDetailsState>(
      'Emits BookDetailsFailureState when deleting book fails',
      build: () {
        when(() => bookService.delete(book)).thenThrow(Exception());
        return bloc;
      },
      act: (bloc) => bloc.add(BookDetailsDeleteBookEvent(book)),
      expect: () => [isA<BookDetailsFailureState>()],
    );

    blocTest<BookDetailsBloc, BookDetailsState>(
      'Emits BookDetailsLoadedState when book is changed',
      build: () => bloc,
      act: (bloc) => bloc.add(BookDetailsBookChangedEvent(book)),
      expect: () => [isA<BookDetailsLoadedState>()],
    );
  });
}
