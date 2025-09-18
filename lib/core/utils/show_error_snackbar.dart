import 'package:flutter/material.dart';

void showErrorSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
      backgroundColor: Colors.red,
      duration: const Duration(seconds: 2),
    ),
  );
}
