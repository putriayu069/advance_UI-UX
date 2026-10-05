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
      home: const AnimationPage(),
    );
  }
}

class AnimationPage extends StatefulWidget {
  const AnimationPage({super.key});

  @override
  State<AnimationPage> createState() => _AnimationPageState();
}

class _AnimationPageState extends State<AnimationPage> {
  bool active = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Implicit Animation'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 40),

            AnimatedAlign(
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeInOut,
              alignment: active
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeInOut,
                width: active ? 260 : 200,
                height: active ? 180 : 150,
                decoration: BoxDecoration(
                  color: active
                      ? Colors.deepPurple
                      : Colors.deepPurple.shade100,
                  borderRadius: BorderRadius.circular(
                    active ? 30 : 15,
                  ),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: active ? 20 : 5,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.animation,
                  size: 70,
                  color: Colors.white,
                ),
              ),
            ),

            const SizedBox(height: 40),

            AnimatedOpacity(
              duration: const Duration(milliseconds: 500),
              opacity: active ? 1 : 0.5,
              child: AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 500),
                style: TextStyle(
                  fontSize: active ? 28 : 22,
                  fontWeight: FontWeight.bold,
                  color: active
                      ? Colors.deepPurple
                      : Colors.grey,
                ),
                child: Text(
                  active ? 'Animation Aktif' : 'Animation Nonaktif',
                ),
              ),
            ),

            const Spacer(),

            FilledButton.icon(
              onPressed: () {
                setState(() {
                  active = !active;
                });
              },
              icon: Icon(
                active ? Icons.pause : Icons.play_arrow,
              ),
              label: Text(
                active ? 'Nonaktifkan' : 'Aktifkan',
              ),
            ),
          ],
        ),
      ),
    );
  }
}