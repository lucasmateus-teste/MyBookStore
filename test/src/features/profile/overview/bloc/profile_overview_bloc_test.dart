import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_book_store/src/services/book_service.dart';
import 'package:my_book_store/src/services/store_service.dart';
import 'package:my_book_store/src/features/profile/overview/bloc/profile_overview_bloc.dart';
import '../../../../../mocks/app_mocks.dart';
import '../../../../../mocks/service_mocks.dart';

void main() {
  late StoreService storeService;
  late BookService bookService;
  late ProfileOverviewBloc bloc;

  setUpAll(() {
    registerFallbackValue(AppMocks.book);
    registerFallbackValue(AppMocks.store);
  });

  setUp(() {
    storeService = MockStoreService();
    bookService = MockBookService();
    bloc = ProfileOverviewBloc(
      storeService: storeService,
      bookService: bookService,
    );
  });

  group('ProfileOverviewBloc', () {
    blocTest<ProfileOverviewBloc, ProfileOverviewState>(
      'Emits ProfileOverviewLoaded when data is fetched successfully for admin',
      build: () {
        when(() => storeService.get()).thenAnswer((_) async => AppMocks.store);
        return bloc;
      },
      act: (bloc) => bloc.add(const ProfileOverviewGetDataEvent(isAdmin: true)),
      expect:
          () => [isA<ProfileOverviewLoading>(), isA<ProfileOverviewLoaded>()],
    );

    blocTest<ProfileOverviewBloc, ProfileOverviewState>(
      'Emits ProfileOverviewLoaded when data is fetched successfully for non-admin',
      build: () {
        when(() => storeService.get()).thenAnswer((_) async => AppMocks.store);
        when(
          () => bookService.getSavedBooks(),
        ).thenAnswer((_) async => [AppMocks.book]);
        return bloc;
      },
      act:
          (bloc) => bloc.add(const ProfileOverviewGetDataEvent(isAdmin: false)),
      expect:
          () => [isA<ProfileOverviewLoading>(), isA<ProfileOverviewLoaded>()],
    );

    blocTest<ProfileOverviewBloc, ProfileOverviewState>(
      'Emits ProfileOverviewFailure when fetching store data fails',
      build: () {
        when(
          () => storeService.get(),
        ).thenThrow(Exception('Error fetching store data'));
        return bloc;
      },
      act: (bloc) => bloc.add(const ProfileOverviewGetDataEvent(isAdmin: true)),
      expect:
          () => [isA<ProfileOverviewLoading>(), isA<ProfileOverviewFailure>()],
    );

    blocTest<ProfileOverviewBloc, ProfileOverviewState>(
      'Emits ProfileOverviewFailure when fetching saved books fails for non-admin',
      build: () {
        when(() => storeService.get()).thenAnswer((_) async => AppMocks.store);
        when(
          () => bookService.getSavedBooks(),
        ).thenThrow(Exception('Error fetching saved books'));
        return bloc;
      },
      act:
          (bloc) => bloc.add(const ProfileOverviewGetDataEvent(isAdmin: false)),
      expect:
          () => [isA<ProfileOverviewLoading>(), isA<ProfileOverviewFailure>()],
    );
  });
}
