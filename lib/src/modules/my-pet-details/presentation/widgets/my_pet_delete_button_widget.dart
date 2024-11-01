import 'package:flutter/material.dart';

class MyPetDeleteButtonWidget extends StatelessWidget {
  final void Function() onPressed;

  const MyPetDeleteButtonWidget({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: const Text("Remover pet"),
    );
  }
}
