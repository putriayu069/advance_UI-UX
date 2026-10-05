import 'package:flutter/material.dart';

class DesignSystemPage extends StatefulWidget {
  const DesignSystemPage({super.key});

  @override
  State<DesignSystemPage> createState() => _DesignSystemPageState();
}

class _DesignSystemPageState extends State<DesignSystemPage> {
  bool material3 = true;
  String selectedColor = 'Teal';

  Color get seedColor {
    switch (selectedColor) {
      case 'Blue':
        return Colors.blue;
      case 'Orange':
        return Colors.orange;
      case 'Purple':
        return Colors.purple;
      default:
        return Colors.teal;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        useMaterial3: material3,
        colorScheme: ColorScheme.fromSeed(seedColor: seedColor),
      ),
      child: Builder(
        builder: (context) {
          final theme = Theme.of(context);
          final colors = theme.colorScheme;
          final titleStyle = theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          );

          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'Material 3 Explorer',
                style: TextStyle(fontSize: 18),
              ),
            ),
            body: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // Card pengaturan
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Eksperimen Material 3',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Gunakan Material 3'),
                            Switch(
                              value: material3,
                              onChanged: (value) {
                                setState(() => material3 = value);
                              },
                            ),
                          ],
                        ),
                        const Divider(),
                        const Text(
                          'Pilih Seed Color',
                          style: TextStyle(fontSize: 13),
                        ),
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 8,
                          children: [
                            _colorButton('Teal'),
                            _colorButton('Blue'),
                            _colorButton('Orange'),
                            _colorButton('Purple'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 18),

                // TextTheme
                Text('Typography', style: titleStyle),
                const SizedBox(height: 8),
                Text('Display Large', style: theme.textTheme.displaySmall),
                Text('Headline Medium', style: theme.textTheme.headlineMedium),
                Text('Body Large', style: theme.textTheme.bodyLarge),

                const SizedBox(height: 18),

                // ColorScheme
                Text('Color Scheme', style: titleStyle),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    ColorBox(label: 'Primary', color: colors.primary),
                    ColorBox(label: 'Secondary', color: colors.secondary),
                    ColorBox(label: 'Tertiary', color: colors.tertiary),
                    ColorBox(label: 'Error', color: colors.error),
                  ],
                ),

                const SizedBox(height: 18),

                // Buttons
                Text('Buttons', style: titleStyle),
                const SizedBox(height: 10),
                FilledButton(
                  onPressed: () {},
                  child: const Text('Filled Button'),
                ),
                const SizedBox(height: 8),
                OutlinedButton(
                  onPressed: () {},
                  child: const Text('Outlined Button'),
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () {},
                  child: const Text('Text Button'),
                ),

                const SizedBox(height: 18),

                // TextField
                Text('TextField', style: titleStyle),
                const SizedBox(height: 10),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Nama',
                    hintText: 'Masukkan nama',
                    prefixIcon: const Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                const SizedBox(height: 18),

                // Card
                Text('Card', style: titleStyle),
                const SizedBox(height: 10),
                Card(
                  color: colors.primaryContainer,
                  child: const ListTile(
                    leading: Icon(Icons.design_services),
                    title: Text(
                      'Material 3 Card',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('Contoh penggunaan Card.'),
                  ),
                ),

                const SizedBox(height: 18),

                // Reusable Widget
                Text('Reusable Widget', style: titleStyle),
                const SizedBox(height: 10),
                const InfoCard(
                  icon: Icons.widgets,
                  title: 'Reusable Widget',
                  description: 'Widget dapat digunakan kembali.',
                ),

                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _colorButton(String colorName) {
    final selected = selectedColor == colorName;

    return OutlinedButton(
      onPressed: () {
        setState(() => selectedColor = colorName);
      },
      style: OutlinedButton.styleFrom(
        backgroundColor:
            selected ? seedColor.withValues(alpha: 0.15) : null,
      ),
      child: Text(selected ? '✓ $colorName' : colorName),
    );
  }
}

// Reusable Widget 1
class ColorBox extends StatelessWidget {
  final String label;
  final Color color;

  const ColorBox({
    super.key,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 105,
      height: 65,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

// Reusable Widget 2
class InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const InfoCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(description),
      ),
    );
  }
}