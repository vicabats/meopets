import 'package:flutter/material.dart';

class CreatePetFormTextFieldComponent extends StatelessWidget {
  final String label;
  final Function(String? value) onSaved;

  const CreatePetFormTextFieldComponent({
    super.key,
    required this.label,
    required this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Campo obrigatório';
        }
        return null;
      },
      onSaved: onSaved,
      decoration: InputDecoration(
        labelText: label,
      ),
    );
  }
}
