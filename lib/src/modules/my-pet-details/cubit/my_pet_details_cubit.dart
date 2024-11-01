import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meopets/src/modules/my-pet-details/cubit/my_pet_details_state.dart';
import 'package:meopets/src/modules/my-pet-details/data/my_pet_details_repository.dart';

class MyPetDetailsCubit extends Cubit<MyPetDetailsState> {
  final MyPetDetailsRepository myPetDetailsRepository;

  MyPetDetailsCubit({
    required this.myPetDetailsRepository,
  }) : super(const MyPetDetailsState());

  Future<void> removePet(int petId) async {
    emit(
      state.copyWith(
        status: MyPetDetailsStatus.loading,
      ),
    );

    try {
      await myPetDetailsRepository.removePet(petId);
      emit(
        state.copyWith(
          status: MyPetDetailsStatus.successfullyRemoved,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: MyPetDetailsStatus.error,
        ),
      );
    }
  }
}
