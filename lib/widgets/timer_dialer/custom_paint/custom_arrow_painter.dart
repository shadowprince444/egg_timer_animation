import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomArrowPainter extends CustomPainter {
  final Paint dialArrowPaint;

  CustomArrowPainter() : dialArrowPaint = Paint() {
    dialArrowPaint.color = Colors.red;
    dialArrowPaint.style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();
    canvas.translate(size.width / 2, 0);
    Path _path = Path();
    _path.moveTo(0, -15);
    _path.lineTo(10, 10);

    _path.lineTo(-10, 10);

    _path.close();
    canvas.drawPath(_path, dialArrowPaint);
    canvas.drawShadow(_path, Colors.black, 3, false);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
