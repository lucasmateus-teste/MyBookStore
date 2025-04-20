import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:my_book_store/src/services/book_service.dart';
import 'package:my_book_store/src/core/ui/mixins/error_message_mixin.dart';
import 'package:my_book_store/src/data/models/book_model.dart';

part 'saved_books_event.dart';
part 'saved_books_state.dart';

class SavedBooksBloc extends Bloc<SavedBooksEvent, SavedBooksState> {
  SavedBooksBloc({required this.bookService}) : super(SavedBooksInitial()) {
    on<SavedBooksGetBooksEvent>(_onSavedBooksGetBooksEvent);
  }

  @protected
  final BookService bookService;

  Future<void> _onSavedBooksGetBooksEvent(
    SavedBooksGetBooksEvent event,
    Emitter<SavedBooksState> emit,
  ) async {
    emit(SavedBooksLoadingState());
    try {
      final books = await bookService.getSavedBooks();
      emit(SavedBooksLoadedState(books));
    } on Exception catch (e) {
      emit(SavedBooksFailureState(e));
    }
  }
}
