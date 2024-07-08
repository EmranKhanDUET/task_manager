import 'package:flutter/material.dart';

void snackBarMessage(BuildContext context, String message,
    [bool isError = false]) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Center(child: Text(message)),
      backgroundColor: isError ? Colors.red : Colors.green,
    ),
  );
}
