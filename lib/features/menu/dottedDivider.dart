import 'package:flutter/material.dart';

class DottedDivider extends StatelessWidget {
  final double width;
  final Color color;
  final double thickness;
  final double gap;

  const DottedDivider({
    Key? key,
    this.width = 1,
    this.color = Colors.black,
    this.thickness = 1,
    this.gap = 3,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: width,
      width: double.infinity,
      child: CustomPaint(
        painter: HorizontalDottedLinePainter(color: color, thickness: thickness, gap: gap),
      ),
    );
  }
}

class HorizontalDottedLinePainter extends CustomPainter {
  final Color color;
  final double thickness;
  final double gap;

  HorizontalDottedLinePainter({required this.color, required this.thickness, required this.gap});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = thickness
      ..strokeCap = StrokeCap.round;

    double startX = 0;
    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + gap, 0), paint);
      startX += gap * 2;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

