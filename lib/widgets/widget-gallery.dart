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
      home: const WidgetGalleryPage(),
    );
  }
}

class WidgetGalleryPage extends StatelessWidget {
  const WidgetGalleryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final widgets = [
      (
        'Buttons',
        Icons.smart_button,
        'FilledButton, OutlinedButton, TextButton',
      ),
      (
        'Input',
        Icons.input,
        'TextField dan TextFormField',
      ),
      (
        'Navigation',
        Icons.navigation,
        'NavigationBar dan NavigationRail',
      ),
      (
        'Feedback',
        Icons.notifications,
        'Dialog, Snackbar, BottomSheet',
      ),
      (
        'Selection',
        Icons.check_box,
        'Checkbox, Radio, Switch',
      ),
      (
        'Layout',
        Icons.dashboard,
        'Row, Column, Stack, Wrap',
      ),
      (
        'Animation',
        Icons.animation,
        'Implicit dan Explicit Animation',
      ),
      (
        'Scrolling',
        Icons.view_agenda,
        'ListView dan Sliver',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Widget Gallery'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.15,
        ),
        itemCount: widgets.length,
        itemBuilder: (context, index) {
          final item = widgets[index];

          return Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center,
                children: [
                  Icon(
                    item.$2,
                    size: 48,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    item.$1,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item.$3,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}