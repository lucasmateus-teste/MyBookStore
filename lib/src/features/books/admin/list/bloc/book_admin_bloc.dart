import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:my_book_store/src/services/book_service.dart';
import 'package:my_book_store/src/core/ui/mixins/error_message_mixin.dart';
import 'package:my_book_store/src/data/models/book_model.dart';

part 'book_admin_event.dart';
part 'book_admin_state.dart';

class BookAdminBloc extends Bloc<BookAdminEvent, BookAdminState> {
  BookAdminBloc({required this.bookService}) : super(BookAdminInitial()) {
    on<BookAdminGetBooksEvent>(_onBookAdminGetBooksEvent);
  }

  @protected
  final BookService bookService;

  Future<void> _onBookAdminGetBooksEvent(
    BookAdminGetBooksEvent event,
    Emitter<BookAdminState> emit,
  ) async {
    emit(BookAdminLoadingState());
    try {
      final books = await bookService.getBooks();
      emit(BookAdminLoadedState(books));
    } on Exception catch (e) {
      emit(BookAdminFailureState(e));
    }
  }
}
