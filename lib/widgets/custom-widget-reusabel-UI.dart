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
      home: const CustomWidgetPage(),
    );
  }
}

class CustomWidgetPage extends StatelessWidget {
  const CustomWidgetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reusable UI'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: const [
          ProfileCard(
            name: 'Ahmad',
            role: 'Flutter Developer',
            icon: Icons.code,
          ),
          ProfileCard(
            name: 'Budi',
            role: 'UI/UX Designer',
            icon: Icons.design_services,
          ),
          ProfileCard(
            name: 'Citra',
            role: 'Mobile Developer',
            icon: Icons.phone_android,
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

  const ProfileCard({
    super.key,
    required this.name,
    required this.role,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              child: Icon(icon),
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
                  Text(role),
                ],
              ),
            ),
            const Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }
}