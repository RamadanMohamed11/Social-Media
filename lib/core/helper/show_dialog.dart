import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';

void showMessageDialog(
  BuildContext context,
  bool isSuccessful,
  bool isSignout,
  String message, {
  void Function()? btnOkOnPress,
}) {
  QuickAlert.show(
    context: context,
    type: isSuccessful
        ? QuickAlertType.success
        : (isSignout)
            ? QuickAlertType.confirm
            : QuickAlertType.error,
    title: isSuccessful
        ? "Success"
        : (isSignout)
            ? "Signout"
            : "Error",
    text: message,
    confirmBtnText: "Ok",
    onConfirmBtnTap: () {
      Navigator.of(context).pop();
      if (btnOkOnPress != null) {
        btnOkOnPress();
      }
    },
  );
}
