part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginSubmit extends LoginEvent {
  final CredentialsModel credentials;

  LoginSubmit({required this.credentials});

  @override
  List<Object?> get props => [credentials];
}
