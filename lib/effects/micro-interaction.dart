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
        colorSchemeSeed: Colors.pink,
      ),
      home: const MicroInteractionPage(),
    );
  }
}

class MicroInteractionPage extends StatefulWidget {
  const MicroInteractionPage({super.key});

  @override
  State<MicroInteractionPage> createState() =>
      _MicroInteractionPageState();
}

class _MicroInteractionPageState
    extends State<MicroInteractionPage> {
  bool favorite = false;
  bool expanded = false;
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Micro Interaction'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          GestureDetector(
            onTapDown: (_) {
              setState(() {
                pressed = true;
              });
            },
            onTapUp: (_) {
              setState(() {
                pressed = false;
              });
            },
            onTapCancel: () {
              setState(() {
                pressed = false;
              });
            },
            child: AnimatedScale(
              scale: pressed ? 0.95 : 1,
              duration: const Duration(
                milliseconds: 100,
              ),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 30,
                        child: Icon(Icons.flutter_dash),
                      ),
                      const SizedBox(width: 16),
                      const Expanded(
                        child: Text(
                          'Interactive Card',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            favorite = !favorite;
                          });
                        },
                        icon: AnimatedSwitcher(
                          duration: const Duration(
                            milliseconds: 300,
                          ),
                          child: Icon(
                            favorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            key: ValueKey(favorite),
                            color: favorite
                                ? Colors.red
                                : null,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Card(
            child: Column(
              children: [
                ListTile(
                  title: const Text('Expandable Card'),
                  trailing: IconButton(
                    onPressed: () {
                      setState(() {
                        expanded = !expanded;
                      });
                    },
                    icon: AnimatedRotation(
                      turns: expanded ? 0.5 : 0,
                      duration:
                          const Duration(milliseconds: 300),
                      child: const Icon(
                        Icons.expand_more,
                      ),
                    ),
                  ),
                ),
                AnimatedCrossFade(
                  duration: const Duration(
                    milliseconds: 300,
                  ),
                  crossFadeState: expanded
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                  firstChild: const SizedBox.shrink(),
                  secondChild: const Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      'Konten tambahan ditampilkan '
                      'dengan micro interaction.',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}