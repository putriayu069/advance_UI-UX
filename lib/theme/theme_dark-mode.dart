import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode themeMode = ThemeMode.light;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: themeMode,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
        brightness: Brightness.dark,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Theme & Dark Mode'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.dark_mode,
                size: 80,
              ),
              const SizedBox(height: 20),
              Text(
                themeMode == ThemeMode.dark
                    ? 'Dark Mode'
                    : 'Light Mode',
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Switch(
                value: themeMode == ThemeMode.dark,
                onChanged: (value) {
                  setState(() {
                    themeMode = value
                        ? ThemeMode.dark
                        : ThemeMode.light;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}