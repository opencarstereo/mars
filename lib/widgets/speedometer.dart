import 'dart:math' show pi;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui/providers/speed.dart';

class SpeedometerWidget extends ConsumerWidget {
  const SpeedometerWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final speed = ref.watch(speedProvider).value ?? 0;
    final theme = Theme.of(context);
    return Stack(
      children: [
        Positioned.fill(
          child: CustomPaint(
            painter: _SpeedometerPainter(value: speed, maxSpeed: 200),
          ),
        ),
        Center(
          child: Text(
            speed.toStringAsFixed(0),
            style: theme.textTheme.headlineLarge,
          ),
        ),
      ],
    );
  }
}

class _SpeedometerPainter extends CustomPainter {
  final double value;
  final double maxSpeed;

  _SpeedometerPainter({required this.value, required this.maxSpeed});

  final paintF = Paint()
    ..color = Colors.white10
    ..style = PaintingStyle.stroke
    ..strokeWidth = 5
    ..strokeCap = StrokeCap.round;

  @override
  void paint(Canvas canvas, Size size) {
    final radius = size.width / 2;
    final center = size.center(Offset.zero);

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      degToRad(135),
      degToRad(269),
      false,
      paintF,
    );

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      degToRad(135),
      degToRad((value % (maxSpeed + 1)) / ((maxSpeed + 1) / 270)),
      false,
      paintF..color = speedToColor(value),
    );
  }

  @override
  bool shouldRepaint(_SpeedometerPainter oldDelegate) =>
      value != oldDelegate.value;

  @override
  bool shouldRebuildSemantics(_SpeedometerPainter oldDelegate) => false;

  static double degToRad(num deg) => deg * (pi / 180);

  Color speedToColor(double speed) =>
      HSLColor.fromAHSL(1, (1 - (speed / maxSpeed)) * 120, 1, 0.5).toColor();
}
