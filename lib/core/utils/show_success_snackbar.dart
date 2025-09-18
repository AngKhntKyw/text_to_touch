import 'package:flutter/material.dart';

void showSuccessSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
      backgroundColor: Colors.green,
      duration: const Duration(seconds: 2),
    ),
  );
}
