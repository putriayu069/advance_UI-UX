import 'dart:math' as math;

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
      ),
      home: const PainterPage(),
    );
  }
}

class PainterPage extends StatelessWidget {
  const PainterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CustomPainter'),
      ),
      body: Center(
        child: CustomPaint(
          size: const Size(300, 300),
          painter: CirclePainter(),
        ),
      ),
    );
  }
}

class CirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(
      size.width / 2,
      size.height / 2,
    );

    final radius = size.width / 2 - 20;

    final backgroundPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.indigo.shade100;

    final circlePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12
      ..color = Colors.indigo;

    canvas.drawCircle(
      center,
      radius,
      backgroundPaint,
    );

    canvas.drawArc(
      Rect.fromCircle(
        center: center,
        radius: radius,
      ),
      -math.pi / 2,
      math.pi * 1.5,
      false,
      circlePaint,
    );

    final textPainter = TextPainter(
      text: const TextSpan(
        text: '75%',
        style: TextStyle(
          fontSize: 42,
          fontWeight: FontWeight.bold,
          color: Colors.indigo,
        ),
      ),
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();

    textPainter.paint(
      canvas,
      Offset(
        center.dx - textPainter.width / 2,
        center.dy - textPainter.height / 2,
      ),
    );
  }

  @override
  bool shouldRepaint(
    covariant CustomPainter oldDelegate,
  ) {
    return false;
  }
}