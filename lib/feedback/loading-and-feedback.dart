import 'dart:async';

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
      home: const LoadingPage(),
    );
  }
}

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  bool loading = false;
  double progress = 0;

  void startProcess() {
    setState(() {
      loading = true;
      progress = 0;
    });

    Timer.periodic(
      const Duration(milliseconds: 100),
      (timer) {
        setState(() {
          progress += 0.05;
        });

        if (progress >= 1) {
          timer.cancel();

          setState(() {
            loading = false;
          });

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Proses selesai'),
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Loading & Feedback'),
      ),
      body: Center(
        child: loading
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: 250,
                    child: LinearProgressIndicator(
                      value: progress,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '${(progress * 100).round()}%',
                  ),
                ],
              )
            : FilledButton(
                onPressed: startProcess,
                child: const Text('Mulai Proses'),
              ),
      ),
    );
  }
}