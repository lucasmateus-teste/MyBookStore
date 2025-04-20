import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_book_store/src/core/exceptions/my_book_store_exceptions.dart';
import 'package:my_book_store/src/services/auth_service.dart';
import 'package:my_book_store/src/data/models/credentials_model.dart';
import 'package:my_book_store/src/features/auth/login/bloc/login_bloc.dart';

import '../../../../../mocks/app_mocks.dart';
import '../../../../../mocks/service_mocks.dart';

void main() {
  late AuthService authService;
  late LoginBloc bloc;
  late CredentialsModel credentials;

  setUp(() {
    authService = MockAuthService();
    bloc = LoginBloc(authService: authService);
    credentials = CredentialsModel(
      user: 'julio.bitencourt',
      password: '8ec4sJ7dx!*d',
    );
  });

  tearDown(() {
    bloc.close();
  });

  group('LoginBloc', () {
    blocTest<LoginBloc, LoginState>(
      'Emits LoginSuccessState when authenticated with successful',
      build: () {
        when(
          () => authService.login(credentials),
        ).thenAnswer((_) async => AppMocks.auth);
        return bloc;
      },
      act: (bloc) => bloc.add(LoginSubmit(credentials: credentials)),
      expect: () => [isA<LoginLoadingState>(), isA<LoginSuccessState>()],
    );
  });

  blocTest<LoginBloc, LoginState>(
    'Emits LoginFailureState when authentication fails',
    build: () {
      when(
        () => authService.login(credentials),
      ).thenThrow(Exception('Login failed'));
      return bloc;
    },
    act: (bloc) => bloc.add(LoginSubmit(credentials: credentials)),
    expect: () => [isA<LoginLoadingState>(), isA<LoginFailureState>()],
  );
  blocTest<LoginBloc, LoginState>(
    'Emits LoginFailureState when credentials are invalid',
    build: () {
      when(
        () => authService.login(credentials),
      ).thenThrow(AuthUnauthorizedException());
      return bloc;
    },
    act: (bloc) => bloc.add(LoginSubmit(credentials: credentials)),
    expect: () => [isA<LoginLoadingState>(), isA<LoginFailureState>()],
  );
}
