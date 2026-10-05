import 'dart:ui';

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
        colorSchemeSeed: Colors.deepPurple,
      ),
      home: const VisualPage(),
    );
  }
}

class VisualPage extends StatelessWidget {
  const VisualPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clip & Visual Effects'),
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.blue,
                  Colors.purple,
                ],
              ),
            ),
          ),
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 10,
                  sigmaY: 10,
                ),
                child: Container(
                  width: 300,
                  height: 220,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(
                      alpha: 0.2,
                    ),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: Colors.white.withValues(
                        alpha: 0.3,
                      ),
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'Glass Effect',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}