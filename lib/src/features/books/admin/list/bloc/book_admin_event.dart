part of 'book_admin_bloc.dart';

sealed class BookAdminEvent extends Equatable {
  const BookAdminEvent();

  @override
  List<Object> get props => [];
}

class BookAdminGetBooksEvent extends BookAdminEvent {
  const BookAdminGetBooksEvent();
}
