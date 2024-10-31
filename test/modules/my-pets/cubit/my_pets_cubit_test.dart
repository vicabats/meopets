import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meopets/src/modules/my-pets/cubit/my_pets_cubit.dart';
import 'package:meopets/src/modules/my-pets/cubit/my_pets_state.dart';
import 'package:meopets/src/modules/my-pets/data/my_pets_repository.dart';
import 'package:meopets/src/shared/models/my_pet_model.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late MyPetsCubit myPetsCubit;
  late MyPetsRepository myPetsRepository;

  late List<MyPetModel> pets;

  group("MyPetsCubit /", () {
    void act(MyPetsCubit myPetsCubit) => myPetsCubit.getMyPets();

    setUp(() {
      myPetsRepository = _MockMyPetsRepository();

      myPetsCubit = MyPetsCubit(
        myPetsRepository: myPetsRepository,
      );

      pets = [
        _MockMyPetModel(),
        _MockMyPetModel(),
      ];
    });

    blocTest<MyPetsCubit, MyPetsState>(
      "when instantiated, "
      "then expect initial state to be MyPetsStatus.loading",
      setUp: () {
        when(() => myPetsRepository.getPets()).thenAnswer(
          (_) => Future.delayed(const Duration(milliseconds: 10), () => pets),
        );
      },
      build: () => MyPetsCubit(myPetsRepository: myPetsRepository),
      verify: (cubit) {
        expect(
          cubit.state,
          const MyPetsState(
            status: MyPetsStatus.loading,
          ),
        );
      },
    );

    group("getMyPets /", () {
      blocTest(
        "given myPetsRepository.getPets call returns a success, "
        "when myPetsCubit.getMyPets is added, "
        "then expect to emit MyPetsStatus.loaded and pets",
        setUp: () {
          when(() => myPetsRepository.getPets()).thenAnswer(
            (_) => Future<List<MyPetModel>>.value(pets),
          );
        },
        build: () => myPetsCubit,
        act: act,
        expect: () => <MyPetsState>[
          const MyPetsState(
            status: MyPetsStatus.loading,
          ),
          MyPetsState(
            status: MyPetsStatus.loaded,
            myPets: pets,
          ),
        ],
      );

      blocTest(
        "given myPetsRepository.getPets call returns an error, "
        "when myPetsCubit.getMyPets is added, "
        "then expect to emit MyPetsStatus.error",
        setUp: () {
          when(() => myPetsRepository.getPets()).thenThrow(
            Exception(),
          );
        },
        build: () => myPetsCubit,
        act: act,
        expect: () => <MyPetsState>[
          const MyPetsState(
            status: MyPetsStatus.loading,
          ),
          const MyPetsState(
            status: MyPetsStatus.error,
          ),
        ],
      );
    });
  });
}

class _MockMyPetsRepository extends Mock implements MyPetsRepository {}

class _MockMyPetModel extends Mock implements MyPetModel {}
