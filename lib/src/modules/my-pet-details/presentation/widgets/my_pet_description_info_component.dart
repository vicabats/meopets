import 'package:flutter/material.dart';
import 'package:meopets/src/design-system/tokens/typography.dart';

class MyPetDescriptionInfoComponent extends StatelessWidget {
  final String infoLabel;
  final dynamic infoValue;

  const MyPetDescriptionInfoComponent({
    super.key,
    required this.infoLabel,
    required this.infoValue,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      '$infoLabel: $infoValue',
      style: TypographyTokens.bodyRegularSm,
    );
  }
}
