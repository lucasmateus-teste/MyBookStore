import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:my_book_store/src/services/book_service.dart';
import 'package:my_book_store/src/core/ui/mixins/error_message_mixin.dart';
import 'package:my_book_store/src/data/models/book_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({required this.bookService}) : super(HomeInitial()) {
    on<HomeGetBooks>(_onHomeGetBooks);
  }

  @protected
  final BookService bookService;

  Future<void> _onHomeGetBooks(
    HomeGetBooks event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());
    try {
      final books = await bookService.getBooks();
      emit(HomeLoaded(books));
    } on Exception catch (e) {
      emit(HomeFailure(e));
    }
  }
}
