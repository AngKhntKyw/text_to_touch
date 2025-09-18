import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:simple_numpad/simple_numpad.dart';

class PinCodePage extends StatefulWidget {
  const PinCodePage({super.key});

  @override
  State<PinCodePage> createState() => _PinCodePageState();
}

class _PinCodePageState extends State<PinCodePage> {
  bool islocked = true;
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return ScaleTransition(scale: animation, child: child);
              },
              child: IconButton(
                key: ValueKey<bool>(islocked),
                onPressed: () => setState(() => islocked = !islocked),
                icon: Icon(
                  islocked ? Icons.lock_outline : Icons.lock_open,
                  size: size.width / 5,
                ),
              ),
            ),
          ),

          if (!islocked) SizedBox(height: size.height / 3),
          if (!islocked)
            SimpleNumpad(
              buttonWidth: size.width / 4,
              buttonHeight: size.width / 6,
              gridSpacing: 10,
              buttonBorderRadius: 30,
              onPressed: (str) {
                log(str);
              },
            ),
        ],
      ),
    );
  }
}
