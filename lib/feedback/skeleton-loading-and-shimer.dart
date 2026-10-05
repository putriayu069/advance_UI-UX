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
      home: const SkeletonPage(),
    );
  }
}

class SkeletonPage extends StatefulWidget {
  const SkeletonPage({super.key});

  @override
  State<SkeletonPage> createState() => _SkeletonPageState();
}

class _SkeletonPageState extends State<SkeletonPage> {
  bool loading = true;

  @override
  void initState() {
    super.initState();

    Future.delayed(
      const Duration(seconds: 3),
      () {
        if (mounted) {
          setState(() {
            loading = false;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Skeleton Loading'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 6,
        itemBuilder: (context, index) {
          if (loading) {
            return const SkeletonCard();
          }

          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: CircleAvatar(
                child: Text('${index + 1}'),
              ),
              title: Text('Data ${index + 1}'),
              subtitle: const Text(
                'Data telah selesai dimuat.',
              ),
            ),
          );
        },
      ),
    );
  }
}

class SkeletonCard extends StatefulWidget {
  const SkeletonCard({super.key});

  @override
  State<SkeletonCard> createState() => _SkeletonCardState();
}

class _SkeletonCardState extends State<SkeletonCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment(-1 + controller.value * 2, 0),
              end: Alignment(
                controller.value * 2,
                0,
              ),
              colors: const [
                Color(0xFFE5E7EB),
                Color(0xFFF9FAFB),
                Color(0xFFE5E7EB),
              ],
            ),
          ),
        );
      },
    );
  }
}