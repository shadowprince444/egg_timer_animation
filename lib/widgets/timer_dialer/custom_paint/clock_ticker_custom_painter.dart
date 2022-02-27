import 'dart:math';

import 'package:egg_timer/utils/screen_utils/size_config.dart';
import 'package:egg_timer/utils/screen_utils/text_themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ClockTickerPainter extends CustomPainter {
  final longTickLength = 25.vdp();
  final shortTickLength = 6.vdp();
  final int tickCounts;
  final int ticksPerSection;
  final int ticksInsets;
  final Paint tickPaint;
  final TextPainter textPainter;

  ClockTickerPainter({this.tickCounts = 35, this.ticksPerSection = 5, this.ticksInsets = 0})
      : tickPaint = Paint()
          ..color = Colors.black
          ..strokeWidth = 2.vdp(),
        textPainter = TextPainter()
          ..textAlign = TextAlign.center
          ..textDirection = TextDirection.ltr;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);
    canvas.save();
    final radius = size.width / 2;

    for (int i = 0; i < tickCounts; i++) {
      final tickLength = i % ticksPerSection == 0 ? longTickLength : shortTickLength;
      canvas.drawLine(Offset(0, -radius), Offset(0, -radius - tickLength), tickPaint);
      if (i % ticksPerSection == 0) {
        //paint Text
        paintTimerText(canvas, size, i);
      }

      canvas.rotate((2 * pi) / tickCounts);
    }
    canvas.restore();
  }

  void paintTimerText(Canvas canvas, Size size, int i) {
    canvas.save();
    canvas.translate(0.0, -(size.height / 2) - 40);
    textPainter.text = TextSpan(
      text: "$i",
      style: AppTextThemes().headline2,
    );

    textPainter.layout();
    var tickPercentage = i / tickCounts;
    var quadrant = 0;
    if (tickPercentage < .25) {
      quadrant = 1;
    } else if (tickPercentage < .5) {
      quadrant = 4;
    } else if (tickPercentage < .75) {
      quadrant = 3;
    } else {
      quadrant = 2;
    }
    switch (quadrant) {
      case 1:
        break;
      case 4:
        canvas.rotate(-pi / 2);
        break;
      default:
        canvas.rotate(pi / 2);
        break;
    }
    textPainter.paint(canvas, Offset(-textPainter.width / 2, -textPainter.height / 2));
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    debugPrint("Trying to repaint");
    return false;
  }

  paintText(Canvas canvas, Size size, int i) {
    canvas.translate(0.0, -(size.height / 2) - 30);
    textPainter.text = TextSpan(
      text: "$i",
      style: AppTextThemes().headline3,
    );

    textPainter.layout();

    textPainter.paint(canvas, Offset.zero);
  }
}
