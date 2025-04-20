import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_book_store/src/services/book_service.dart';
import 'package:my_book_store/src/features/home/bloc/home_bloc.dart';

import '../../../../mocks/app_mocks.dart';
import '../../../../mocks/service_mocks.dart';

void main() {
  late BookService bookService;
  late HomeBloc bloc;

  setUpAll(() {
    registerFallbackValue(AppMocks.book);
  });

  setUp(() {
    bookService = MockBookService();
    bloc = HomeBloc(bookService: bookService);
  });

  group('HomeBloc', () {
    blocTest<HomeBloc, HomeState>(
      'Emits HomeLoaded when books are fetched successfully',
      build: () {
        when(
          () => bookService.getBooks(),
        ).thenAnswer((_) async => [AppMocks.book]);
        return bloc;
      },
      act: (bloc) => bloc.add(const HomeGetBooks()),
      expect: () => [isA<HomeLoading>(), isA<HomeLoaded>()],
    );

    blocTest<HomeBloc, HomeState>(
      'Emits HomeFailure when fetching books fails',
      build: () {
        when(
          () => bookService.getBooks(),
        ).thenThrow(Exception('Error fetching books'));
        return bloc;
      },
      act: (bloc) => bloc.add(const HomeGetBooks()),
      expect: () => [isA<HomeLoading>(), isA<HomeFailure>()],
    );
  });
}
