import 'package:flutter/material.dart';
import 'package:meopets/src/design-system/tokens/typography.dart';

class MyPetDescriptionInfoWidget extends StatelessWidget {
  final String infoLabel;
  final dynamic infoValue;

  const MyPetDescriptionInfoWidget({
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
