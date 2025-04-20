part of 'register_store_bloc.dart';

sealed class RegisterStoreState extends Equatable {}

final class RegisterStoreInitialState extends RegisterStoreState {
  @override
  List<Object> get props => [];
}

final class RegisterStoreLoadingState extends RegisterStoreState {
  @override
  List<Object> get props => [];
}

final class RegisterStoreSuccessState extends RegisterStoreState {
  RegisterStoreSuccessState(this.authenticatedUser);

  final AdminModel authenticatedUser;

  @override
  List<Object> get props => [authenticatedUser];
}

final class RegisterStoreFailureState extends RegisterStoreState {
  RegisterStoreFailureState(this.error);

  final Exception error;

  @override
  List<Object> get props => [error];

  String get message {
    final error = this.error;

    if (error is MyBookStoreException) {
      return error.message;
    }
    return error.toString();
  }
}
