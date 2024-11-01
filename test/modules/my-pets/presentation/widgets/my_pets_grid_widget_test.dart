import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meopets/src/modules/my-pets/presentation/widgets/my_pet_card_widget.dart';
import 'package:meopets/src/modules/my-pets/presentation/widgets/my_pets_grid_widget.dart';
import 'package:meopets/src/shared/entities/my_pet_entity.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';

late MyPet firstPet;
late MyPet secondPet;
late List<MyPet> myPets;

void main() {
  Future<void> pumpMyPetsGridWidget(
    WidgetTester tester, {
    List<MyPet>? myPets,
    Function(MyPet)? onCardPressed,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MyPetsGridWidget(
            myPets: myPets ?? [],
            onCardPressed: onCardPressed ?? (value) {},
          ),
        ),
      ),
    );
  }

  group("MyPetsGridWidget /", () {
    setUp(() => {
          firstPet = _MockMyPet(),
          secondPet = _MockMyPet(),
          myPets = [firstPet, secondPet],
        });

    testWidgets(
      "expect to find GridView",
      (tester) async {
        await pumpMyPetsGridWidget(tester);

        final gridViewFinder = find.byType(GridView);
        expect(gridViewFinder, findsOneWidget);
      },
    );

    group("MyPetCardWidget /", () {
      testWidgets(
        "given empty myPets, expect to find no MyPetCardWidget",
        (tester) async {
          await pumpMyPetsGridWidget(tester);

          final myPetCardFinder = find.byType(MyPetCardWidget);
          expect(myPetCardFinder, findsNothing);
        },
      );

      testWidgets(
          "given two pets, "
          "when pumped, "
          "then expect to find two MyPetCardWidget", (tester) async {
        await mockNetworkImagesFor(() async {
          await pumpMyPetsGridWidget(tester, myPets: myPets);

          final myPetCardFinder = find.byType(MyPetCardWidget);
          expect(myPetCardFinder, findsNWidgets(2));
        });
      });
    });
  });
}

class _MockMyPet extends Mock implements MyPet {
  _MockMyPet() {
    when(() => name).thenReturn("Bobby");
    when(() => imageUrl).thenReturn("https://www.image.com");
    when(() => birthDate).thenReturn(DateTime.now());
    when(() => type).thenReturn("Dog");
    when(() => description).thenReturn("A cute dog");
  }
}
