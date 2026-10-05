import 'dart:math' as math;
import 'package:flutter/material.dart';

class PainterPage extends StatefulWidget {
  const PainterPage({super.key});

  @override
  State<PainterPage> createState() => _PainterPageState();
}

class _PainterPageState extends State<PainterPage>
    with SingleTickerProviderStateMixin {
  double progress = 75;
  Color selectedColor = Colors.indigo;

  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    animation = Tween<double>(
      begin: 0,
      end: progress,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeOut,
      ),
    );

    animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void startAnimation() {
    animation = Tween<double>(
      begin: 0,
      end: progress,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeOut,
      ),
    );

    animationController
      ..reset()
      ..forward();
  }

  @override
  Widget build(BuildContext context) {
    final displayedProgress =
        animationController.isAnimating
            ? animation.value
            : progress;

    return Scaffold(
      appBar: AppBar(
        title: const Text('CustomPainter'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 10),

            Text(
              'Custom Drawing',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Atur nilai dan warna gambar menggunakan CustomPainter',
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 25),

            // AREA CUSTOM PAINTER
            Container(
              width: 320,
              height: 320,
              decoration: BoxDecoration(
                color: selectedColor.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Center(
                child: CustomPaint(
                  size: const Size(280, 280),
                  painter: CirclePainter(
                    progress: displayedProgress,
                    color: selectedColor,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 25),

            // NILAI PROGRESS
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Progress',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${progress.toInt()}%',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: selectedColor,
                          ),
                        ),
                      ],
                    ),

                    Slider(
                      min: 0,
                      max: 100,
                      value: progress,
                      activeColor: selectedColor,
                      onChanged: (value) {
                        setState(() {
                          progress = value;
                        });
                      },
                    ),

                    const SizedBox(height: 10),

                    // PILIH WARNA
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Warna Progress',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceEvenly,
                      children: [
                        _colorButton(Colors.indigo),
                        _colorButton(Colors.green),
                        _colorButton(Colors.orange),
                        _colorButton(Colors.pink),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // TOMBOL ANIMASI
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        onPressed: animationController.isAnimating
                            ? null
                            : startAnimation,
                        icon: const Icon(Icons.play_arrow),
                        label: const Text(
                          'Jalankan Animasi',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // PENJELASAN
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Icon(
                      Icons.brush,
                      size: 40,
                      color: selectedColor,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'CustomPainter',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Gambar progress dibuat secara manual '
                      'menggunakan Canvas melalui CustomPainter.',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _colorButton(Color color) {
    final isSelected = selectedColor == color;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedColor = color;
        });
      },
      child: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: isSelected
              ? Border.all(
                  color: Colors.black,
                  width: 3,
                )
              : null,
        ),
        child: isSelected
            ? const Icon(
                Icons.check,
                color: Colors.white,
              )
            : null,
      ),
    );
  }
}

class CirclePainter extends CustomPainter {
  final double progress;
  final Color color;

  const CirclePainter({
    required this.progress,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(
      size.width / 2,
      size.height / 2,
    );

    final radius = size.width / 2 - 25;

    // Background lingkaran
    final backgroundPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 16
      ..color = color.withValues(alpha: 0.15);

    canvas.drawCircle(
      center,
      radius,
      backgroundPaint,
    );

    // Progress
    final progressPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 16
      ..strokeCap = StrokeCap.round
      ..color = color;

    final sweepAngle =
        2 * math.pi * (progress / 100);

    canvas.drawArc(
      Rect.fromCircle(
        center: center,
        radius: radius,
      ),
      -math.pi / 2,
      sweepAngle,
      false,
      progressPaint,
    );

    // Tulisan persentase
    final textPainter = TextPainter(
      text: TextSpan(
        text: '${progress.toInt()}%',
        style: TextStyle(
          fontSize: 46,
          fontWeight: FontWeight.bold,
          color: color,
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
    covariant CirclePainter oldDelegate,
  ) {
    return oldDelegate.progress != progress ||
        oldDelegate.color != color;
  }
}