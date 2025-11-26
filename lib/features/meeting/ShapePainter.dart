import 'dart:ui';import '../../Utill/app_required.dart';

class ShapePainter extends CustomPainter {
  final Color Colore;

  ShapePainter({ this.Colore = AppColors.yellow});
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colore; // Fill color from SVG

    Path path = Path();
    path.moveTo(0, 0); // Start point
    path.lineTo(size.width, 0); // Top right corner
    path.lineTo(size.width - 40, size.height); // Bottom right to custom point
    path.lineTo(40, size.height); // Bottom left to custom point
    path.lineTo(0, 0); // Close the path

    canvas.drawShadow(
      path,
      Colors.grey.withOpacity(0.5),
      5.0,
      false,
    );


    canvas.drawPath(path, paint); // Draw the path on canvas
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false; // No repaint needed unless properties change
  }
}