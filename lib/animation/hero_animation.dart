import 'package:flutter/material.dart';

class HeroAnimationPage extends StatelessWidget {
  const HeroAnimationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const HeroListPage();
  }
}

class HeroListPage extends StatelessWidget {
  const HeroListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hero Animation')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 8,
        itemBuilder: (context, index) {
          final color = Colors.primaries[index % Colors.primaries.length];
          return Card(
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: Hero(
                tag: 'hero-$index',
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(Icons.flutter_dash, color: Colors.white),
                ),
              ),
              title: Text('Item ${index + 1}'),
              subtitle: const Text('Tap untuk melihat Hero animation'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => HeroDetailPage(index: index, color: color),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class HeroDetailPage extends StatelessWidget {
  final int index;
  final Color color;

  const HeroDetailPage({super.key, required this.index, required this.color});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detail ${index + 1}')),
      body: Center(
        child: Hero(
          tag: 'hero-$index',
          child: Container(
            width: 250,
            height: 250,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(40),
            ),
            child: const Icon(Icons.flutter_dash, size: 120, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
