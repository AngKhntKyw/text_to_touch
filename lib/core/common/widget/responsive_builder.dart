import 'package:flutter/material.dart';
import 'package:test_app/core/config/responsive_breakpoints.dart';

class ResponsiveBuilder extends StatelessWidget {
  final Widget Function(BuildContext context) mobileBuilder;
  final Widget Function(BuildContext context)? tabletBuilder;
  final Widget Function(BuildContext context)? desktopBuilder;

  const ResponsiveBuilder({
    super.key,
    required this.mobileBuilder,
    this.tabletBuilder,
    this.desktopBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < mobileBreakpoint) {
          return mobileBuilder(context);
        } else if (constraints.maxWidth < tabletBreakpoint) {
          return tabletBuilder != null
              ? tabletBuilder!(context)
              : (desktopBuilder != null
                    ? desktopBuilder!(context)
                    : mobileBuilder(context));
        } else {
          return desktopBuilder != null
              ? desktopBuilder!(context)
              : (tabletBuilder != null
                    ? tabletBuilder!(context)
                    : mobileBuilder(context));
        }
      },
    );
  }
}
