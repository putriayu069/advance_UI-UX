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
        colorSchemeSeed: Colors.pink,
      ),
      home: const ExplicitAnimationPage(),
    );
  }
}

class ExplicitAnimationPage extends StatefulWidget {
  const ExplicitAnimationPage({super.key});

  @override
  State<ExplicitAnimationPage> createState() =>
      _ExplicitAnimationPageState();
}

class _ExplicitAnimationPageState
    extends State<ExplicitAnimationPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  late final Animation<double> rotation;
  late final Animation<double> scale;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    final curvedAnimation = CurvedAnimation(
      parent: controller,
      curve: Curves.easeInOut,
    );

    rotation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(curvedAnimation);

    scale = Tween<double>(
      begin: 0.6,
      end: 1.2,
    ).animate(curvedAnimation);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Explicit Animation'),
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            return Transform.rotate(
              angle: rotation.value * 6.28,
              child: Transform.scale(
                scale: scale.value,
                child: child,
              ),
            );
          },
          child: const Icon(
            Icons.favorite,
            size: 120,
            color: Colors.pink,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          controller.forward(from: 0);
        },
        icon: const Icon(Icons.play_arrow),
        label: const Text('Play'),
      ),
    );
  }
}