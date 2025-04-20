part of 'saved_books_bloc.dart';

sealed class SavedBooksEvent extends Equatable {
  const SavedBooksEvent();

  @override
  List<Object> get props => [];
}

class SavedBooksGetBooksEvent extends SavedBooksEvent {
  const SavedBooksGetBooksEvent();
}
