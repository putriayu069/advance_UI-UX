import 'package:flutter/material.dart';

class CustomWidgetPage extends StatefulWidget {
  const CustomWidgetPage({super.key});

  @override
  State<CustomWidgetPage> createState() => _CustomWidgetPageState();
}

class _CustomWidgetPageState extends State<CustomWidgetPage> {
  final List<Map<String, dynamic>> users = [
    {
      'name': 'Ahmad',
      'role': 'Flutter Developer',
      'icon': Icons.code,
      'favorite': false,
      'active': true,
    },
    {
      'name': 'Budi',
      'role': 'UI/UX Designer',
      'icon': Icons.design_services,
      'favorite': false,
      'active': false,
    },
    {
      'name': 'Citra',
      'role': 'Mobile Developer',
      'icon': Icons.phone_android,
      'favorite': false,
      'active': true,
    },
  ];

  void toggleFavorite(int index) {
    setState(() {
      users[index]['favorite'] = !users[index]['favorite'];
    });
  }

  void toggleActive(int index, bool value) {
    setState(() {
      users[index]['active'] = value;
    });
  }

  void showProfile(int index) {
    final user = users[index];

    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 35,
                child: Icon(
                  user['icon'],
                  size: 35,
                ),
              ),

              const SizedBox(height: 12),

              Text(
                user['name'],
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Text(user['role']),

              const SizedBox(height: 12),

              Text(
                user['active']
                    ? 'Status: Aktif'
                    : 'Status: Nonaktif',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: user['active']
                      ? Colors.green
                      : Colors.grey,
                ),
              ),

              const SizedBox(height: 20),

              FilledButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.close),
                label: const Text('Tutup'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Widget & Reusable UI'),
      ),

      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Daftar Anggota',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 6),

          const Text(
            'Setiap card menggunakan Custom Widget '
            'yang dapat digunakan kembali.',
          ),

          const SizedBox(height: 20),

          ...List.generate(
            users.length,
            (index) {
              final user = users[index];

              return ProfileCard(
                name: user['name'],
                role: user['role'],
                icon: user['icon'],
                isFavorite: user['favorite'],
                isActive: user['active'],
                onTap: () => showProfile(index),
                onFavorite: () => toggleFavorite(index),
                onActiveChanged: (value) {
                  toggleActive(index, value);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  final String name;
  final String role;
  final IconData icon;
  final bool isFavorite;
  final bool isActive;

  final VoidCallback onTap;
  final VoidCallback onFavorite;
  final ValueChanged<bool> onActiveChanged;

  const ProfileCard({
    super.key,
    required this.name,
    required this.role,
    required this.icon,
    required this.isFavorite,
    required this.isActive,
    required this.onTap,
    required this.onFavorite,
    required this.onActiveChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),

      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),

        child: Padding(
          padding: const EdgeInsets.all(16),

          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    child: Icon(
                      icon,
                      size: 28,
                    ),
                  ),

                  const SizedBox(width: 16),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 4),

                        Text(role),

                        const SizedBox(height: 6),

                        Text(
                          isActive
                              ? '● Aktif'
                              : '● Nonaktif',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: isActive
                                ? Colors.green
                                : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),

                  IconButton(
                    onPressed: onFavorite,
                    icon: Icon(
                      isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border,
                    ),
                  ),
                ],
              ),

              const Divider(),

              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Status Aktif',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  Switch(
                    value: isActive,
                    onChanged: onActiveChanged,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}