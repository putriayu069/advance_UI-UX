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
        colorSchemeSeed: Colors.green,
      ),
      home: const InteractivePage(),
    );
  }
}

class InteractivePage extends StatefulWidget {
  const InteractivePage({super.key});

  @override
  State<InteractivePage> createState() =>
      _InteractivePageState();
}

class _InteractivePageState
    extends State<InteractivePage> {
  bool notifications = true;
  bool darkMode = false;
  double volume = 50;
  bool checked = false;
  int radio = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Interactive Widgets'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          SwitchListTile(
            title: const Text('Notifications'),
            value: notifications,
            onChanged: (value) {
              setState(() {
                notifications = value;
              });
            },
          ),
          SwitchListTile(
            title: const Text('Dark Mode'),
            value: darkMode,
            onChanged: (value) {
              setState(() {
                darkMode = value;
              });
            },
          ),
          CheckboxListTile(
            title: const Text('Saya setuju'),
            value: checked,
            onChanged: (value) {
              setState(() {
                checked = value ?? false;
              });
            },
          ),
          RadioGroup<int>(
            groupValue: radio,
            onChanged: (value) {
              setState(() {
                radio = value!;
              });
            },
            child: Column(
              children: [
                const RadioListTile<int>(
                  value: 1,
                  title: Text('Option 1'),
                ),
                const RadioListTile<int>(
                  value: 2,
                  title: Text('Option 2'),
                ),
                const RadioListTile<int>(
                  value: 3,
                  title: Text('Option 3'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Volume: ${volume.round()}',
          ),
          Slider(
            value: volume,
            min: 0,
            max: 100,
            divisions: 10,
            label: volume.round().toString(),
            onChanged: (value) {
              setState(() {
                volume = value;
              });
            },
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 8,
            children: [
              ChoiceChip(
                label: const Text('Flutter'),
                selected: checked,
                onSelected: (value) {
                  setState(() {
                    checked = value;
                  });
                },
              ),
              FilterChip(
                label: const Text('Mobile'),
                selected: notifications,
                onSelected: (value) {
                  setState(() {
                    notifications = value;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}