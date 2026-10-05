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
        brightness: Brightness.dark,
        useMaterial3: true,
        colorSchemeSeed: Colors.teal,
      ),
      home: const SliverPage(),
    );
  }
}

class SliverPage extends StatefulWidget {
  const SliverPage({super.key});

  @override
  State<SliverPage> createState() => _SliverPageState();
}

class _SliverPageState extends State<SliverPage> {
  bool pinned = true;
  bool floating = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [

          // SliverAppBar
          SliverAppBar(
            expandedHeight: 200,
            pinned: pinned,
            floating: floating,

            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'Sliver (Pinned: $pinned)',
              ),
              centerTitle: true,

              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.teal,
                      Colors.indigo,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.layers,
                    size: 65,
                    color: Colors.white70,
                  ),
                ),
              ),
            ),
          ),

          // Kontrol eksperimen
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.all(12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xff202020),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  const Text(
                    'Kontrol Eksperimen SliverAppBar',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Tombol Pinned
                      ElevatedButton.icon(
                        onPressed: () {
                          setState(() {
                            pinned = true;
                          });
                        },
                        icon: const Icon(Icons.push_pin, size: 16),
                        label: const Text('Pinned'),
                      ),

                      const SizedBox(width: 12),

                      // Tombol Floating
                      OutlinedButton.icon(
                        onPressed: () {
                          setState(() {
                            pinned = false;
                            floating = true;
                          });
                        },
                        icon: const Icon(Icons.vertical_align_top, size: 16),
                        label: const Text('Floating'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // SliverGrid
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Card(
                    child: Center(
                      child: Text(
                        'Grid Exp ${index + 1}',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
                childCount: 6,
              ),

              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1.1,
              ),
            ),
          ),

          // SliverList
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.teal,
                    child: Text(
                      '${index + 1}',
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  title: Text(
                    'Data Terstruktur ${index + 1}',
                  ),
                  subtitle: const Text(
                    'Eksplorasi SliverList dinamis',
                  ),
                );
              },
              childCount: 10,
            ),
          ),
        ],
      ),
    );
  }
}