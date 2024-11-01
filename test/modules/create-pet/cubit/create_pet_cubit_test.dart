import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meopets/src/modules/create-pet/cubit/create_pet_cubit.dart';
import 'package:meopets/src/modules/create-pet/cubit/create_pet_state.dart';
import 'package:meopets/src/modules/create-pet/data/create_pet_repository.dart';
import 'package:meopets/src/modules/create-pet/presentation/widgets/types/form_field_data.dart';
import 'package:meopets/src/shared/models/my_pet_model.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late CreatePetCubit createPetCubit;
  late CreatePetRepository createPetRepository;

  late MyPetModel petModel;
  late Map<String, dynamic> petObject;
  late List<FormFieldData> createPetformFields;

  const petName = "name";
  const petType = "type";
  const petDescription = "description";
  const petImageUrl = "imageUrl";
  final petBirthDate = DateTime.now();

  group("CreatePetCubit /", () {
    void act(CreatePetCubit createPetCubit) =>
        createPetCubit.createPet(createPetformFields);

    setUp(() {
      createPetRepository = _MockCreatePetRepository();

      createPetCubit = CreatePetCubit(
        createPetRepository: createPetRepository,
      );

      petModel = _MockMyPetModel();
      createPetformFields = [
        {
          "key": "name",
          "value": petName,
        },
        {
          "key": "type",
          "value": petType,
        },
        {
          "key": "description",
          "value": petDescription,
        },
        {
          "key": "imageUrl",
          "value": petImageUrl,
        },
        {
          "key": "birthDate",
          "value": petBirthDate,
        },
      ];

      petObject = {
        "name": petName,
        "type": petType,
        "description": petDescription,
        "imageUrl": petImageUrl,
        "birthDate": petBirthDate,
      };
    });

    test(
      "when instanciated, "
      "then expect initial state to be CreatePetStatus.loaded",
      () {
        expect(
          createPetCubit.state,
          const CreatePetState(
            status: CreatePetStatus.loaded,
          ),
        );
      },
    );

    group("createPet /", () {
      blocTest(
        "given createPetRepository.createPet call returns a success, "
        "when createPetCubit.createPet is added, "
        "then expect to emit CreatePetStatus.successfullyCreated",
        setUp: () {
          when(() => createPetRepository.createPet(petObject)).thenAnswer(
            (_) => Future<MyPetModel>.value(petModel),
          );
        },
        build: () => createPetCubit,
        act: act,
        expect: () => <CreatePetState>[
          const CreatePetState(
            status: CreatePetStatus.loading,
          ),
          const CreatePetState(
            status: CreatePetStatus.successfullyCreated,
          ),
        ],
        verify: (_) {
          verify(() => createPetRepository.createPet(petObject)).called(1);
        },
      );

      blocTest(
        "given createPetRepository.createPet call returns a failure, "
        "when createPetCubit.createPet is added, "
        "then expect to emit CreatePetStatus.error",
        setUp: () {
          when(() => createPetRepository.createPet(petObject)).thenThrow(
            Exception("error"),
          );
        },
        build: () => createPetCubit,
        act: act,
        expect: () => <CreatePetState>[
          const CreatePetState(
            status: CreatePetStatus.loading,
          ),
          const CreatePetState(
            status: CreatePetStatus.error,
          ),
        ],
        verify: (_) {
          verify(() => createPetRepository.createPet(petObject)).called(1);
        },
      );
    });
  });
}

class _MockCreatePetRepository extends Mock implements CreatePetRepository {}

class _MockMyPetModel extends Mock implements MyPetModel {
  _MockMyPetModel() {
    when(() => name).thenReturn("name");
    when(() => type).thenReturn("type");
    when(() => description).thenReturn("description");
    when(() => imageUrl).thenReturn("imageUrl");
    when(() => birthDate).thenReturn(DateTime.now());
  }
}
