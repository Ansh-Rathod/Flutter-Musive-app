import 'package:flutter/cupertino.dart';

enum NavBarStyle {
  simple,
}

enum PopActionScreensType { once, all }

class NavBarDecoration {
  ///Defines the curve radius of the corners of the NavBar.
  final BorderRadius? borderRadius;

  /// Color for the container which holds the bottom NavBar.
  ///
  /// When you increase the `navBarCurveRadius`, the `bottomScreenPadding` will automatically adjust to avoid layout issues. But if you want a fixed `bottomScreenPadding`, then you might want to set the color of your choice to avoid black edges at the corners of the NavBar.
  final Color colorBehindNavBar;

  final Gradient? gradient;

  final BoxBorder? border;

  final List<BoxShadow>? boxShadow;

  ///If enabled, the screen's bottom padding will be adjusted accordingly to the amount of curve applied.
  final bool adjustScreenBottomPaddingOnCurve;

  const NavBarDecoration({
    this.border,
    this.gradient,
    this.borderRadius,
    this.colorBehindNavBar = CupertinoColors.black,
    this.boxShadow,
    this.adjustScreenBottomPaddingOnCurve = true,
  });
}
