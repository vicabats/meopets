import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meopets/src/modules/create-pet/cubit/create_pet_cubit.dart';
import 'package:meopets/src/modules/create-pet/cubit/create_pet_state.dart';
import 'package:meopets/src/modules/create-pet/presentation/screens/create_pet_screen.dart';
import 'package:meopets/src/modules/my-pet-details/cubit/my_pet_details_cubit.dart';
import 'package:meopets/src/modules/my-pet-details/cubit/my_pet_details_state.dart';
import 'package:meopets/src/modules/my-pet-details/presentation/screens/my_pet_details_screen.dart';
import 'package:meopets/src/modules/my-pets/cubit/my_pets_cubit.dart';
import 'package:meopets/src/modules/my-pets/cubit/my_pets_state.dart';
import 'package:meopets/src/modules/my-pets/presentation/screens/my_pets_screen.dart';
import 'package:meopets/src/modules/my-pets/presentation/widgets/my_pet_card_widget.dart';
import 'package:meopets/src/modules/my-pets/presentation/widgets/my_pets_grid_widget.dart';
import 'package:meopets/src/modules/my-pets/presentation/widgets/my_pets_screen_bloc_listeners.dart';
import 'package:meopets/src/shared/entities/my_pet_entity.dart';
import 'package:meopets/src/shared/widgets/custom_app_bar.dart';
import 'package:meopets/src/shared/widgets/loading_component.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';

