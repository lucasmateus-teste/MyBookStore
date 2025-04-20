import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_book_store/src/core/constants/local_storage_constants.dart';
import 'package:my_book_store/src/core/exceptions/my_book_store_exceptions.dart';
import 'package:my_book_store/src/services/store_service.dart';

import '../../mocks/app_mocks.dart';
import '../../mocks/local_storage_mock.dart';
import '../../mocks/repository_mocks.dart';

void main() {
  late StoreService storeService;
  late MockStoreRepository storeRepository;
  late MockLocalStorage localStorage;

  setUp(() {
    storeRepository = MockStoreRepository();
    localStorage = MockLocalStorage();
    storeService = StoreService(
      repository: storeRepository,
      localStorage: localStorage,
    );
  });

  group('StoreService', () {
    test('get fetches store successfully', () async {
      when(
        () => localStorage.get(LocalStorageConstants.storeId),
      ).thenReturn('1');
      when(
        () => storeRepository.get(1),
      ).thenAnswer((_) async => AppMocks.store);

      final store = await storeService.get();

      expect(store, AppMocks.store);
      verify(() => storeRepository.get(1)).called(1);
    });

    test('getStoreId throws exception if storeId is not found', () {
      when(
        () => localStorage.get(LocalStorageConstants.storeId),
      ).thenReturn(null);

      expect(
        () => storeService.getStoreId(),
        throwsA(isA<MyBookStoreException>()),
      );
    });

    test('getStoreId returns storeId if found', () {
      when(
        () => localStorage.get(LocalStorageConstants.storeId),
      ).thenReturn('1');

      final storeId = storeService.getStoreId();

      expect(storeId, 1);
    });
  });
}
