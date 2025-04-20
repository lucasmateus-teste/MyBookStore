import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:my_book_store/src/services/book_service.dart';
import 'package:my_book_store/src/services/store_service.dart';
import 'package:my_book_store/src/core/ui/mixins/error_message_mixin.dart';
import 'package:my_book_store/src/data/models/book_model.dart';
import 'package:my_book_store/src/data/models/store_model.dart';

part 'profile_overview_event.dart';
part 'profile_overview_state.dart';

class ProfileOverviewBloc
    extends Bloc<ProfileOverviewEvent, ProfileOverviewState> {
  ProfileOverviewBloc({required this.storeService, required this.bookService})
    : super(ProfileOverviewInitial()) {
    on<ProfileOverviewGetDataEvent>(_onGetDataEvent);
  }

  @protected
  final StoreService storeService;
  @protected
  final BookService bookService;

  Future<void> _onGetDataEvent(
    ProfileOverviewGetDataEvent event,
    Emitter<ProfileOverviewState> emit,
  ) async {
    emit(ProfileOverviewLoading());
    try {
      final store = await storeService.get();
      final savedBooks = <BookModel>[];
      if (!event.isAdmin) {
        savedBooks.addAll(await bookService.getSavedBooks());
      }

      emit(ProfileOverviewLoaded(store: store, savedBooks: savedBooks));
    } catch (e) {
      emit(ProfileOverviewFailure(exception: Exception(e)));
    }
  }
}
