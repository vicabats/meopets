import 'package:flutter/material.dart';
import 'package:meopets/src/design-system/tokens/spacing.dart';
import 'package:meopets/src/modules/create-pet/presentation/containers/create_pet_form_fields.dart';
import 'package:meopets/src/modules/create-pet/presentation/widgets/create_pet_form_date_field_component.dart';
import 'package:meopets/src/modules/create-pet/presentation/widgets/create_pet_form_text_field_component.dart';
import 'package:meopets/src/design-system/tokens/typography.dart';

class CreatePetFormContainer extends StatefulWidget {
  final void Function(Map<dynamic, dynamic>) onSubmit;

  const CreatePetFormContainer({
    super.key,
    required this.onSubmit,
  });

  @override
  State<CreatePetFormContainer> createState() => _CreatePetFormContainerState();
}

class _CreatePetFormContainerState extends State<CreatePetFormContainer> {
  final _formKey = GlobalKey<FormState>();

  final List<FormFieldData> _formFields = createPetformFields;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.disabled,
      child: Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemCount: _formFields.length,
              separatorBuilder: (context, index) => const SizedBox(
                height: SpacingTokens.md,
              ),
              itemBuilder: (context, index) {
                final formField = _formFields[index];
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
        return CreatePetFormTextFieldComponent(
          label: formField['label'],
          onSaved: (value) {
            formField['value'] = value;
          },
        );
      case FormFieldValueType.date:
        return CreatePetFormDateFieldComponent(
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
          final formData = {
            for (var item in _formFields) item['key']: item['value']
          };
          widget.onSubmit(formData);
        }
      },
    );
  }
}
