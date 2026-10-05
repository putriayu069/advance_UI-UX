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
        colorSchemeSeed: Colors.indigo,
      ),
      home: const AdaptivePage(),
    );
  }
}

class AdaptivePage extends StatefulWidget {
  const AdaptivePage({super.key});

  @override
  State<AdaptivePage> createState() => _AdaptivePageState();
}

class _AdaptivePageState extends State<AdaptivePage> {
  int selectedIndex = 0;

  final pages = const [
    'Home',
    'Search',
    'Profile',
  ];

  // Batas perubahan navigasi
  static const double threshold = 600;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        // Breakpoint
        final isWide = width >= threshold;

        final mode = isWide ? 'NavigationRail' : 'NavigationBar';

        return Scaffold(
          appBar: AppBar(
            title: const Text('Adaptive UI'),
          ),

          body: Row(
            children: [
              // NavigationRail untuk layar besar
              if (isWide)
                NavigationRail(
                  selectedIndex: selectedIndex,
                  labelType: NavigationRailLabelType.all,
                  onDestinationSelected: (index) {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  destinations: const [
                    NavigationRailDestination(
                      icon: Icon(Icons.home_outlined),
                      selectedIcon: Icon(Icons.home),
                      label: Text('Home'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.search_outlined),
                      selectedIcon: Icon(Icons.search),
                      label: Text('Search'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.person_outline),
                      selectedIcon: Icon(Icons.person),
                      label: Text('Profile'),
                    ),
                  ],
                ),

              // Konten
              Expanded(
                child: Column(
                  children: [
                    // Informasi Adaptive UI
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      color: const Color(0xff29282d),
                      child: Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Lebar: ${width.toInt()}px | Mode: $mode',
                            style: const TextStyle(
                              fontSize: 11,
                            ),
                          ),
                          const Row(
                            children: [
                              Text(
                                'Threshold: 600px',
                                style: TextStyle(
                                  fontSize: 11,
                                ),
                              ),
                              SizedBox(width: 3),
                              Icon(
                                Icons.arrow_drop_down,
                                size: 16,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Isi halaman
                    Expanded(
                      child: Center(
                        child: Text(
                          '${pages[selectedIndex]} (Mode Adaptif)',
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // NavigationBar untuk layar kecil
          bottomNavigationBar: isWide
              ? null
              : NavigationBar(
                  selectedIndex: selectedIndex,
                  onDestinationSelected: (index) {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  destinations: const [
                    NavigationDestination(
                      icon: Icon(Icons.home_outlined),
                      selectedIcon: Icon(Icons.home),
                      label: 'Home',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.search_outlined),
                      selectedIcon: Icon(Icons.search),
                      label: 'Search',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.person_outline),
                      selectedIcon: Icon(Icons.person),
                      label: 'Profile',
                    ),
                  ],
                ),
        );
      },
    );
  }
}