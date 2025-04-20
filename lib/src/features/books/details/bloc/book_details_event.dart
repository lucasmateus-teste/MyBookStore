part of 'book_details_bloc.dart';

sealed class BookDetailsEvent extends Equatable {
  const BookDetailsEvent();

  @override
  List<Object> get props => [];
}

class BookDetailsChangeRatingEvent extends BookDetailsEvent {
  const BookDetailsChangeRatingEvent({required this.rating});

  final int rating;
}

class BookDetailsChangeIsAvailableEvent extends BookDetailsEvent {
  const BookDetailsChangeIsAvailableEvent();
}

class BookDetailsChangeIsSavedEvent extends BookDetailsEvent {
  const BookDetailsChangeIsSavedEvent();
}

class BookDetailsBookChangedEvent extends BookDetailsEvent {
  const BookDetailsBookChangedEvent(this.book);

  final BookModel book;

  @override
  List<Object> get props => [book];
}

class BookDetailsDeleteBookEvent extends BookDetailsEvent {
  const BookDetailsDeleteBookEvent(this.book);

  final BookModel book;

  @override
  List<Object> get props => [book];
}
