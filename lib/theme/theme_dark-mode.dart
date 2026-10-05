import 'package:flutter/material.dart';

class ThemePage extends StatefulWidget {
  const ThemePage({super.key});

  @override
  State<ThemePage> createState() => _ThemePageState();
}

class _ThemePageState extends State<ThemePage> {
  ThemeMode themeMode = ThemeMode.light;
  Color selectedColor = Colors.blue;

  bool get isDark => themeMode == ThemeMode.dark;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: selectedColor,
        brightness: isDark
            ? Brightness.dark
            : Brightness.light,
      ),
      child: Builder(
        builder: (context) {
          final colorScheme =
              Theme.of(context).colorScheme;

          return Scaffold(
            appBar: AppBar(
              title: const Text('Theme & Dark Mode'),
              centerTitle: true,
            ),

            body: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const SizedBox(height: 15),

                  // Icon mode
                  Container(
                    width: 110,
                    height: 110,
                    decoration: BoxDecoration(
                      color: colorScheme.primaryContainer,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isDark
                          ? Icons.dark_mode
                          : Icons.light_mode,
                      size: 55,
                      color: colorScheme.primary,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Status mode
                  Text(
                    isDark
                        ? 'Dark Mode'
                        : 'Light Mode',
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    isDark
                        ? 'Tampilan gelap sedang aktif'
                        : 'Tampilan terang sedang aktif',
                  ),

                  const SizedBox(height: 25),

                  // Switch Dark Mode
                  Card(
                    child: SwitchListTile(
                      title: const Text(
                        'Dark Mode',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        isDark
                            ? 'Aktif'
                            : 'Tidak aktif',
                      ),
                      secondary: Icon(
                        isDark
                            ? Icons.nightlight
                            : Icons.wb_sunny,
                      ),
                      value: isDark,
                      onChanged: (value) {
                        setState(() {
                          themeMode = value
                              ? ThemeMode.dark
                              : ThemeMode.light;
                        });
                      },
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Pilihan warna
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Warna Tema',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 8),

                          const Text(
                            'Pilih warna untuk mengubah '
                            'ColorScheme aplikasi.',
                          ),

                          const SizedBox(height: 20),

                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                            children: [
                              _colorButton(
                                Colors.blue,
                                'Blue',
                              ),
                              _colorButton(
                                Colors.green,
                                'Green',
                              ),
                              _colorButton(
                                Colors.orange,
                                'Orange',
                              ),
                              _colorButton(
                                Colors.purple,
                                'Purple',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Contoh komponen yang mengikuti theme
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Preview Theme',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 15),

                          Text(
                            'Komponen berikut mengikuti '
                            'warna dan mode tema yang dipilih.',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium,
                          ),

                          const SizedBox(height: 20),

                          SizedBox(
                            width: double.infinity,
                            child: FilledButton.icon(
                              onPressed: () {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Theme sedang digunakan',
                                    ),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.check),
                              label: const Text(
                                'Coba Button',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Informasi theme
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: colorScheme.primaryContainer,
                      borderRadius:
                          BorderRadius.circular(18),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.palette_outlined,
                          color:
                              colorScheme.onPrimaryContainer,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Theme: ${isDark ? 'Dark' : 'Light'} • '
                            'Warna: ${_colorName(selectedColor)}',
                            style: TextStyle(
                              color:
                                  colorScheme.onPrimaryContainer,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
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

  Widget _colorButton(Color color, String name) {
    final selected = selectedColor == color;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedColor = color;
        });
      },
      child: Column(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              border: selected
                  ? Border.all(
                      color: Colors.black,
                      width: 3,
                    )
                  : null,
            ),
            child: selected
                ? const Icon(
                    Icons.check,
                    color: Colors.white,
                  )
                : null,
          ),
          const SizedBox(height: 6),
          Text(name),
        ],
      ),
    );
  }

  String _colorName(Color color) {
    if (color == Colors.green) return 'Green';
    if (color == Colors.orange) return 'Orange';
    if (color == Colors.purple) return 'Purple';
    return 'Blue';
  }
}