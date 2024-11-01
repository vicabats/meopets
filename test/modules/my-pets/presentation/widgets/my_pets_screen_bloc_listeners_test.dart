import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meopets/src/modules/create-pet/cubit/create_pet_cubit.dart';
import 'package:meopets/src/modules/create-pet/cubit/create_pet_state.dart';
import 'package:meopets/src/modules/my-pet-details/cubit/my_pet_details_cubit.dart';
import 'package:meopets/src/modules/my-pet-details/cubit/my_pet_details_state.dart';
import 'package:meopets/src/modules/my-pets/cubit/my_pets_cubit.dart';
import 'package:meopets/src/modules/my-pets/cubit/my_pets_state.dart';
import 'package:meopets/src/modules/my-pets/presentation/widgets/my_pets_screen_bloc_listeners.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late MyPetsCubit myPetsCubit;
  late MyPetsState myPetsState;

  late MyPetDetailsCubit myPetDetailsCubit;
  late MyPetDetailsState myPetDetailsState;

  late CreatePetCubit createPetCubit;
  late CreatePetState createPetState;

  Future<void> pumpMyPetsScreenBlocListeners(WidgetTester tester) {
    return tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider<MyPetsCubit>.value(value: myPetsCubit),
          BlocProvider<CreatePetCubit>.value(value: createPetCubit),
          BlocProvider<MyPetDetailsCubit>.value(value: myPetDetailsCubit),
        ],
        child: MyPetsScreenBlocListeners(
          child: Container(),
        ),
      ),
    );
  }

  setUp(() {
    createPetCubit = _MockCreatePetCubit();
    createPetState = _MockCreatePetState();
    when(() => createPetState.status).thenReturn(CreatePetStatus.loaded);

    myPetDetailsCubit = _MockMyPetDetailsCubit();
    myPetDetailsState = _MockMyPetDetailsState();
    when(() => myPetDetailsState.status).thenReturn(MyPetDetailsStatus.idle);
    when(() => myPetDetailsCubit.state).thenReturn(myPetDetailsState);

    myPetsCubit = _MockMyPetsCubit();
    myPetsState = _MockMyPetsState();
    when(() => myPetsState.status).thenReturn(MyPetsStatus.loaded);
    when(() => myPetsCubit.state).thenReturn(myPetsState);

    whenListen(
      myPetsCubit,
      Stream<MyPetsState>.value(myPetsState),
      initialState: myPetsState,
    );

    whenListen(
      createPetCubit,
      Stream<CreatePetState>.value(createPetState),
      initialState: createPetState,
    );

    whenListen(
      myPetDetailsCubit,
      Stream<MyPetDetailsState>.value(myPetDetailsState),
      initialState: myPetDetailsState,
    );
  });

  testWidgets(
    "when createPetCubit is emitted with a status successfullyCreated, "
    "then expect to call myPetsCubit.getMyPets",
    (WidgetTester widgetTester) async {
      when(() => createPetState.status)
          .thenReturn(CreatePetStatus.successfullyCreated);

      await pumpMyPetsScreenBlocListeners(widgetTester);

      await widgetTester.pump();

      verify(() => myPetsCubit.getMyPets()).called(1);
    },
  );

  testWidgets(
    "when createPetCubit is emitted with a status different than successfullyCreated, "
    "then expect not to call myPetsCubit.getMyPets",
    (WidgetTester widgetTester) async {
      await pumpMyPetsScreenBlocListeners(widgetTester);

      await widgetTester.pump();

      verifyNever(() => myPetsCubit.getMyPets());
    },
  );

  testWidgets(
    "when myPetDetailsCubit is emitted with a status successfullyRemoved, "
    "then expect to call myPetsCubit.getMyPets",
    (WidgetTester widgetTester) async {
      when(() => myPetDetailsState.status)
          .thenReturn(MyPetDetailsStatus.successfullyRemoved);
      when(() => myPetDetailsState.status)
          .thenReturn(MyPetDetailsStatus.successfullyRemoved);

      await pumpMyPetsScreenBlocListeners(widgetTester);

      await widgetTester.pump();

      verify(() => myPetsCubit.getMyPets()).called(1);
    },
  );

  testWidgets(
    "when myPetDetailsCubit is emitted with a status different than successfullyRemoved, "
    "then expect not to call myPetsCubit.getMyPets",
    (WidgetTester widgetTester) async {
      await pumpMyPetsScreenBlocListeners(widgetTester);

      await widgetTester.pump();

      verifyNever(() => myPetsCubit.getMyPets());
    },
  );
}

class _MockCreatePetCubit extends Mock implements CreatePetCubit {}

class _MockCreatePetState extends Mock implements CreatePetState {}

class _MockMyPetsCubit extends Mock implements MyPetsCubit {}

class _MockMyPetsState extends Mock implements MyPetsState {}

class _MockMyPetDetailsCubit extends Mock implements MyPetDetailsCubit {}

class _MockMyPetDetailsState extends Mock implements MyPetDetailsState {}
