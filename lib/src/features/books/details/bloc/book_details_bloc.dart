import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_book_store/src/services/book_service.dart';
import 'package:my_book_store/src/core/ui/mixins/error_message_mixin.dart';
import 'package:my_book_store/src/data/models/book_model.dart';

part 'book_details_event.dart';
part 'book_details_state.dart';

class BookDetailsBloc extends Bloc<BookDetailsEvent, BookDetailsState> {
  BookDetailsBloc({required BookModel book, required this.bookService})
    : super(BookDetailsInitial(book)) {
    on<BookDetailsChangeIsAvailableEvent>(_onChangeIsAvailableEvent);
    on<BookDetailsChangeRatingEvent>(_onChangeRatingEvent);
    on<BookDetailsChangeIsSavedEvent>(_onChangeIsSavedEvent);
    on<BookDetailsBookChangedEvent>(_onBookIsChangedEvent);
    on<BookDetailsDeleteBookEvent>(_onDeleteBookEvent);
  }

  @protected
  final BookService bookService;

  Future<void> _onChangeIsAvailableEvent(
    BookDetailsChangeIsAvailableEvent event,
    Emitter<BookDetailsState> emit,
  ) async {
    final oldAvailable = state.book.available;
    try {
      final book = state.book.copyWith(available: !state.book.available);
      bookService.updateBook(book);
      emit(BookDetailsLoadedState(book));
    } on Exception catch (e) {
      final book = state.book.copyWith(available: oldAvailable);
      emit(BookDetailsFailureState(e, book));
    }
  }

  Future<void> _onChangeRatingEvent(
    BookDetailsChangeRatingEvent event,
    Emitter<BookDetailsState> emit,
  ) async {
    final oldRating = state.book.rating;
    try {
      final book = state.book.copyWith(rating: event.rating);
      bookService.updateBook(book);
      emit(BookDetailsLoadedState(book));
    } on Exception catch (e) {
      final book = state.book.copyWith(rating: oldRating);
      emit(BookDetailsFailureState(e, book));
    }
  }

  Future<void> _onChangeIsSavedEvent(
    BookDetailsChangeIsSavedEvent event,
    Emitter<BookDetailsState> emit,
  ) async {
    try {
      final book = state.book.copyWith(isSaved: !state.book.isSaved);
      if (book.isSaved) {
        await bookService.save(book);
      } else {
        await bookService.removeSaved(book);
      }
      emit(BookDetailsLoadedState(book));
    } on Exception catch (e) {
      emit(BookDetailsFailureState(e, state.book));
    }
  }

  Future<void> _onDeleteBookEvent(
    BookDetailsDeleteBookEvent event,
    Emitter<BookDetailsState> emit,
  ) async {
    try {
      await bookService.delete(event.book);
      emit(BookDetailsDeletedState(event.book));
    } on Exception catch (e) {
      emit(BookDetailsFailureState(e, event.book));
    }
  }

  void _onBookIsChangedEvent(
    BookDetailsBookChangedEvent event,
    Emitter<BookDetailsState> emit,
  ) {
    emit(BookDetailsLoadedState(event.book));
  }
}
