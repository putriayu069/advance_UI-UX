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
        colorSchemeSeed: Colors.indigo,
      ),
      home: const TransitionPage(),
    );
  }
}

class TransitionPage extends StatelessWidget {
  const TransitionPage({super.key});

  void openPage(
    BuildContext context,
    Widget page,
    Widget Function(
      BuildContext,
      Animation<double>,
      Animation<double>,
      Widget,
    ) builder,
  ) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => page,
        transitionsBuilder: builder,
        transitionDuration: const Duration(
          milliseconds: 700,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page Transition'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.swap_horiz,
              size: 80,
              color: Colors.indigo,
            ),

            const SizedBox(height: 30),

            const Text(
              'Pilih Jenis Transition',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 30),

            FilledButton.icon(
              onPressed: () {
                openPage(
                  context,
                  const DetailPage(
                    title: 'Fade',
                    icon: Icons.blur_on,
                  ),
                  (_, animation, __, child) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                );
              },
              icon: const Icon(Icons.blur_on),
              label: const Text('Fade Transition'),
            ),

            FilledButton.icon(
              onPressed: () {
                openPage(
                  context,
                  const DetailPage(
                    title: 'Slide',
                    icon: Icons.arrow_forward,
                  ),
                  (_, animation, __, child) {
                    final offset = Tween<Offset>(
                      begin: const Offset(1, 0),
                      end: Offset.zero,
                    ).animate(animation);

                    return SlideTransition(
                      position: offset,
                      child: child,
                    );
                  },
                );
              },
              icon: const Icon(Icons.arrow_forward),
              label: const Text('Slide Transition'),
            ),

            FilledButton.icon(
              onPressed: () {
                openPage(
                  context,
                  const DetailPage(
                    title: 'Scale',
                    icon: Icons.zoom_in,
                  ),
                  (_, animation, __, child) {
                    return ScaleTransition(
                      scale: animation,
                      child: child,
                    );
                  },
                );
              },
              icon: const Icon(Icons.zoom_in),
              label: const Text('Scale Transition'),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  final String title;
  final IconData icon;

  const DetailPage({
    super.key,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$title Transition'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 120,
              color: Colors.indigo,
            ),
            const SizedBox(height: 20),
            Text(
              '$title Transition',
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}