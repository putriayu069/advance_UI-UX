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
      home: const AccessibilityPage(),
    );
  }
}

class AccessibilityPage extends StatelessWidget {
  const AccessibilityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accessibility'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Semantics(
            button: true,
            label: 'Tombol favorit',
            hint: 'Tekan untuk menambahkan favorit',
            child: Tooltip(
              message: 'Tambah ke favorit',
              child: IconButton(
                iconSize: 48,
                onPressed: () {},
                icon: const Icon(
                  Icons.favorite_border,
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          Semantics(
            header: true,
            child: Text(
              'Accessibility Friendly UI',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Gunakan ukuran teks yang cukup besar, '
            'kontras warna yang baik, label yang jelas, '
            'dan area sentuh yang cukup.',
          ),
          const SizedBox(height: 30),
          FilledButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.accessibility),
            label: const Text('Accessible Button'),
          ),
        ],
      ),
    );
  }
}