import 'dart:ui';
import 'package:flutter/material.dart';

class TransformPage extends StatefulWidget {
  const TransformPage({super.key});

  @override
  State<TransformPage> createState() => _TransformPageState();
}

class _TransformPageState extends State<TransformPage> {
  double rotation = 0;
  double scale = 1;
  double opacity = 1;
  double blur = 3;

  bool useRotation = true;
  bool useScale = true;
  bool useOpacity = true;
  bool useBlur = true;

  void resetEffect() {
    setState(() {
      rotation = 0;
      scale = 1;
      opacity = 1;
      blur = 3;

      useRotation = true;
      useScale = true;
      useOpacity = true;
      useBlur = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Opacity, Transform & Filter'),
        actions: [
          IconButton(
            tooltip: 'Reset',
            onPressed: resetEffect,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Interactive Visual Effect',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            'Atur opacity, rotasi, ukuran, dan blur untuk melihat '
            'perubahan efek secara langsung.',
          ),

          const SizedBox(height: 30),

          // ================= PREVIEW =================
          Center(
            child: _buildPreview(),
          ),

          const SizedBox(height: 35),

          // ================= OPACITY =================
          _buildSwitch(
            title: 'Opacity',
            subtitle: 'Mengatur tingkat transparansi',
            value: useOpacity,
            onChanged: (value) {
              setState(() {
                useOpacity = value;
              });
            },
          ),

          Text(
            'Opacity: ${(opacity * 100).round()}%',
            style: Theme.of(context).textTheme.titleMedium,
          ),

          Slider(
            min: 0,
            max: 1,
            value: opacity,
            onChanged: useOpacity
                ? (value) {
                    setState(() {
                      opacity = value;
                    });
                  }
                : null,
          ),

          const Divider(height: 30),

          // ================= ROTATION =================
          _buildSwitch(
            title: 'Transform Rotate',
            subtitle: 'Memutar objek',
            value: useRotation,
            onChanged: (value) {
              setState(() {
                useRotation = value;
              });
            },
          ),

          Text(
            'Rotation: ${(rotation * 180 / 3.14159).round()}°',
            style: Theme.of(context).textTheme.titleMedium,
          ),

          Slider(
            min: 0,
            max: 6.28,
            value: rotation,
            onChanged: useRotation
                ? (value) {
                    setState(() {
                      rotation = value;
                    });
                  }
                : null,
          ),

          const Divider(height: 30),

          // ================= SCALE =================
          _buildSwitch(
            title: 'Transform Scale',
            subtitle: 'Memperbesar atau memperkecil objek',
            value: useScale,
            onChanged: (value) {
              setState(() {
                useScale = value;
              });
            },
          ),

          Text(
            'Scale: ${scale.toStringAsFixed(1)}x',
            style: Theme.of(context).textTheme.titleMedium,
          ),

          Slider(
            min: 0.5,
            max: 2,
            value: scale,
            onChanged: useScale
                ? (value) {
                    setState(() {
                      scale = value;
                    });
                  }
                : null,
          ),

          const Divider(height: 30),

          // ================= BLUR =================
          _buildSwitch(
            title: 'Filter Blur',
            subtitle: 'Memberikan efek blur pada objek',
            value: useBlur,
            onChanged: (value) {
              setState(() {
                useBlur = value;
              });
            },
          ),

          Text(
            'Blur: ${blur.toStringAsFixed(1)}',
            style: Theme.of(context).textTheme.titleMedium,
          ),

          Slider(
            min: 0,
            max: 15,
            value: blur,
            onChanged: useBlur
                ? (value) {
                    setState(() {
                      blur = value;
                    });
                  }
                : null,
          ),

          const SizedBox(height: 20),

          FilledButton.icon(
            onPressed: resetEffect,
            icon: const Icon(Icons.restart_alt),
            label: const Text('Reset Semua Efek'),
          ),
        ],
      ),
    );
  }

  // ================= PREVIEW =================

  Widget _buildPreview() {
    Widget box = Container(
      width: 180,
      height: 180,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            blurRadius: 15,
            spreadRadius: 2,
            color: Colors.black.withValues(alpha: 0.15),
          ),
        ],
      ),
      child: const Center(
        child: Icon(
          Icons.flutter_dash,
          size: 90,
          color: Colors.white,
        ),
      ),
    );

    // Filter
    if (useBlur) {
      box = ImageFiltered(
        imageFilter: ImageFilter.blur(
          sigmaX: blur,
          sigmaY: blur,
        ),
        child: box,
      );
    }

    // Scale
    if (useScale) {
      box = Transform.scale(
        scale: scale,
        child: box,
      );
    }

    // Rotation
    if (useRotation) {
      box = Transform.rotate(
        angle: rotation,
        child: box,
      );
    }

    // Opacity
    if (useOpacity) {
      box = Opacity(
        opacity: opacity,
        child: box,
      );
    }

    return SizedBox(
      height: 260,
      child: Center(
        child: box,
      ),
    );
  }

  // ================= SWITCH =================

  Widget _buildSwitch({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return SwitchListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title),
      subtitle: Text(subtitle),
      value: value,
      onChanged: onChanged,
    );
  }
}