import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:my_book_store/src/services/book_service.dart';
import 'package:my_book_store/src/core/ui/mixins/error_message_mixin.dart';
import 'package:my_book_store/src/data/models/book_model.dart';

part 'book_admin_form_event.dart';
part 'book_admin_form_state.dart';

class BookAdminFormBloc extends Bloc<BookAdminFormEvent, BookAdminFormState> {
  BookAdminFormBloc({required this.bookService})
    : super(BookAdminFormInitialState()) {
    on<BookAdminFormUpdateEvent>(_onFormUpdateBookEvent);
    on<BookAdminFormCreateEvent>(_onFormCreateBookEvent);
  }

  @protected
  final BookService bookService;

  Future<void> _onFormUpdateBookEvent(
    BookAdminFormUpdateEvent event,
    Emitter<BookAdminFormState> emit,
  ) async {
    emit(BookAdminFormLoadingState());
    try {
      await bookService.updateBook(event.book);
      emit(BookAdminFormUpdatedState(event.book));
    } on Exception catch (e) {
      emit(BookAdminFormFailureState(e));
    }
  }

  Future<void> _onFormCreateBookEvent(
    BookAdminFormCreateEvent event,
    Emitter<BookAdminFormState> emit,
  ) async {
    emit(BookAdminFormLoadingState());
    try {
      final book = await bookService.create(event.book);
      emit(BookAdminFormCreatedState(book));
    } on Exception catch (e) {
      emit(BookAdminFormFailureState(e));
    }
  }
}
