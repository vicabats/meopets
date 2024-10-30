import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meopets/src/design-system/tokens/colors.dart';
import 'package:meopets/src/design-system/tokens/font_size.dart';

class CustomToaster {
  static void _showToast(String message, Color backgroundColor) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: backgroundColor,
      textColor: ColorsTokens.white,
      fontSize: FontSizeTokens.medium,
    );
  }

  static void showErrorToast(String message) {
    _showToast(message, const Color.fromARGB(255, 236, 150, 150));
  }

  static void showSuccessToast(String message) {
    _showToast(message, ColorsTokens.positiveGreen);
  }
}
