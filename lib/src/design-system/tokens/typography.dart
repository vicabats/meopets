import 'package:flutter/material.dart';
import 'package:meopets/src/design-system/tokens/colors.dart';
import 'package:meopets/src/design-system/tokens/font_size.dart';

class TypographyTokens {
  static const TextStyle titleBoldLg = TextStyle(
    fontFamily: 'DynaPuff',
    fontSize: FontSizeTokens.large,
    fontWeight: FontWeight.bold,
    color: ColorsTokens.black,
  );

  static const TextStyle titleRegularSm = TextStyle(
    fontFamily: 'DynaPuff',
    fontSize: FontSizeTokens.medium,
    fontWeight: FontWeight.normal,
    color: ColorsTokens.gray,
  );

  static const TextStyle bodyRegularSm = TextStyle(
    fontFamily: 'OpenSans',
    fontSize: FontSizeTokens.small,
    fontWeight: FontWeight.normal,
    color: ColorsTokens.black,
  );

  static const TextStyle bodyRegularMd = TextStyle(
    fontFamily: 'OpenSans',
    fontSize: FontSizeTokens.medium,
    fontWeight: FontWeight.normal,
    color: ColorsTokens.brandPrimary,
  );

  static const TextStyle bodyBoldMd = TextStyle(
    fontFamily: 'OpenSans',
    fontSize: FontSizeTokens.medium,
    fontWeight: FontWeight.bold,
    color: ColorsTokens.brandPrimary,
  );
}
