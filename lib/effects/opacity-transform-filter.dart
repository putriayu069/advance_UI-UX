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
        colorSchemeSeed: Colors.blue,
      ),
      home: const TransformPage(),
    );
  }
}

class TransformPage extends StatefulWidget {
  const TransformPage({super.key});

  @override
  State<TransformPage> createState() => _TransformPageState();
}

class _TransformPageState
    extends State<TransformPage> {
  double rotation = 0;
  double scale = 1;
  double opacity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transform & Filter'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Center(
            child: Opacity(
              opacity: opacity,
              child: Transform.rotate(
                angle: rotation,
                child: Transform.scale(
                  scale: scale,
                  child: Container(
                    width: 180,
                    height: 180,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius:
                          BorderRadius.circular(30),
                    ),
                    child: const Icon(
                      Icons.flutter_dash,
                      size: 90,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
          Text(
            'Rotation',
            style: Theme.of(context)
                .textTheme
                .titleMedium,
          ),
          Slider(
            min: 0,
            max: 6.28,
            value: rotation,
            onChanged: (value) {
              setState(() {
                rotation = value;
              });
            },
          ),
          Text(
            'Scale',
            style: Theme.of(context)
                .textTheme
                .titleMedium,
          ),
          Slider(
            min: 0.5,
            max: 2,
            value: scale,
            onChanged: (value) {
              setState(() {
                scale = value;
              });
            },
          ),
          Text(
            'Opacity',
            style: Theme.of(context)
                .textTheme
                .titleMedium,
          ),
          Slider(
            min: 0,
            max: 1,
            value: opacity,
            onChanged: (value) {
              setState(() {
                opacity = value;
              });
            },
          ),
          const SizedBox(height: 20),
          ImageFiltered(
            imageFilter: ImageFilter.blur(
              sigmaX: 3,
              sigmaY: 3,
            ),
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius:
                    BorderRadius.circular(20),
              ),
              alignment: Alignment.center,
              child: const Text(
                'Blur',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}