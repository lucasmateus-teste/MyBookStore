part of 'profile_overview_bloc.dart';

sealed class ProfileOverviewState extends Equatable {
  const ProfileOverviewState();

  @override
  List<Object> get props => [];
}

final class ProfileOverviewInitial extends ProfileOverviewState {}

final class ProfileOverviewLoading extends ProfileOverviewState {}

final class ProfileOverviewLoaded extends ProfileOverviewState {
  const ProfileOverviewLoaded({
    required this.store,
    this.savedBooks = const [],
  });

  final StoreModel store;
  final List<BookModel> savedBooks;

  @override
  List<Object> get props => [store, savedBooks];
}

final class ProfileOverviewFailure extends ProfileOverviewState
    with ErrorMessageMixin {
  const ProfileOverviewFailure({required this.exception});

  @override
  final Exception exception;

  @override
  List<Object> get props => [exception];
}
