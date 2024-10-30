import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meopets/src/modules/my-pets/data/my_pets_repository.dart';
import 'package:meopets/src/modules/my-pets/cubit/my_pets_state.dart';

class MyPetsCubit extends Cubit<MyPetsState> {
  final MyPetsRepository myPetsRepository;

  MyPetsCubit({
    required this.myPetsRepository,
  }) : super(
          const MyPetsState(),
        ) {
    getMyPets();
  }

  void getMyPets() async {
    emit(
      state.copyWith(
        status: MyPetsStatus.loading,
      ),
    );

    try {
      final response = await myPetsRepository.getPets();
      emit(
        state.copyWith(
          status: MyPetsStatus.loaded,
          myPets: response,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: MyPetsStatus.error,
        ),
      );
    }
  }
}
