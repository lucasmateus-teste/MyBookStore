part of 'saved_books_bloc.dart';

sealed class SavedBooksState extends Equatable {
  const SavedBooksState();

  @override
  List<Object> get props => [];
}

final class SavedBooksInitial extends SavedBooksState {}

final class SavedBooksLoadingState extends SavedBooksState {}

final class SavedBooksLoadedState extends SavedBooksState {
  const SavedBooksLoadedState(this.books);

  final List<BookModel> books;

  @override
  List<Object> get props => [books];
}

final class SavedBooksFailureState extends SavedBooksState
    with ErrorMessageMixin {
  const SavedBooksFailureState(this.exception);

  @override
  final Exception exception;

  @override
  List<Object> get props => [exception];
}
