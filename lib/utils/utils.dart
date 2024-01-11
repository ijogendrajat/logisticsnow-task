// Universal Tools Section : Jogendra Singh
import 'package:flutter/material.dart';

void customSnackbar(BuildContext context, String message) {
  final snackBar = SnackBar(
    elevation: 5,
    showCloseIcon: true,
    content: Text(message),
    duration: const Duration(seconds: 3),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
