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
      home: const ResponsivePage(),
    );
  }
}

class ResponsivePage extends StatelessWidget {
  const ResponsivePage({super.key});

  @override
  Widget build(BuildContext context) {
    // MediaQuery: mengambil ukuran layar
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xff121212),

      appBar: AppBar(
        title: const Text('Responsive UI'),
        backgroundColor: const Color(0xff1e1e1e),
      ),

      // LayoutBuilder: menyesuaikan layout berdasarkan ruang yang tersedia
      body: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;

          // Breakpoint
          int columns;

          if (width < 500) {
            columns = 1;
          } else if (width < 900) {
            columns = 2;
          } else {
            columns = 4;
          }

          // Responsive spacing
          final spacing = screenWidth < 500 ? 10.0 : 20.0;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Informasi ukuran layar
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spacing),
                color: Colors.indigo,
                child: Text(
                  'Lebar Layar: ${screenWidth.toInt()} px | '
                  'Jumlah Kolom: $columns',
                  textAlign: TextAlign.center,
                ),
              ),

              // Responsive Grid
              Expanded(
                child: GridView.builder(
                  padding: EdgeInsets.all(spacing),
                  gridDelegate:
                      SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: columns,
                    crossAxisSpacing: spacing,
                    mainAxisSpacing: spacing,
                    childAspectRatio: 1.5,
                  ),
                  itemCount: 12,
                  itemBuilder: (context, index) {
                    return Card(
                      color: const Color(0xff1e1e1e),
                      child: Center(
                        child: Text(
                          'Eksperimen ${index + 1}',
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}