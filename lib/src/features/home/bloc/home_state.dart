part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeLoaded extends HomeState {
  const HomeLoaded(this.books);

  final List<BookModel> books;

  List<BookModel> get savedBooks {
    return books.where((book) => book.isSaved).toList();
  }

  @override
  List<Object> get props => [books];
}

final class HomeFailure extends HomeState with ErrorMessageMixin {
  const HomeFailure(this.exception);

  @override
  final Exception exception;

  @override
  List<Object> get props => [exception];
}
