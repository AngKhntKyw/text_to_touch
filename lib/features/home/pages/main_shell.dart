import 'package:flutter/material.dart';
import 'package:test_app/core/common/widget/responsive_builder.dart';
import 'package:test_app/features/home/widgets/desktop_shell.dart';
import 'package:test_app/features/home/widgets/mobile_shell.dart';

class MainShell extends StatelessWidget {
  final Widget child;

  const MainShell({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      mobileBuilder: (context) {
        return MobileShell(child: child);
      },
      tabletBuilder: (context) {
        return DesktopShell(child: child);
      },
    );
  }
}
