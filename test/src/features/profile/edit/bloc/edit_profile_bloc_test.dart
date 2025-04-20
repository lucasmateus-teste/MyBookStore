import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_book_store/src/data/models/store_model.dart';
import 'package:my_book_store/src/data/repositories/store/store_repository.dart';
import 'package:my_book_store/src/features/profile/edit/bloc/edit_profile_bloc.dart';

import '../../../../../mocks/app_mocks.dart';
import '../../../../../mocks/repository_mocks.dart';

void main() {
  late StoreRepository storeRepository;
  late EditProfileBloc bloc;
  late StoreModel store;

  setUpAll(() {
    registerFallbackValue(AppMocks.store);
  });

  setUp(() {
    storeRepository = MockStoreRepository();
    bloc = EditProfileBloc(storeRepository: storeRepository);
    store = AppMocks.store;
  });

  group('EditProfileBloc', () {
    blocTest<EditProfileBloc, EditProfileState>(
      'Emits EditProfileSuccess when profile is updated successfully',
      build: () {
        when(
          () => storeRepository.update(any()),
        ).thenAnswer((_) async => Future.value());
        return bloc;
      },
      act: (bloc) => bloc.add(EditProfileUpdateEvent(store: store)),
      expect: () => [isA<EditProfileLoading>(), isA<EditProfileSuccess>()],
    );

    blocTest<EditProfileBloc, EditProfileState>(
      'Emits EditProfileFailure when updating profile fails',
      build: () {
        when(
          () => storeRepository.update(any()),
        ).thenThrow(Exception('Error updating profile'));
        return bloc;
      },
      act: (bloc) => bloc.add(EditProfileUpdateEvent(store: store)),
      expect: () => [isA<EditProfileLoading>(), isA<EditProfileFailure>()],
    );
  });
}
