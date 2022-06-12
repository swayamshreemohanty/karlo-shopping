import 'package:flutter/material.dart';

class ShowSnackBar {
  static String uploading = "Uploading...";
  static String cancel = "Operation cancelled.";
  static String postUploaded = "Successfully uploaded.";

  static void closeSnakbar(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }

  static void showSnackBar(
    BuildContext context,
    String message, {
    int second = 3,
    Color backGroundColor = Colors.black,
    Color textColor = Colors.white,
    SnackBarAction? action,
    double? elevation,
  }) {
    //it is used to show the current snackbar message, by overwriting the previous snackbar message.
    closeSnakbar(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: elevation,
        content: Text(
          message,
          style: TextStyle(color: textColor),
        ),
        duration: Duration(seconds: second),
        backgroundColor: backGroundColor,
        action: action,
      ),
    );
  }
}
