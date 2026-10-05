import 'dart:ui';

import 'package:flutter/material.dart';

class VisualPage extends StatefulWidget {
  const VisualPage({super.key});

  @override
  State<VisualPage> createState() => _VisualPageState();
}

class _VisualPageState extends State<VisualPage> {
  bool useClip = true;
  bool useBlur = true;
  double blurValue = 12;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clip & Visual Effects'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Area preview
          Expanded(
            child: Stack(
              children: [
                // Background
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.blue,
                        Colors.deepPurple,
                        Colors.pink,
                      ],
                    ),
                  ),
                ),

                // Dekorasi background
                Positioned(
                  top: 50,
                  left: 30,
                  child: Container(
                    width: 140,
                    height: 140,
                    decoration: const BoxDecoration(
                      color: Colors.orange,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),

                Positioned(
                  bottom: 50,
                  right: 30,
                  child: Container(
                    width: 160,
                    height: 160,
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),

                // Preview effect
                Center(
                  child: _buildEffectCard(),
                ),
              ],
            ),
          ),

          // Panel kontrol
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              boxShadow: const [
                BoxShadow(
                  blurRadius: 10,
                  offset: Offset(0, -3),
                  color: Colors.black12,
                ),
              ],
            ),
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Pengaturan Effect',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // Clip
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Clip Effect'),
                  subtitle: const Text(
                    'Mengubah bentuk/sudut widget',
                  ),
                  value: useClip,
                  onChanged: (value) {
                    setState(() {
                      useClip = value;
                    });
                  },
                ),

                // Blur
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Blur Effect'),
                  subtitle: const Text(
                    'Memberikan efek blur pada background',
                  ),
                  value: useBlur,
                  onChanged: (value) {
                    setState(() {
                      useBlur = value;
                    });
                  },
                ),

                // Slider blur
                if (useBlur) ...[
                  Row(
                    children: [
                      const Text('Blur'),
                      Expanded(
                        child: Slider(
                          min: 0,
                          max: 30,
                          value: blurValue,
                          onChanged: (value) {
                            setState(() {
                              blurValue = value;
                            });
                          },
                        ),
                      ),
                      Text(
                        blurValue.toStringAsFixed(0),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEffectCard() {
    Widget card = Container(
      width: 300,
      height: 220,
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.25),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.5),
          width: 2,
        ),
      ),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.auto_awesome,
            size: 50,
            color: Colors.white,
          ),
          SizedBox(height: 15),
          Text(
            'Visual Effect',
            style: TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Coba ubah pengaturan di bawah',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );

    // ClipRRect aktif/nonaktif
    if (useClip) {
      card = ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: card,
      );
    }

    // Blur aktif/nonaktif
    if (useBlur) {
      card = ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: blurValue,
            sigmaY: blurValue,
          ),
          child: card,
        ),
      );
    }

    return card;
  }
}