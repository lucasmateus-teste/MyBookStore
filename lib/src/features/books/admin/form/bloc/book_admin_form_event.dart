part of 'book_admin_form_bloc.dart';

sealed class BookAdminFormEvent extends Equatable {
  const BookAdminFormEvent();

  @override
  List<Object> get props => [];
}

class BookAdminFormCreateEvent extends BookAdminFormEvent {
  const BookAdminFormCreateEvent({required this.book});

  final BookModel book;

  @override
  List<Object> get props => [book];
}

class BookAdminFormUpdateEvent extends BookAdminFormEvent {
  const BookAdminFormUpdateEvent({required this.book});

  final BookModel book;

  @override
  List<Object> get props => [book];
}
