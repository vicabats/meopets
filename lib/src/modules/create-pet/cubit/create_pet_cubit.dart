import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meopets/src/modules/create-pet/data/create_pet_repository.dart';
import 'package:meopets/src/modules/create-pet/cubit/create_pet_state.dart';
import 'package:meopets/src/shared/entities/my_pet_entity.dart';

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
      final MyPet pet = MyPet(
        name: petData['name']!,
        type: petData['type']!,
        description: petData['description']!,
        imageUrl: petData['imageUrl']!,
        birthDate: petData['birthDate']!,
      );

      await createPetRepository.createPet(pet);
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
