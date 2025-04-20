part of 'book_details_bloc.dart';

sealed class BookDetailsState extends Equatable {
  const BookDetailsState(this.book);

  final BookModel book;

  @override
  List<Object> get props => [book];
}

final class BookDetailsInitial extends BookDetailsState {
  const BookDetailsInitial(super.book);
}

final class BookDetailsLoadingState extends BookDetailsState {
  const BookDetailsLoadingState(super.book);
}

final class BookDetailsLoadedState extends BookDetailsState {
  const BookDetailsLoadedState(super.book);
}

final class BookDetailsFailureState extends BookDetailsState
    with ErrorMessageMixin {
  BookDetailsFailureState(this.exception, super.book);

  @override
  final Exception exception;

  @override
  List<Object> get props => [exception, super.book];
}

class BookDetailsDeletedState extends BookDetailsState {
  const BookDetailsDeletedState(super.book);
}
