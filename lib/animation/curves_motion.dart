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
        colorSchemeSeed: Colors.teal,
      ),
      home: const CurvePage(),
    );
  }
}

class CurvePage extends StatefulWidget {
  const CurvePage({super.key});

  @override
  State<CurvePage> createState() => _CurvePageState();
}

class _CurvePageState extends State<CurvePage> {
  bool active = false;
  Curve selectedCurve = Curves.easeInOut;

  final curves = <String, Curve>{
    'Ease In Out': Curves.easeInOut,
    'Ease In': Curves.easeIn,
    'Ease Out': Curves.easeOut,
    'Bounce': Curves.bounceOut,
    'Elastic': Curves.elasticOut,
    'Fast Out Slow In': Curves.fastOutSlowIn,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Curves & Motion'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              initialValue: curves.entries
                  .firstWhere(
                    (entry) => entry.value == selectedCurve,
                  )
                  .key,
              decoration: const InputDecoration(
                labelText: 'Pilih Animation Curve',
                border: OutlineInputBorder(),
              ),
              items: curves.keys.map((name) {
                return DropdownMenuItem(
                  value: name,
                  child: Text(name),
                );
              }).toList(),
              onChanged: (value) {
                if (value == null) return;

                setState(() {
                  selectedCurve = curves[value]!;
                });
              },
            ),

            const SizedBox(height: 60),

            Align(
              alignment: active
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              child: AnimatedContainer(
                duration: const Duration(seconds: 2),
                curve: selectedCurve,
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: active
                      ? Colors.teal
                      : Colors.orange,
                  borderRadius: BorderRadius.circular(
                    active ? 50 : 15,
                  ),
                ),
                child: const Icon(
                  Icons.motion_photos_on,
                  color: Colors.white,
                  size: 45,
                ),
              ),
            ),

            const Spacer(),

            FilledButton.icon(
              onPressed: () {
                setState(() {
                  active = !active;
                });
              },
              icon: const Icon(Icons.play_arrow),
              label: const Text('Jalankan Animasi'),
            ),
          ],
        ),
      ),
    );
  }
}