import 'package:flutter/material.dart';

class AccessibilityPage extends StatefulWidget {
  const AccessibilityPage({super.key});

  @override
  State<AccessibilityPage> createState() => _AccessibilityPageState();
}

class _AccessibilityPageState extends State<AccessibilityPage> {
  double textScale = 1.0;
  bool highContrast = false;
  bool showTooltip = true;
  bool isFavorite = false;

  void resetSettings() {
    setState(() {
      textScale = 1.0;
      highContrast = false;
      showTooltip = true;
      isFavorite = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = highContrast
        ? ColorScheme.fromSeed(
            seedColor: Colors.black,
            brightness: Brightness.light,
          )
        : Theme.of(context).colorScheme;

    return Theme(
      data: Theme.of(context).copyWith(
        colorScheme: colorScheme,
      ),
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(
          textScaler: TextScaler.linear(textScale),
        ),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Accessibility'),
            actions: [
              IconButton(
                tooltip: 'Reset pengaturan',
                onPressed: resetSettings,
                icon: const Icon(Icons.refresh),
              ),
            ],
          ),
          body: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              // ================= HEADER =================
              Semantics(
                header: true,
                child: Text(
                  'Accessibility Friendly UI',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),

              const SizedBox(height: 12),

              const Text(
                'Atur tampilan agar lebih mudah dibaca dan digunakan.',
              ),

              const SizedBox(height: 25),

              // ================= PREVIEW =================
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Semantics(
                        label: isFavorite
                            ? 'Produk sudah ditambahkan ke favorit'
                            : 'Produk belum ditambahkan ke favorit',
                        child: Icon(
                          isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          size: 70,
                          color: isFavorite
                              ? Colors.red
                              : colorScheme.primary,
                        ),
                      ),

                      const SizedBox(height: 12),

                      Text(
                        'Contoh Konten',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),

                      const SizedBox(height: 8),

                      const Text(
                        'Ukuran teks, kontras, label, dan area sentuh '
                        'dibuat agar lebih mudah digunakan.',
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: 20),

                      // ================= FAVORITE =================
                      Semantics(
                        button: true,
                        label: isFavorite
                            ? 'Hapus dari favorit'
                            : 'Tambah ke favorit',
                        hint: isFavorite
                            ? 'Tekan untuk menghapus favorit'
                            : 'Tekan untuk menambahkan favorit',
                        child: Tooltip(
                          message: showTooltip
                              ? (isFavorite
                                  ? 'Hapus dari favorit'
                                  : 'Tambah ke favorit')
                              : '',
                          child: SizedBox(
                            width: double.infinity,
                            height: 55,
                            child: FilledButton.icon(
                              onPressed: () {
                                setState(() {
                                  isFavorite = !isFavorite;
                                });

                                ScaffoldMessenger.of(context)
                                    .showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      isFavorite
                                          ? 'Ditambahkan ke favorit'
                                          : 'Dihapus dari favorit',
                                    ),
                                  ),
                                );
                              },
                              icon: Icon(
                                isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                              ),
                              label: Text(
                                isFavorite
                                    ? 'Sudah Favorit'
                                    : 'Tambah Favorit',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // ================= TEXT SIZE =================
              Text(
                'Ukuran Teks',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),

              Text(
                'Ukuran: ${(textScale * 100).round()}%',
              ),

              Slider(
                min: 0.8,
                max: 1.8,
                divisions: 10,
                value: textScale,
                label: '${(textScale * 100).round()}%',
                onChanged: (value) {
                  setState(() {
                    textScale = value;
                  });
                },
              ),

              const Divider(height: 30),

              // ================= HIGH CONTRAST =================
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Kontras Tinggi'),
                subtitle: const Text(
                  'Meningkatkan kontras warna agar lebih mudah dibaca',
                ),
                value: highContrast,
                onChanged: (value) {
                  setState(() {
                    highContrast = value;
                  });
                },
              ),

              // ================= TOOLTIP =================
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Tooltip'),
                subtitle: const Text(
                  'Menampilkan informasi tambahan saat menekan ikon',
                ),
                value: showTooltip,
                onChanged: (value) {
                  setState(() {
                    showTooltip = value;
                  });
                },
              ),

              const SizedBox(height: 20),

              // ================= ACCESSIBLE BUTTON =================
              Semantics(
                button: true,
                label: 'Tombol informasi accessibility',
                hint: 'Tekan untuk melihat informasi accessibility',
                child: SizedBox(
                  height: 55,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Accessibility'),
                            content: const Text(
                              'Accessibility membantu membuat aplikasi '
                              'lebih mudah digunakan oleh berbagai pengguna, '
                              'termasuk pengguna dengan keterbatasan tertentu.',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('Mengerti'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    icon: const Icon(Icons.accessibility),
                    label: const Text('Tentang Accessibility'),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              // ================= RESET =================
              TextButton.icon(
                onPressed: resetSettings,
                icon: const Icon(Icons.restart_alt),
                label: const Text('Reset Pengaturan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}