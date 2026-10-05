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
      home: const UiStatePage(),
    );
  }
}

enum UiState {
  initial,
  loading,
  success,
  empty,
  error,
}

class UiStatePage extends StatefulWidget {
  const UiStatePage({super.key});

  @override
  State<UiStatePage> createState() => _UiStatePageState();
}

class _UiStatePageState extends State<UiStatePage> {
  UiState state = UiState.initial;

  Widget buildState() {
    switch (state) {
      case UiState.initial:
        return const StateView(
          icon: Icons.touch_app,
          title: 'Initial',
          message: 'Belum ada proses.',
        );

      case UiState.loading:
        return const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text('Loading...'),
          ],
        );

      case UiState.success:
        return const StateView(
          icon: Icons.check_circle,
          title: 'Success',
          message: 'Data berhasil dimuat.',
        );

      case UiState.empty:
        return const StateView(
          icon: Icons.inbox,
          title: 'Empty',
          message: 'Tidak ada data.',
        );

      case UiState.error:
        return const StateView(
          icon: Icons.error,
          title: 'Error',
          message: 'Terjadi kesalahan.',
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UI State'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: buildState(),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                FilledButton(
                  onPressed: () {
                    setState(() {
                      state = UiState.initial;
                    });
                  },
                  child: const Text('Initial'),
                ),
                const SizedBox(width: 8),
                FilledButton(
                  onPressed: () {
                    setState(() {
                      state = UiState.loading;
                    });
                  },
                  child: const Text('Loading'),
                ),
                const SizedBox(width: 8),
                FilledButton(
                  onPressed: () {
                    setState(() {
                      state = UiState.success;
                    });
                  },
                  child: const Text('Success'),
                ),
                const SizedBox(width: 8),
                FilledButton(
                  onPressed: () {
                    setState(() {
                      state = UiState.empty;
                    });
                  },
                  child: const Text('Empty'),
                ),
                const SizedBox(width: 8),
                FilledButton(
                  onPressed: () {
                    setState(() {
                      state = UiState.error;
                    });
                  },
                  child: const Text('Error'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class StateView extends StatelessWidget {
  final IconData icon;
  final String title;
  final String message;

  const StateView({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 80,
        ),
        const SizedBox(height: 16),
        Text(
          title,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(message),
      ],
    );
  }
}