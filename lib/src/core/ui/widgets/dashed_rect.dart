import 'package:flutter/material.dart';
import 'dart:math' as math;

class DashedRect extends StatelessWidget {
  const DashedRect({
    super.key,
    this.color = Colors.black,
    this.strokeWidth = 1.0,
    this.gap = 5.0,
    this.child,
  });
  final Color color;
  final double strokeWidth;
  final double gap;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(strokeWidth / 2),
      child: CustomPaint(
        painter: DashRectPainter(
          color: color,
          strokeWidth: strokeWidth,
          gap: gap,
        ),
        child:
            child != null
                ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18, vertical: 18),
                  child: child,
                )
                : null,
      ),
    );
  }
}

class DashRectPainter extends CustomPainter {
  DashRectPainter({
    this.strokeWidth = 5.0,
    this.color = Colors.black,
    this.gap = 5.0,
  });

  double strokeWidth;
  Color color;
  double gap;

  @override
  void paint(Canvas canvas, Size size) {
    Paint dashedPaint =
        Paint()
          ..color = color
          ..strokeWidth = strokeWidth
          ..style = PaintingStyle.stroke;

    double x = size.width;
    double y = size.height;

    Path topPath = getDashedPath(
      a: math.Point(0, 0),
      b: math.Point(x, 0),
      gap: gap,
    );

    Path rightPath = getDashedPath(
      a: math.Point(x, 0),
      b: math.Point(x, y),
      gap: gap,
    );

    Path bottomPath = getDashedPath(
      a: math.Point(0, y),
      b: math.Point(x, y),
      gap: gap,
    );

    Path leftPath = getDashedPath(
      a: math.Point(0, 0),
      b: math.Point(0.001, y),
      gap: gap,
    );

    canvas.drawPath(topPath, dashedPaint);
    canvas.drawPath(rightPath, dashedPaint);
    canvas.drawPath(bottomPath, dashedPaint);
    canvas.drawPath(leftPath, dashedPaint);
  }

  Path getDashedPath({
    required math.Point<double> a,
    required math.Point<double> b,
    required gap,
  }) {
    Size size = Size(b.x - a.x, b.y - a.y);
    Path path = Path();
    path.moveTo(a.x, a.y);
    bool shouldDraw = true;
    math.Point currentPoint = math.Point(a.x, a.y);

    num radians = math.atan(size.height / size.width);

    num dx =
        math.cos(radians) * gap < 0
            ? math.cos(radians) * gap * -1
            : math.cos(radians) * gap;

    num dy =
        math.sin(radians) * gap < 0
            ? math.sin(radians) * gap * -1
            : math.sin(radians) * gap;

    while (currentPoint.x <= b.x && currentPoint.y <= b.y) {
      shouldDraw
          ? path.lineTo(currentPoint.x.toDouble(), currentPoint.y.toDouble())
          : path.moveTo(currentPoint.x.toDouble(), currentPoint.y.toDouble());
      shouldDraw = !shouldDraw;
      currentPoint = math.Point(currentPoint.x + dx, currentPoint.y + dy);
    }
    return path;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
