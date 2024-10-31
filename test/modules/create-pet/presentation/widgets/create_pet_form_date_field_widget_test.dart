import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meopets/src/modules/create-pet/presentation/widgets/create_pet_form_date_field_widget.dart';

void main() {
  Future<void> pumpCreatePetFormDateFieldWidget(
    WidgetTester tester, {
    String? label,
    Function(DateTime? value)? onDateSaved,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CreatePetFormDateFieldWidget(
            label: label ?? '',
            onDateSaved: onDateSaved ?? (value) {},
          ),
        ),
      ),
    );
  }

  group("CreatePetFormDateFieldWidget /", () {
    testWidgets(
      "expect to find Text with correct label",
      (tester) async {
        await pumpCreatePetFormDateFieldWidget(
          tester,
          label: 'Date',
        );

        final text = find.text('Date');
        expect(text, findsOneWidget);
      },
    );

    testWidgets(
      "expect to call the provided onDateSaved callback when saving the form",
      (tester) async {
        void onDateSaved(DateTime? value) {}

        await pumpCreatePetFormDateFieldWidget(
          tester,
          onDateSaved: onDateSaved,
        );

        final widget = tester.widget<InputDatePickerFormField>(
          find.byType(
            InputDatePickerFormField,
          ),
        );

        expect(widget.onDateSaved, onDateSaved);
      },
    );
  });
}
