import 'package:egg_timer/utils/app_constants/app_colors.dart';
import 'package:flutter/material.dart';

class GradientCircle extends StatelessWidget {
  final BoxDecoration decoration;
  final Widget? child;

  const GradientCircle({
    Key? key,
    this.decoration = gradientBoxDecoration,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.0,
      child: Container(
        decoration: decoration,
        child: child,
      ),
    );
  }
}
