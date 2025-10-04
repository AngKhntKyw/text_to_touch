import 'package:flutter/material.dart';
import 'package:getwidget/components/floating_widget/gf_floating_widget.dart';

class SalePage extends StatelessWidget {
  static const routeName = "/sale-page";
  const SalePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sale")),
      body: GFFloatingWidget(
        body: Text('body or any kind of widget here..'),
        child: CircleAvatar(),
      ),
    );
  }
}
