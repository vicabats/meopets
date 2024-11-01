import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meopets/src/modules/my-pets/presentation/widgets/my_pet_card_widget.dart';
import 'package:meopets/src/shared/entities/my_pet_entity.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';

late MyPet pet;

void main() {
  Future<void> pumpMyPetCardWidget(
    WidgetTester tester, {
    required MyPet pet,
    VoidCallback? onPressed,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MyPetCardWidget(
            pet: pet,
            onPressed: onPressed ?? () {},
          ),
        ),
      ),
    );
  }

  group("MyPetCardWidget /", () {
    setUp(() {
      pet = _MockMyPet();
    });

    testWidgets(
      "expect to find Image with correct imageUrl",
      (tester) async {
        await mockNetworkImagesFor(() async {
          await pumpMyPetCardWidget(tester, pet: pet);

          final Finder imageFinder = find.byWidgetPredicate(
            (Widget widget) =>
                widget is Image &&
                widget.image == const NetworkImage("https://www.image.com"),
          );

          expect(imageFinder, findsOneWidget);
        });
      },
    );

    testWidgets(
      "expect to find Text with correct name",
      (tester) async {
        await mockNetworkImagesFor(() async {
          await pumpMyPetCardWidget(tester, pet: pet);

          final text = find.text('Bobby');
          expect(text, findsOneWidget);
        });
      },
    );

    testWidgets(
      "expect to call the provided onPressed callback when tapping the card",
      (tester) async {
        await mockNetworkImagesFor(() async {
          bool isPressed = false;

          await pumpMyPetCardWidget(
            tester,
            pet: pet,
            onPressed: () {
              isPressed = true;
            },
          );

          await tester.tap(find.byType(Card));

          expect(isPressed, true);
        });
      },
    );
  });
}

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
