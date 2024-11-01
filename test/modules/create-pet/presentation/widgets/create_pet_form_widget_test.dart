import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meopets/src/modules/create-pet/presentation/widgets/create_pet_form_date_field_widget.dart';
import 'package:meopets/src/modules/create-pet/presentation/widgets/create_pet_form_text_field_widget.dart';
import 'package:meopets/src/modules/create-pet/presentation/widgets/create_pet_form_widget.dart';
import 'package:meopets/src/modules/create-pet/presentation/widgets/types/form_field_data.dart';

void main() {
  Future<void> pumpCreatePetFormWidget(
    WidgetTester tester, {
    Function(List<FormFieldData>)? onSubmit,
    List<FormFieldData>? formFields,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CreatePetFormWidget(
            onSubmit: onSubmit ?? (value) {},
            formFields: formFields ?? [],
          ),
        ),
      ),
    );
  }

  group("CreatePetFormWidget /", () {
    testWidgets(
      "expect to find Form",
      (tester) async {
        await pumpCreatePetFormWidget(tester);

        final widget = tester.widget<Form>(find.byType(Form));

        expect(widget, isNotNull);
      },
    );

    testWidgets(
      "expect to find submit button",
      (tester) async {
        await pumpCreatePetFormWidget(tester);

        final widget = tester.widget<ElevatedButton>(
          find.byType(ElevatedButton),
        );

        expect(widget, isNotNull);
        expect(
          widget.child,
          isA<Text>().having((text) => text.data, 'data', 'Adicionar pet'),
        );
      },
    );

    group("CreatePetFormTextFieldWidget /", () {
      testWidgets(
        "given a formFields list with two FormFieldValueType.text, "
        "when pumped, "
        "then expect to find two CreatePetFormTextFieldWidget widgets",
        (tester) async {
          final List<FormFieldData> createPetFormFieldData = [
            {
              'type': FormFieldValueType.text,
              'label': 'mock text 1',
            },
            {
              'type': FormFieldValueType.text,
              'label': 'mock text 2',
            }
          ];

          await pumpCreatePetFormWidget(
            tester,
            formFields: createPetFormFieldData,
          );

          final createPetFormTextFieldWidget =
              tester.widgetList<CreatePetFormTextFieldWidget>(
            find.byType(CreatePetFormTextFieldWidget),
          );

          expect(createPetFormTextFieldWidget.length, 2);
        },
      );
    });

    group("CreatePetFormDateFieldWidget /", () {
      testWidgets(
        "given a formFields list with three FormFieldValueType.date, "
        "when pumped, "
        "then expect to find three CreatePetFormDateFieldWidget widgets",
        (tester) async {
          final List<FormFieldData> createPetFormFieldData = [
            {
              'type': FormFieldValueType.date,
              'label': 'mock date 1',
            },
            {
              'type': FormFieldValueType.date,
              'label': 'mock date 2',
            },
            {
              'type': FormFieldValueType.date,
              'label': 'mock date 3',
            }
          ];

          await pumpCreatePetFormWidget(
            tester,
            formFields: createPetFormFieldData,
          );

          final createPetFormDateFieldWidget =
              tester.widgetList<CreatePetFormDateFieldWidget>(
            find.byType(CreatePetFormDateFieldWidget),
          );

          expect(createPetFormDateFieldWidget.length, 3);
        },
      );
    });

    testWidgets(
      "when onPressed is clicked, then expect to call the provided onSubmit callback",
      (tester) async {
        bool onSubmitCalled = false;
        List<FormFieldData>? receivedFormData;

        void onSubmitCallback(List<FormFieldData> value) {
          onSubmitCalled = true;
          receivedFormData = value;
        }

        await pumpCreatePetFormWidget(
          tester,
          onSubmit: onSubmitCallback,
        );

        final submitButton = find.byType(ElevatedButton);
        await tester.tap(submitButton);
        await tester.pump();

        expect(onSubmitCalled, isTrue);
        expect(receivedFormData, isNotNull);
      },
    );
  });
}
