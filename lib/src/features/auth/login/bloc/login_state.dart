part of 'login_bloc.dart';

sealed class LoginState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {
  LoginSuccessState(this.authenticatedUser);

  final UserModel authenticatedUser;

  @override
  List<Object?> get props => [authenticatedUser];
}

class LoginFailureState extends LoginState {
  final Exception error;

  LoginFailureState(this.error);

  @override
  List<Object?> get props => [error];

  String get message {
    final error = this.error;

    if (error is MyBookStoreException) {
      return error.message;
    }
    return error.toString();
  }
}
