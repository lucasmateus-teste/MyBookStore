import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_book_store/src/core/constants/local_storage_constants.dart';
import 'package:my_book_store/src/data/models/credentials_model.dart';
import 'package:my_book_store/src/services/auth_service.dart';

import '../../mocks/app_mocks.dart';
import '../../mocks/local_storage_mock.dart';
import '../../mocks/repository_mocks.dart';

void main() {
  final credentials = CredentialsModel(
    user: 'julio.bitencour',
    password: '8ec4sJ7dx!*d',
  );
  late AuthService authService;
  late MockUserRepository userRepository;
  late MockStoreRepository storeRepository;
  late MockLocalStorage localStorage;

  setUp(() {
    userRepository = MockUserRepository();
    storeRepository = MockStoreRepository();
    localStorage = MockLocalStorage();
    authService = AuthService(
      userRepository: userRepository,
      storeRepository: storeRepository,
      localStorage: localStorage,
    );
  });

  group('AuthService', () {
    test('login saves tokens and store ID to local storage', () async {
      final authModel = AppMocks.auth;

      when(
        () => userRepository.login(credentials),
      ).thenAnswer((_) async => authModel);
      when(() => localStorage.save(any(), any())).thenAnswer((_) async => {});

      final result = await authService.login(credentials);

      expect(result, authModel);
      verify(
        () => localStorage.save(
          LocalStorageConstants.accessToken,
          authModel.token,
        ),
      ).called(1);
      verify(
        () => localStorage.save(
          LocalStorageConstants.refreshToken,
          authModel.refreshToken,
        ),
      ).called(1);
      verify(
        () => localStorage.save(
          LocalStorageConstants.storeId,
          authModel.store.id.toString(),
        ),
      ).called(1);
    });

    test('createStore saves tokens to local storage', () async {
      final storeCreateDto = AppMocks.storeCreateDto;
      final authModel = AppMocks.auth;

      when(
        () => storeRepository.create(storeCreateDto),
      ).thenAnswer((_) async => authModel);
      when(() => localStorage.save(any(), any())).thenAnswer((_) async => {});

      final result = await authService.createStore(storeCreateDto);

      expect(result, authModel);
      verify(
        () => localStorage.save(
          LocalStorageConstants.accessToken,
          authModel.token,
        ),
      ).called(1);
      verify(
        () => localStorage.save(
          LocalStorageConstants.refreshToken,
          authModel.refreshToken,
        ),
      ).called(1);
    });

    test('login rethrows exceptions from userRepository', () async {
      when(
        () => userRepository.login(credentials),
      ).thenThrow(Exception('Login failed'));

      expect(() => authService.login(credentials), throwsException);
    });

    test('createStore rethrows exceptions from storeRepository', () async {
      final storeCreateDto = AppMocks.storeCreateDto;

      when(
        () => storeRepository.create(storeCreateDto),
      ).thenThrow(Exception('Create store failed'));

      expect(() => authService.createStore(storeCreateDto), throwsException);
    });
  });
}
