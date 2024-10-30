import 'package:flutter/material.dart';

class CreatePetFormDateFieldComponent extends StatefulWidget {
  final Function(DateTime) onDateSaved;
  final String label;

  const CreatePetFormDateFieldComponent({
    super.key,
    required this.onDateSaved,
    required this.label,
  });

  @override
  State<CreatePetFormDateFieldComponent> createState() =>
      _CreatePetFormDateFieldComponentState();
}

class _CreatePetFormDateFieldComponentState
    extends State<CreatePetFormDateFieldComponent> {
  @override
  Widget build(BuildContext context) {
    return InputDatePickerFormField(
      firstDate: DateTime(1990),
      lastDate: DateTime.now(),
      fieldLabelText: widget.label,
      onDateSaved: widget.onDateSaved,
      errorFormatText: 'Formato inválido',
      errorInvalidText: 'Data inválida',
    );
  }
}
