import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meopets/src/modules/create-pet/presentation/widgets/create_pet_form_text_field_widget.dart';

void main() {
  Future<void> pumpCreatePetFormTextFieldWidget(
    WidgetTester tester, {
    String? label,
    Function(String? value)? onSaved,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CreatePetFormTextFieldWidget(
            label: label ?? '',
            onSaved: onSaved ?? (value) {},
          ),
        ),
      ),
    );
  }

  group("CreatePetFormTextFieldWidget /", () {
    testWidgets(
      "expect to find Text with correct label",
      (tester) async {
        await pumpCreatePetFormTextFieldWidget(
          tester,
          label: 'Name',
        );

        final text = find.text('Name');
        expect(text, findsOneWidget);
      },
    );

    testWidgets(
      "expect to call the provided onSaved callback when saving the form",
      (tester) async {
        void onSaved(String? value) {}

        await pumpCreatePetFormTextFieldWidget(
          tester,
          onSaved: onSaved,
        );

        final widget = tester.widget<TextFormField>(
          find.byType(
            TextFormField,
          ),
        );

        expect(widget.onSaved, onSaved);
      },
    );
  });
}
