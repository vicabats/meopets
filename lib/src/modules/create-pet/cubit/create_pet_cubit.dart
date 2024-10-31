import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meopets/src/modules/create-pet/data/create_pet_repository.dart';
import 'package:meopets/src/modules/create-pet/cubit/create_pet_state.dart';

class CreatePetCubit extends Cubit<CreatePetState> {
  final CreatePetRepository createPetRepository;

  CreatePetCubit({
    required this.createPetRepository,
  }) : super(const CreatePetState());

  Future<void> createPet(Map<String, dynamic> petData) async {
    emit(
      state.copyWith(
        status: CreatePetStatus.loading,
      ),
    );

    try {
      await createPetRepository.createPet(petData);
      emit(
        state.copyWith(
          status: CreatePetStatus.successfullyCreated,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: CreatePetStatus.error,
        ),
      );
    }
  }
}
