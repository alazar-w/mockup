import 'package:flutter/cupertino.dart';
import '../../widgets/custom_painter_helper.dart';

class CardBackground extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    CustomPainterHelper.createCircleWithBlur(canvas,
        color: const Color(0xff6885e3),
        origin: Offset(size.width * 0.253333, size.height * 0.5745763),
        radius: size.width * 0.533333,
        colorOpacity: 0.15);

    CustomPainterHelper.createCircleWithBlur(
      canvas,
      color: const Color(0xffffffff),
      origin: Offset(size.width * 0.6506667, size.height * -0.3),
      radius: size.width * 0.02040000,
    );

    CustomPainterHelper.createCircleWithBlur(
      canvas,
      color: const Color(0xffffffff),
      origin: Offset(size.width * 0.8653333, size.height * -0.09758133),
      radius: size.width * 0.01933333,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
