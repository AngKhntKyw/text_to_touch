import 'package:flutter/material.dart';
import 'dart:math';

class ThemeRevealClipper extends CustomClipper<Path> {
  final double radius;
  final Offset center;
  ThemeRevealClipper({required this.radius, required this.center});

  @override
  Path getClip(Size size) {
    return Path()..addOval(Rect.fromCircle(center: center, radius: radius));
  }

  @override
  bool shouldReclip(ThemeRevealClipper oldClipper) {
    return oldClipper.radius != radius || oldClipper.center != center;
  }
}

class ThemeRevealAnimation extends StatefulWidget {
  final Widget child;
  final Offset? startPosition;
  final Duration duration;
  final ValueChanged<bool> onAnimationComplete;

  const ThemeRevealAnimation({
    super.key,
    required this.child,
    this.startPosition,
    this.duration = const Duration(milliseconds: 600),
    required this.onAnimationComplete,
  });

  @override
  ThemeRevealAnimationState createState() => ThemeRevealAnimationState();
}

class ThemeRevealAnimationState extends State<ThemeRevealAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _radiusAnimation = Tween<double>(
    begin: 0.0,
    end: 0.0,
  ).animate(_controller);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.onAnimationComplete(true);
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startAnimation();
    });
  }

  void _startAnimation() {
    if (!mounted) return;

    final Size size = context.size!;
    final Offset center =
        widget.startPosition ?? Offset(size.width / 2, size.height / 2);

    final double maxRadius = _calculateMaxRadius(size, center);

    _radiusAnimation = Tween<double>(
      begin: 0.0,
      end: maxRadius,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.forward(from: 0.0);
  }

  double _calculateMaxRadius(Size size, Offset center) {
    final double tl = (center - Offset(0, 0)).distance;
    final double tr = (center - Offset(size.width, 0)).distance;
    final double bl = (center - Offset(0, size.height)).distance;
    final double br = (center - Offset(size.width, size.height)).distance;
    return max(max(tl, tr), max(bl, br));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _radiusAnimation,
      builder: (context, child) {
        return ClipPath(
          clipper: ThemeRevealClipper(
            radius: _radiusAnimation.value,
            center: widget.startPosition ?? Offset.zero,
          ),
          child: widget.child,
        );
      },
    );
  }
}