void main() {
  late MyPetsCubit myPetsCubit;
  late MyPetsState myPetsState;

  late CreatePetCubit createPetCubit;
  late CreatePetState createPetState;

  late MyPetDetailsCubit myPetDetailsCubit;
  late MyPetDetailsState myPetDetailsState;

  late List<MyPet> myPets;

  late NavigatorObserver navigatorObserver;

  Future<void> pumpMyPetsScreen(WidgetTester tester) async {
    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider.value(value: myPetsCubit),
          BlocProvider.value(value: createPetCubit),
          BlocProvider.value(value: myPetDetailsCubit),
        ],
        child: MaterialApp(
          home: const Scaffold(
            body: MyPetsScreen(),
          ),
          routes: {
            '/create-pet': (context) => const CreatePetScreen(),
            '/pet-details': (context) => const MyPetDetailsScreen(),
          },
          navigatorObservers: [navigatorObserver],
        ),
      ),
    );
  }

  group("MyPetsScreen /", () {
    setUp(() {
      myPetsCubit = _MockMyPetsCubit();
      myPetsState = _MockMyPetsState();
      when(() => myPetsState.status).thenReturn(MyPetsStatus.loading);
      when(() => myPetsState.myPets).thenReturn([]);

      myPetDetailsCubit = _MockMyPetDetailsCubit();
      myPetDetailsState = _MockMyPetDetailsState();
      when(() => myPetDetailsState.status).thenReturn(MyPetDetailsStatus.idle);

      createPetCubit = _MockCreatePetCubit();
      createPetState = _MockCreatePetState();
      when(() => createPetState.status).thenReturn(CreatePetStatus.loaded);

      myPets = [
        _MockMyPet(),
        _MockMyPet(),
      ];

      whenListen(
        myPetsCubit,
        const Stream<MyPetsState>.empty(),
        initialState: myPetsState,
      );

      whenListen(
        createPetCubit,
        const Stream<CreatePetState>.empty(),
        initialState: createPetState,
      );

      whenListen(
        myPetDetailsCubit,
        const Stream<MyPetDetailsState>.empty(),
        initialState: myPetDetailsState,
      );

      navigatorObserver = _MockNavigatorObserver();
      registerFallbackValue(_FakeRoute());
    });

    testWidgets(
        "when pumped, "
        "then expect to find MyPetsScreenBlocListener", (tester) async {
      await mockNetworkImagesFor(() async {
        await pumpMyPetsScreen(tester);

        final myPetsScreenBlocListener = find.byType(MyPetsScreenBlocListeners);

        expect(myPetsScreenBlocListener, findsOneWidget);
      });
    });

    testWidgets(
        "given status is MyPetsState.loading, "
        "when pumped, "
        "then expect to find LoadingComponent", (tester) async {
      await mockNetworkImagesFor(() async {
        await pumpMyPetsScreen(tester);

        final loadingComponent = find.byType(LoadingComponent);
        expect(loadingComponent, findsOneWidget);
      });
    });

    group("given status is MyPetsState.loaded /", () {
      setUp(() {
        when(() => myPetsState.status).thenReturn(MyPetsStatus.loaded);
        when(() => myPetsState.myPets).thenReturn(myPets);
      });

      testWidgets(
        "when pumped, "
        "then expect to find CustomAppBar",
        (tester) async {
          await mockNetworkImagesFor(() async {
            await pumpMyPetsScreen(tester);

            final customAppBar = find.byType(CustomAppBar);
            expect(customAppBar, findsOneWidget);
          });
        },
      );

      group("MyPetsGridWidget /", () {
        testWidgets(
          "when pumped, "
          "then expect to find MyPetsGridWidget",
          (tester) async {
            await mockNetworkImagesFor(() async {
              await pumpMyPetsScreen(tester);

              final myPetsGridWidget = find.byType(MyPetsGridWidget);
              expect(myPetsGridWidget, findsOneWidget);
            });
          },
        );

        testWidgets(
          "when a card is clicked, then expect to call Navigator.of.pushNamed('/pet-details')",
          (tester) async {
            await mockNetworkImagesFor(() async {
              await pumpMyPetsScreen(tester);

              final petCard = find.byType(MyPetCardWidget).first;
              await tester.tap(petCard);

              await tester.pumpAndSettle();

              final capturedRoutes =
                  verify(() => navigatorObserver.didPush(captureAny(), any()))
                      .captured;
              expect(capturedRoutes.last.settings.name, '/pet-details');
            });
          },
        );
      });

      group("FloatingActionButton /", () {
        testWidgets(
            "when pumped, "
            "then expect to find FloatingActionButton", (tester) async {
          await mockNetworkImagesFor(() async {
            await pumpMyPetsScreen(tester);

            final floatingActionButton = find.byType(FloatingActionButton);
            expect(floatingActionButton, findsOneWidget);
          });
        });

        testWidgets(
          "when clicked, then expect to call Navigator.of.pushNamed(/create-pet)",
          (tester) async {
            await mockNetworkImagesFor(() async {
              await pumpMyPetsScreen(tester);

              final floatingActionButton = find.byType(FloatingActionButton);
              await tester.tap(floatingActionButton);

              await tester.pumpAndSettle();

              final capturedRoutes = verify(
                () => navigatorObserver.didPush(
                  captureAny(),
                  any(),
                ),
              ).captured;
              expect(
                capturedRoutes.last.settings.name,
                '/create-pet',
              );
            });
          },
        );
      });
    });
  });
}

class _MockMyPetsCubit extends Mock implements MyPetsCubit {}

class _MockCreatePetCubit extends Mock implements CreatePetCubit {}

class _MockNavigatorObserver extends Mock implements NavigatorObserver {}

class _FakeRoute extends Fake implements Route {}

class _MockMyPetsState extends Mock implements MyPetsState {}

class _MockMyPetDetailsCubit extends Mock implements MyPetDetailsCubit {}

class _MockMyPetDetailsState extends Mock implements MyPetDetailsState {}

class _MockMyPet extends Mock implements MyPet {
  _MockMyPet() {
    when(() => id).thenReturn(1);
    when(() => name).thenReturn('Bobby');
    when(() => imageUrl).thenReturn("https://www.image.com");
    when(() => birthDate).thenReturn(DateTime.parse('2021-01-01'));
    when(() => description).thenReturn('Description');
    when(() => type).thenReturn('Dog');
  }
}

class _MockCreatePetState extends Mock implements CreatePetState {}
