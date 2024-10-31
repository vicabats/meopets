import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meopets/src/modules/create-pet/cubit/create_pet_cubit.dart';
import 'package:meopets/src/modules/create-pet/cubit/create_pet_state.dart';
import 'package:meopets/src/modules/create-pet/presentation/screens/create_pet_screen.dart';
import 'package:meopets/src/modules/create-pet/presentation/widgets/create_pet_form_widget.dart';
import 'package:meopets/src/shared/widgets/custom_app_bar.dart';
import 'package:meopets/src/shared/widgets/loading_component.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late CreatePetCubit createPetCubit;

  late CreatePetState createPetStateLoading;
  late CreatePetState createPetStateLoaded;
  late CreatePetState createPetStateSuccessfullyCreated;
  late CreatePetState createPetStateError;

  late NavigatorObserver navigatorObserver;

  Future<void> pumpCreatePetScreen(WidgetTester tester) async {
    await tester.pumpWidget(
      BlocProvider(
        create: (context) => createPetCubit,
        child: MaterialApp(
          home: const Scaffold(
            body: CreatePetScreen(),
          ),
          navigatorObservers: [navigatorObserver],
        ),
      ),
    );
  }

  group("CreatePetScreen /", () {
    setUp(() {
      createPetCubit = _MockCreatePetCubit();

      createPetStateLoading = _MockCreatePetState();
      createPetStateLoaded = _MockCreatePetState();
      createPetStateSuccessfullyCreated = _MockCreatePetState();
      createPetStateError = _MockCreatePetState();

      when(() => createPetStateLoading.status)
          .thenReturn(CreatePetStatus.loading);
      when(() => createPetStateLoaded.status)
          .thenReturn(CreatePetStatus.loaded);
      when(() => createPetStateSuccessfullyCreated.status)
          .thenReturn(CreatePetStatus.successfullyCreated);
      when(() => createPetStateError.status).thenReturn(CreatePetStatus.error);

      whenListen(
        createPetCubit,
        const Stream<CreatePetState>.empty(),
        initialState: createPetStateLoading,
      );

      navigatorObserver = _MockNavigatorObserver();
      registerFallbackValue(_FakeRoute());
    });

    testWidgets(
        "given status is CreatePetStatus.loading, "
        "when pumped, "
        "then expect to find LoadingComponent", (tester) async {
      await pumpCreatePetScreen(tester);

      final loadingComponent = find.byType(LoadingComponent);
      expect(loadingComponent, findsOneWidget);
    });

    group("given status is CreatePetStatus.loaded /", () {
      setUp(() {
        when(() => createPetCubit.state).thenReturn(createPetStateLoaded);
      });

      testWidgets(
        "when pumped, "
        "then expect to find CustomAppBar",
        (tester) async {
          await pumpCreatePetScreen(tester);

          final customAppBar = find.byType(CustomAppBar);
          expect(customAppBar, findsOneWidget);
        },
      );

      testWidgets(
        "when pumped, "
        "then expect to find CreatePetFormWidget",
        (tester) async {
          await pumpCreatePetScreen(tester);

          final createPetFormWidget = find.byType(CreatePetFormWidget);
          expect(createPetFormWidget, findsOneWidget);
        },
      );
    });

    group("given status is CreatePetStatus.successfullyCreated /", () {
      setUp(() {
        when(() => createPetCubit.state)
            .thenReturn(createPetStateSuccessfullyCreated);
      });

      testWidgets(
        "when pumped, "
        "then expect to find CustomAppBar",
        (tester) async {
          await pumpCreatePetScreen(tester);

          final customAppBar = find.byType(CustomAppBar);
          expect(customAppBar, findsOneWidget);
        },
      );

      testWidgets(
        "when pumped, "
        "then expect to call Navigator.of.pop()",
        (tester) async {
          await pumpCreatePetScreen(tester);

          verify(
            () => navigatorObserver.didPush(captureAny(), captureAny()),
          ).called(1);
        },
      );
    });
  });
}

class _MockCreatePetCubit extends MockCubit<CreatePetState>
    implements CreatePetCubit {}

class _MockCreatePetState extends Mock implements CreatePetState {}

class _MockNavigatorObserver extends Mock implements NavigatorObserver {}

class _FakeRoute extends Fake implements Route {}
