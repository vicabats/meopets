import 'package:flutter/material.dart';
import 'package:meopets/src/design-system/tokens/spacing.dart';
import 'package:meopets/src/modules/create-pet/presentation/widgets/create_pet_form_date_field_widget.dart';
import 'package:meopets/src/modules/create-pet/presentation/widgets/create_pet_form_text_field_widget.dart';
import 'package:meopets/src/design-system/tokens/typography.dart';
import 'package:meopets/src/modules/create-pet/presentation/widgets/types/form_field_data.dart';

class CreatePetFormWidget extends StatefulWidget {
  final void Function(List<FormFieldData>) onSubmit;
  final List<FormFieldData> formFields;

  const CreatePetFormWidget({
    super.key,
    required this.onSubmit,
    required this.formFields,
  });

  @override
  State<CreatePetFormWidget> createState() => _CreatePetFormWidgetState();
}

class _CreatePetFormWidgetState extends State<CreatePetFormWidget> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.disabled,
      child: Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemCount: widget.formFields.length,
              separatorBuilder: (context, index) => const SizedBox(
                height: SpacingTokens.md,
              ),
              itemBuilder: (context, index) {
                final formField = widget.formFields[index];
                return _buildFormField(formField);
              },
            ),
          ),
          const SizedBox(height: SpacingTokens.xl),
          _buildSubmitButton(),
        ],
      ),
    );
  }

  Widget? _buildFormField(FormFieldData formField) {
    switch (formField['type']) {
      case FormFieldValueType.text:
        return CreatePetFormTextFieldWidget(
          label: formField['label'],
          onSaved: (value) {
            formField['value'] = value;
          },
        );
      case FormFieldValueType.date:
        return CreatePetFormDateFieldWidget(
          label: formField['label'],
          onDateSaved: (date) {
            formField['value'] = date;
          },
        );
      default:
        return null;
    }
  }

  ElevatedButton _buildSubmitButton() {
    return ElevatedButton(
      child: const Text(
        'Adicionar pet',
        style: TypographyTokens.bodyBoldMd,
      ),
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          _formKey.currentState!.save();
          widget.onSubmit(widget.formFields);
        }
      },
    );
  }
}
