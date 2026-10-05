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
      title: 'Feedback UI',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.orange,
      ),
      home: const FeedbackPage(),
    );
  }
}

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {

  // Untuk mengontrol Overlay
  OverlayEntry? overlayEntry;

  // =========================
  // 1. DIALOG
  // =========================
  void showDialogExample() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Row(
            children: [
              Icon(Icons.info_outline),
              SizedBox(width: 10),
              Text('Dialog'),
            ],
          ),
          content: const Text(
            'Ini adalah contoh Dialog untuk memberikan informasi atau meminta konfirmasi kepada pengguna.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Tutup'),
            ),
          ],
        );
      },
    );
  }

  // =========================
  // 2. BOTTOM SHEET
  // =========================
  void showSheet() {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Pilih Sumber',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 16),

                ListTile(
                  leading: const CircleAvatar(
                    child: Icon(Icons.camera_alt),
                  ),
                  title: const Text('Camera'),
                  subtitle: const Text(
                    'Ambil gambar menggunakan kamera',
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    showMessage('Camera dipilih');
                  },
                ),

                ListTile(
                  leading: const CircleAvatar(
                    child: Icon(Icons.photo),
                  ),
                  title: const Text('Gallery'),
                  subtitle: const Text(
                    'Pilih gambar dari galeri',
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    showMessage('Gallery dipilih');
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // =========================
  // 3. SNACKBAR
  // =========================
  void showMessage(String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {},
        ),
      ),
    );
  }

  // =========================
  // 4. OVERLAY
  // =========================
  void showOverlay() {
    // Jika Overlay sudah muncul, jangan buat lagi
    if (overlayEntry != null) return;

    overlayEntry = OverlayEntry(
      builder: (context) {
        return Positioned(
          top: 100,
          right: 20,
          left: 20,
          child: Material(
            color: Colors.transparent,
            child: Card(
              elevation: 8,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor:
                          Theme.of(context)
                              .colorScheme
                              .primaryContainer,
                      child: Icon(
                        Icons.notifications_active,
                        color: Theme.of(context)
                            .colorScheme
                            .onPrimaryContainer,
                      ),
                    ),

                    const SizedBox(width: 12),

                    const Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Overlay Aktif',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Ini adalah contoh elemen yang tampil di atas UI.',
                          ),
                        ],
                      ),
                    ),

                    IconButton(
                      onPressed: hideOverlay,
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );

    Overlay.of(context).insert(overlayEntry!);
  }

  void hideOverlay() {
    overlayEntry?.remove();
    overlayEntry = null;
  }

  @override
  void dispose() {
    hideOverlay();
    super.dispose();
  }

  // =========================
  // TAMPILAN
  // =========================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feedback UI'),
      ),

      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [

          const Text(
            'Dialog, Bottom Sheet, Snackbar & Overlay',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            'Eksperimen berbagai jenis feedback dan interaction UI.',
          ),

          const SizedBox(height: 20),

          // CARD DIALOG
          FeedbackCard(
            icon: Icons.chat_bubble_outline,
            title: 'Dialog',
            description:
                'Menampilkan informasi atau konfirmasi.',
            buttonText: 'Show Dialog',
            onPressed: showDialogExample,
          ),

          const SizedBox(height: 12),

          // CARD BOTTOM SHEET
          FeedbackCard(
            icon: Icons.keyboard_arrow_up,
            title: 'Bottom Sheet',
            description:
                'Menampilkan pilihan dari bagian bawah layar.',
            buttonText: 'Show Bottom Sheet',
            onPressed: showSheet,
          ),

          const SizedBox(height: 12),

          // CARD SNACKBAR
          FeedbackCard(
            icon: Icons.notifications_none,
            title: 'Snackbar',
            description:
                'Menampilkan pesan singkat setelah aksi.',
            buttonText: 'Show Snackbar',
            onPressed: () {
              showMessage('Data berhasil disimpan');
            },
          ),

          const SizedBox(height: 12),

          // CARD OVERLAY
          FeedbackCard(
            icon: Icons.layers_outlined,
            title: 'Overlay',
            description:
                'Menampilkan elemen sementara di atas UI.',
            buttonText: 'Show Overlay',
            onPressed: showOverlay,
          ),
        ],
      ),
    );
  }
}


// ======================================
// REUSABLE WIDGET UNTUK KARTU FEEDBACK
// ======================================

class FeedbackCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final String buttonText;
  final VoidCallback onPressed;

  const FeedbackCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Row(
              children: [
                CircleAvatar(
                  backgroundColor: colors.primaryContainer,
                  child: Icon(
                    icon,
                    color: colors.onPrimaryContainer,
                  ),
                ),

                const SizedBox(width: 12),

                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            Text(description),

            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: onPressed,
                child: Text(buttonText),
              ),
            ),
          ],
        ),
      ),
    );
  }
}