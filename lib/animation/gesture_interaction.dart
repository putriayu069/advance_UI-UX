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
        colorSchemeSeed: Colors.deepOrange,
      ),
      home: const GesturePage(),
    );
  }
}

class GesturePage extends StatefulWidget {
  const GesturePage({super.key});

  @override
  State<GesturePage> createState() => _GesturePageState();
}

class _GesturePageState extends State<GesturePage> {
  String message = 'Coba berbagai gesture';
  bool active = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gesture & Interaction'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  active = !active;
                  message = 'Tap';
                });
              },
              onDoubleTap: () {
                setState(() {
                  message = 'Double Tap';
                });
              },
              onLongPress: () {
                setState(() {
                  message = 'Long Press';
                });
              },
              onPanUpdate: (_) {
                setState(() {
                  message = 'Dragging';
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: active ? 260 : 220,
                height: active ? 260 : 220,
                decoration: BoxDecoration(
                  color: active
                      ? Colors.deepOrange
                      : Colors.orange.shade300,
                  borderRadius: BorderRadius.circular(
                    active ? 50 : 30,
                  ),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: active ? 20 : 5,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: Icon(
                  active
                      ? Icons.favorite
                      : Icons.touch_app,
                  color: Colors.white,
                  size: 80,
                ),
              ),
            ),

            const SizedBox(height: 40),

            Text(
              message,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            const Text(
              'Tap • Double Tap • Long Press • Drag',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}