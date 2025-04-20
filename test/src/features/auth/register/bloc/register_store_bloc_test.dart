import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_book_store/src/services/auth_service.dart';
import 'package:my_book_store/src/data/dtos/store_create_dto.dart';
import 'package:my_book_store/src/features/auth/register/bloc/register_store_bloc.dart';

import '../../../../../mocks/app_mocks.dart';
import '../../../../../mocks/service_mocks.dart';

void main() {
  late AuthService authService;
  late RegisterStoreBloc bloc;
  late StoreCreateDto storeCreateDto;

  setUp(() {
    authService = MockAuthService();
    bloc = RegisterStoreBloc(authService: authService);
    storeCreateDto = AppMocks.storeCreateDto;
  });

  group('RegisterBloc', () {
    blocTest<RegisterStoreBloc, RegisterStoreState>(
      'Emits RegisterStoreSuccessState when store is created successfully',
      build: () {
        when(
          () => authService.createStore(storeCreateDto),
        ).thenAnswer((_) async => AppMocks.auth);
        return bloc;
      },
      act: (bloc) => bloc.add(RegisterStoreSubmit(store: storeCreateDto)),
      expect:
          () => [
            isA<RegisterStoreLoadingState>(),
            isA<RegisterStoreSuccessState>(),
          ],
    );
  });
  blocTest<RegisterStoreBloc, RegisterStoreState>(
    'Emits RegisterStoreFailureState when throw an exception',
    build: () {
      when(
        () => authService.createStore(storeCreateDto),
      ).thenThrow(Exception());
      return bloc;
    },
    act: (bloc) => bloc.add(RegisterStoreSubmit(store: storeCreateDto)),
    expect:
        () => [
          isA<RegisterStoreLoadingState>(),
          isA<RegisterStoreFailureState>(),
        ],
  );
}
