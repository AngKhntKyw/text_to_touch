import 'package:flutter/material.dart';
import 'package:test_app/core/error/failure.dart';

class ErrorsWidget extends StatelessWidget {
  final Failure failure;
  const ErrorsWidget({super.key, required this.failure});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(failure.message));
  }
}
