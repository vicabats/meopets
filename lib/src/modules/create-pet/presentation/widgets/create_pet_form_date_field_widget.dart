import 'package:flutter/material.dart';

class CreatePetFormDateFieldWidget extends StatefulWidget {
  final Function(DateTime) onDateSaved;
  final String label;

  const CreatePetFormDateFieldWidget({
    super.key,
    required this.onDateSaved,
    required this.label,
  });

  @override
  State<CreatePetFormDateFieldWidget> createState() =>
      _CreatePetFormDateFieldWidgetState();
}

class _CreatePetFormDateFieldWidgetState
    extends State<CreatePetFormDateFieldWidget> {
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
