part of 'book_admin_form_bloc.dart';

sealed class BookAdminFormState extends Equatable {
  const BookAdminFormState();

  @override
  List<Object> get props => [];
}

final class BookAdminFormInitialState extends BookAdminFormState {}

final class BookAdminFormLoadingState extends BookAdminFormState {}

final class BookAdminFormCreatedState extends BookAdminFormState {
  const BookAdminFormCreatedState(this.book);

  final BookModel book;

  @override
  List<Object> get props => [book];
}

final class BookAdminFormUpdatedState extends BookAdminFormState {
  const BookAdminFormUpdatedState(this.book);

  final BookModel book;

  @override
  List<Object> get props => [book];
}

final class BookAdminFormFailureState extends BookAdminFormState
    with ErrorMessageMixin {
  const BookAdminFormFailureState(this.exception);

  @override
  final Exception exception;

  @override
  List<Object> get props => [exception];
}
