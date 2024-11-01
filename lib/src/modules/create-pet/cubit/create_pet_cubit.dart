import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meopets/src/modules/create-pet/data/create_pet_repository.dart';
import 'package:meopets/src/modules/create-pet/cubit/create_pet_state.dart';
import 'package:meopets/src/modules/create-pet/presentation/widgets/types/form_field_data.dart';

class CreatePetCubit extends Cubit<CreatePetState> {
  final CreatePetRepository createPetRepository;

  CreatePetCubit({
    required this.createPetRepository,
  }) : super(const CreatePetState());

  Future<void> createPet(List<FormFieldData> formFieldData) async {
    emit(
      state.copyWith(
        status: CreatePetStatus.loading,
      ),
    );

    try {
      final Map<String, dynamic> formData = {
        for (var item in formFieldData) item['key']: item['value']
      };

      await createPetRepository.createPet(formData);

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
