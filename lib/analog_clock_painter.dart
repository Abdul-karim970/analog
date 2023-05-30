import 'dart:math';

import 'package:flutter/material.dart';

class AnalogClockPainter extends CustomPainter {
  final DateTime dateTime;

  AnalogClockPainter({required this.dateTime});
  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;
    final clockRadius = min(width, height) / 2;
    final centerOffset = Offset(width * 0.5, height * 0.5);
    const tickDegree = 2 * pi / 60;

    // Tick thickness ans length

    final minuteTickThickness = clockRadius * 0.01;
    final hoursTickThickness = clockRadius * 0.02;
    final minuteTickLength = clockRadius * 0.06;
    final hoursTickLength = clockRadius * 0.12;

    // Clock base
    final innerFilledCircleRadius = clockRadius * 0.05;
    final innerOutlinedCircleRadius = clockRadius * 0.1;
    final clockPaint = Paint()..color = Colors.black;
    final outerClockPaint = Paint()..color = Colors.blueGrey;

    final innerFilledCirclePaint = Paint()..color = Colors.red;
    final innerOutlinedCirclePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = clockRadius * 0.025;
    canvas.drawCircle(centerOffset, clockRadius * 1.46, outerClockPaint);

    canvas.drawCircle(centerOffset, clockRadius, clockPaint);
    canvas.drawCircle(
        centerOffset, innerFilledCircleRadius, innerFilledCirclePaint);
    canvas.drawCircle(
        centerOffset, innerOutlinedCircleRadius, innerOutlinedCirclePaint);
    canvas.save();
    canvas.translate(centerOffset.dx, centerOffset.dy);

    // Clock outer design
    final clockOuterDesignPath = Path()
      ..moveTo(0, -clockRadius * 1.12)
      ..lineTo(-clockRadius * 0.04, -clockRadius * 1.2)
      ..lineTo(-clockRadius * 0.04, -clockRadius * 1.23)
      ..conicTo(
          0, -clockRadius * 1.18, clockRadius * 0.04, -clockRadius * 1.23, 0.8)
      ..lineTo(clockRadius * 0.04, -clockRadius * 1.2)
      ..close();

    final clockOuterDesignSecondPath = Path()
      ..moveTo(-clockRadius * 0.04, -clockRadius * 1.32)
      ..lineTo(-clockRadius * 0.04, -clockRadius * 1.4)
      ..conicTo(
          0, -clockRadius * 1.45, clockRadius * 0.04, -clockRadius * 1.4, 0.8)
      ..lineTo(clockRadius * 0.04, -clockRadius * 1.32)
      ..conicTo(
          0, -clockRadius * 1.35, -clockRadius * 0.04, -clockRadius * 1.32, 0.8)
      ..close();

    final clockOuterDesignPaint = Paint()..color = Colors.black;

    final clockOuterLinePaint = Paint()
      ..color = Colors.black
      ..strokeWidth = clockRadius * 0.02
      ..strokeCap = StrokeCap.round;
    final clockOuterDesignCirclePaint = Paint()..color = Colors.white;

    // Clock hours and minute tick
    final minuteTickPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = minuteTickThickness
      ..strokeCap = StrokeCap.round;
    final hoursTickPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = hoursTickThickness
      ..strokeCap = StrokeCap.round;

    // Needles Paint
    final secondsNeedlePaint = Paint()
      ..color = Colors.red
      ..strokeCap = StrokeCap.round
      ..strokeWidth = clockRadius * 0.02;

    final minutesNeedlePaint = Paint()
      ..color = Colors.white
      ..strokeCap = StrokeCap.round
      ..strokeWidth = clockRadius * 0.03;

    final hoursNeedlePaint = Paint()
      ..color = Colors.white
      ..strokeCap = StrokeCap.round
      ..strokeWidth = clockRadius * 0.04;

    for (var i = 0; i < 60; i++) {
      if (i % 5 == 0) {
        canvas.drawLine(Offset(0, -clockRadius),
            Offset(0, -clockRadius * 1.135), clockOuterLinePaint);
        canvas.drawPath(clockOuterDesignPath, clockOuterDesignPaint);
        canvas.drawCircle(Offset(0, -clockRadius * 1.2725), clockRadius * 0.038,
            clockOuterDesignCirclePaint);
        canvas.drawPath(clockOuterDesignSecondPath, clockOuterDesignPaint);
        canvas.drawLine(Offset(0, -clockRadius + hoursTickLength),
            Offset(0, -clockRadius), hoursTickPaint);
      } else {
        canvas.drawLine(Offset(0, -clockRadius), Offset(0, -clockRadius * 1.07),
            clockOuterLinePaint);
        canvas.drawCircle(Offset(0, -clockRadius * 1.11), clockRadius * 0.03,
            clockOuterDesignCirclePaint);
        canvas.drawLine(Offset(0, -clockRadius + minuteTickLength),
            Offset(0, -clockRadius), minuteTickPaint);
      }

      if (((dateTime.hour % 12) * 5) == i) {
        canvas.drawLine(Offset(0, -clockRadius * 0.12),
            Offset(0, -clockRadius + clockRadius * 0.6), hoursNeedlePaint);
      }
      if (dateTime.minute == i) {
        canvas.drawLine(Offset(0, -clockRadius * 0.12),
            Offset(0, -clockRadius + clockRadius * 0.32), minutesNeedlePaint);
      }

      if (dateTime.second == i) {
        canvas.drawCircle(Offset(0, -clockRadius * 0.18), clockRadius * 0.03,
            Paint()..color = Colors.red);
        canvas.drawLine(Offset(0, -clockRadius * 0.25),
            Offset(0, -clockRadius + clockRadius * 0.25), secondsNeedlePaint);
      }

      canvas.rotate(tickDegree);
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(AnalogClockPainter oldDelegate) =>
      oldDelegate.dateTime != dateTime;

  @override
  bool shouldRebuildSemantics(AnalogClockPainter oldDelegate) =>
      oldDelegate.dateTime != dateTime;
}
