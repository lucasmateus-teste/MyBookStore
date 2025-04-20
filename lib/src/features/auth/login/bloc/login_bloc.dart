import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_book_store/src/core/exceptions/my_book_store_exceptions.dart';
import 'package:my_book_store/src/services/auth_service.dart';
import 'package:my_book_store/src/data/models/credentials_model.dart';
import 'package:my_book_store/src/data/models/user/user_model.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({required this.authService}) : super(LoginInitialState()) {
    on<LoginSubmit>(_onLoginSubmit);
  }

  final AuthService authService;

  Future<void> _onLoginSubmit(
    LoginSubmit event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoadingState());
    try {
      final authModel = await authService.login(event.credentials);
      emit(LoginSuccessState(authModel.user));
    } on Exception catch (e) {
      emit(LoginFailureState(e));
    }
  }
}
