part of 'book_admin_bloc.dart';

sealed class BookAdminState extends Equatable {
  const BookAdminState();

  @override
  List<Object> get props => [];
}

final class BookAdminInitial extends BookAdminState {}

final class BookAdminLoadingState extends BookAdminState {}

final class BookAdminLoadedState extends BookAdminState {
  const BookAdminLoadedState(this.books);

  final List<BookModel> books;

  @override
  List<Object> get props => [books];
}

final class BookAdminFailureState extends BookAdminState
    with ErrorMessageMixin {
  const BookAdminFailureState(this.exception);

  @override
  final Exception exception;

  @override
  List<Object> get props => [exception];
}
