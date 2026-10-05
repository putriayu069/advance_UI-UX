import 'package:flutter/material.dart';

class MicroInteractionPage extends StatefulWidget {
  const MicroInteractionPage({super.key});

  @override
  State<MicroInteractionPage> createState() =>
      _MicroInteractionPageState();
}

class _MicroInteractionPageState
    extends State<MicroInteractionPage> {
  bool favorite = false;
  bool bookmarked = false;
  bool expanded = false;
  bool pressed = false;

  int likes = 24;

  void toggleFavorite() {
    setState(() {
      favorite = !favorite;
      likes += favorite ? 1 : -1;
    });
  }

  void resetInteraction() {
    setState(() {
      favorite = false;
      bookmarked = false;
      expanded = false;
      pressed = false;
      likes = 24;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Micro Interaction'),
        actions: [
          IconButton(
            tooltip: 'Reset',
            onPressed: resetInteraction,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Interactive Components',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            'Coba berbagai interaksi kecil untuk melihat '
            'feedback animasi pada aplikasi.',
            style: TextStyle(
              color: Theme.of(context)
                  .colorScheme
                  .onSurfaceVariant,
            ),
          ),

          const SizedBox(height: 25),

          // ================= INTERACTIVE CARD =================

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
              duration: const Duration(milliseconds: 120),
              child: Card(
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const CircleAvatar(
                            radius: 30,
                            child: Icon(
                              Icons.flutter_dash,
                              size: 32,
                            ),
                          ),

                          const SizedBox(width: 15),

                          const Expanded(
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Interactive Card',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight:
                                        FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Tekan kartu untuk melihat '
                                  'efek micro interaction.',
                                ),
                              ],
                            ),
                          ),

                          // Bookmark
                          IconButton(
                            tooltip: bookmarked
                                ? 'Hapus bookmark'
                                : 'Simpan bookmark',
                            onPressed: () {
                              setState(() {
                                bookmarked = !bookmarked;
                              });

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(
                                SnackBar(
                                  duration:
                                      const Duration(
                                    milliseconds: 800,
                                  ),
                                  content: Text(
                                    bookmarked
                                        ? 'Disimpan ke bookmark'
                                        : 'Bookmark dihapus',
                                  ),
                                ),
                              );
                            },
                            icon: AnimatedSwitcher(
                              duration:
                                  const Duration(
                                milliseconds: 250,
                              ),
                              child: Icon(
                                bookmarked
                                    ? Icons.bookmark
                                    : Icons.bookmark_border,
                                key: ValueKey(bookmarked),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      const Divider(),

                      // Like
                      Row(
                        children: [
                          IconButton(
                            tooltip: favorite
                                ? 'Hapus like'
                                : 'Like',
                            onPressed: toggleFavorite,
                            icon: AnimatedSwitcher(
                              duration:
                                  const Duration(
                                milliseconds: 300,
                              ),
                              transitionBuilder:
                                  (child, animation) {
                                return ScaleTransition(
                                  scale: animation,
                                  child: child,
                                );
                              },
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

                          AnimatedSwitcher(
                            duration:
                                const Duration(
                              milliseconds: 200,
                            ),
                            child: Text(
                              '$likes Likes',
                              key: ValueKey(likes),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          const Spacer(),

                          AnimatedOpacity(
                            opacity:
                                bookmarked ? 1 : 0.5,
                            duration:
                                const Duration(
                              milliseconds: 200,
                            ),
                            child: const Icon(
                              Icons.bookmark,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // ================= EXPANDABLE =================

          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const CircleAvatar(
                    child: Icon(Icons.info_outline),
                  ),
                  title: const Text(
                    'Expandable Content',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    expanded
                        ? 'Konten sedang dibuka'
                        : 'Tekan untuk melihat detail',
                  ),
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
                  duration:
                      const Duration(milliseconds: 300),
                  crossFadeState: expanded
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                  firstChild:
                      const SizedBox.shrink(),
                  secondChild: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    child: const Text(
                      'Konten tambahan ditampilkan '
                      'menggunakan animasi sehingga perubahan '
                      'terasa lebih halus.',
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // ================= ACTION BUTTON =================

          FilledButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Micro interaction berhasil dijalankan!',
                  ),
                ),
              );
            },
            icon: const Icon(Icons.touch_app),
            label: const Text('Coba Interaction'),
          ),

          const SizedBox(height: 10),

          OutlinedButton.icon(
            onPressed: resetInteraction,
            icon: const Icon(Icons.restart_alt),
            label: const Text('Reset Semua'),
          ),
        ],
      ),
    );
  }
}