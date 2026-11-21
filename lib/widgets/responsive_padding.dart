import 'package:flutter/material.dart';

/// Provides consistent padding that adapts to screen size
/// (phones, foldables, tablets).
class ResponsivePadding extends StatelessWidget {
  final Widget child;
  final double maxWidth;

  const ResponsivePadding({
    super.key,
    required this.child,
    this.maxWidth = 720,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final horizontal = width > 900
        ? (width - maxWidth) / 2
        : width > 600
            ? 24.0
            : 12.0;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontal.clamp(12, 48)),
      child: child,
    );
  }
}
