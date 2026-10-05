import 'package:flutter/material.dart';

class WidgetGalleryPage extends StatefulWidget {
  const WidgetGalleryPage({super.key});

  @override
  State<WidgetGalleryPage> createState() =>
      _WidgetGalleryPageState();
}

class _WidgetGalleryPageState
    extends State<WidgetGalleryPage> {
  int selectedIndex = 0;

  final widgets = [
    (
      'Buttons',
      Icons.smart_button,
      'FilledButton, OutlinedButton, TextButton',
    ),
    (
      'Input',
      Icons.input,
      'TextField dan TextFormField',
    ),
    (
      'Navigation',
      Icons.navigation,
      'NavigationBar dan NavigationRail',
    ),
    (
      'Feedback',
      Icons.notifications,
      'Dialog, Snackbar, BottomSheet',
    ),
    (
      'Selection',
      Icons.check_box,
      'Checkbox, Radio, Switch',
    ),
    (
      'Layout',
      Icons.dashboard,
      'Row, Column, Stack, Wrap',
    ),
    (
      'Animation',
      Icons.animation,
      'Implicit dan Explicit Animation',
    ),
    (
      'Scrolling',
      Icons.view_agenda,
      'ListView dan Sliver',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Widget Gallery'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // =========================
          // HEADER
          // =========================
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  colorScheme.primaryContainer,
                  colorScheme.secondaryContainer,
                ],
              ),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Row(
              children: [
                Container(
                  width: 58,
                  height: 58,
                  decoration: BoxDecoration(
                    color: colorScheme.primary,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: const Icon(
                    Icons.widgets,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Flutter Widget Gallery',
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Jelajahi dan coba berbagai widget Flutter',
                        style: TextStyle(
                          color:
                              colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // =========================
          // JUDUL
          // =========================
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Eksplorasi Widget',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${widgets.length} Widget',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color:
                        colorScheme.onPrimaryContainer,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 6),

          Text(
            'Pilih kategori untuk melihat contoh dan '
            'mencoba widget secara langsung.',
            style: TextStyle(
              color: colorScheme.onSurfaceVariant,
            ),
          ),

          const SizedBox(height: 16),

          // =========================
          // GRID KATEGORI
          // =========================
          GridView.builder(
            shrinkWrap: true,
            physics:
                const NeverScrollableScrollPhysics(),
            itemCount: widgets.length,
            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.15,
            ),
            itemBuilder: (context, index) {
              final item = widgets[index];
              final selected = selectedIndex == index;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                child: AnimatedContainer(
                  duration:
                      const Duration(milliseconds: 250),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: selected
                        ? colorScheme.primaryContainer
                        : colorScheme
                            .surfaceContainerHighest,
                    borderRadius:
                        BorderRadius.circular(20),
                    border: Border.all(
                      color: selected
                          ? colorScheme.primary
                          : Colors.transparent,
                      width: 2,
                    ),
                    boxShadow: selected
                        ? [
                            BoxShadow(
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                              color: colorScheme.primary
                                  .withValues(alpha: 0.15),
                            ),
                          ]
                        : [],
                  ),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: selected
                                  ? colorScheme.primary
                                  : colorScheme.surface,
                              borderRadius:
                                  BorderRadius.circular(14),
                            ),
                            child: Icon(
                              item.$2,
                              color: selected
                                  ? Colors.white
                                  : colorScheme.primary,
                              size: 26,
                            ),
                          ),
                          if (selected)
                            Icon(
                              Icons.check_circle,
                              color: colorScheme.primary,
                            )
                          else
                            const Icon(
                              Icons.arrow_forward_ios,
                              size: 15,
                            ),
                        ],
                      ),
                      const Spacer(),
                      Text(
                        item.$1,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        item.$3,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 11,
                          color:
                              colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 24),

          // =========================
          // WIDGET TERPILIH
          // =========================
          Row(
            children: [
              const Icon(Icons.touch_app),
              const SizedBox(width: 8),
              Text(
                'Widget yang Dipilih',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          AnimatedSwitcher(
            duration:
                const Duration(milliseconds: 300),
            child: _buildExample(
              widgets[selectedIndex].$1,
            ),
          ),
        ],
      ),
    );
  }

  // =========================
  // CONTOH WIDGET
  // =========================

  Widget _buildExample(String category) {
    switch (category) {
      case 'Buttons':
        return _buttons();

      case 'Input':
        return _input();

      case 'Navigation':
        return _navigation();

      case 'Feedback':
        return _feedback();

      case 'Selection':
        return _selection();

      case 'Layout':
        return _layout();

      case 'Animation':
        return _animation();

      case 'Scrolling':
        return _scrolling();

      default:
        return const SizedBox();
    }
  }

  // =========================
  // BUTTONS
  // =========================

  Widget _buttons() {
    return Card(
      key: const ValueKey('buttons'),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            FilledButton.icon(
              onPressed: () {
                _showSnackBar(
                  'FilledButton ditekan',
                );
              },
              icon: const Icon(Icons.check),
              label: const Text('Filled Button'),
            ),
            const SizedBox(height: 10),
            OutlinedButton(
              onPressed: () {
                _showSnackBar(
                  'OutlinedButton ditekan',
                );
              },
              child: const Text('Outlined Button'),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                _showSnackBar(
                  'TextButton ditekan',
                );
              },
              child: const Text('Text Button'),
            ),
          ],
        ),
      ),
    );
  }

  // =========================
  // INPUT
  // =========================

  Widget _input() {
    return Card(
      key: const ValueKey('input'),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const TextField(
              decoration: InputDecoration(
                labelText: 'Nama',
                hintText: 'Masukkan nama',
                prefixIcon:
                    Icon(Icons.person),
                border:
                    OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () {
                _showSnackBar(
                  'Input dikirim',
                );
              },
              child: const Text('Kirim'),
            ),
          ],
        ),
      ),
    );
  }

  // =========================
  // NAVIGATION
  // =========================

  Widget _navigation() {
    return Card(
      key: const ValueKey('navigation'),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: NavigationBar(
          selectedIndex: 0,
          onDestinationSelected: (index) {
            _showSnackBar(
              'Menu ${index + 1} dipilih',
            );
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            NavigationDestination(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }

  // =========================
  // FEEDBACK
  // =========================

  Widget _feedback() {
    return Card(
      key: const ValueKey('feedback'),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            FilledButton(
              onPressed: () {
                _showSnackBar(
                  'Contoh Snackbar',
                );
              },
              child: const Text(
                'Show Snackbar',
              ),
            ),
            const SizedBox(height: 10),
            OutlinedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text(
                        'Contoh Dialog',
                      ),
                      content: const Text(
                        'Ini adalah contoh Dialog Flutter.',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child:
                              const Text('Tutup'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text(
                'Show Dialog',
              ),
            ),
            const SizedBox(height: 10),
            OutlinedButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return const SizedBox(
                      height: 180,
                      child: Center(
                        child: Text(
                          'Contoh Bottom Sheet',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
              child: const Text(
                'Show Bottom Sheet',
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =========================
  // SELECTION
  // =========================

  Widget _selection() {
    bool checked = false;
    bool switched = false;
    int selectedRadio = 1;

    return StatefulBuilder(
      key: const ValueKey('selection'),
      builder: (context, setLocalState) {
        return Card(
          child: Column(
            children: [
              CheckboxListTile(
                title: const Text('Checkbox'),
                value: checked,
                onChanged: (value) {
                  setLocalState(() {
                    checked = value ?? false;
                  });
                },
              ),
              SwitchListTile(
                title: const Text('Switch'),
                subtitle: Text(
                  switched ? 'ON' : 'OFF',
                ),
                value: switched,
                onChanged: (value) {
                  setLocalState(() {
                    switched = value;
                  });
                },
              ),
              RadioListTile<int>(
                title:
                    const Text('Option 1'),
                value: 1,
                groupValue: selectedRadio,
                onChanged: (value) {
                  setLocalState(() {
                    selectedRadio = value!;
                  });
                },
              ),
              RadioListTile<int>(
                title:
                    const Text('Option 2'),
                value: 2,
                groupValue: selectedRadio,
                onChanged: (value) {
                  setLocalState(() {
                    selectedRadio = value!;
                  });
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // =========================
  // LAYOUT
  // =========================

  Widget _layout() {
    return Card(
      key: const ValueKey('layout'),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              'Row',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.center,
              children: [
                _layoutBox(),
                const SizedBox(width: 10),
                _layoutBox(),
                const SizedBox(width: 10),
                _layoutBox(),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Wrap',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Wrap(
              spacing: 8,
              children: [
                Chip(
                  label: Text('Flutter'),
                ),
                Chip(
                  label: Text('Dart'),
                ),
                Chip(
                  label: Text('UI'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _layoutBox() {
    return Container(
      width: 55,
      height: 55,
      decoration: BoxDecoration(
        color: Theme.of(context)
            .colorScheme
            .primaryContainer,
        borderRadius:
            BorderRadius.circular(12),
      ),
      child: const Icon(Icons.widgets),
    );
  }

  // =========================
  // ANIMATION
  // =========================

  Widget _animation() {
    return const _AnimationExample(
      key: ValueKey('animation'),
    );
  }

  // =========================
  // SCROLLING
  // =========================

  Widget _scrolling() {
    return SizedBox(
      key: const ValueKey('scrolling'),
      height: 300,
      child: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: 10,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                child: Text('${index + 1}'),
              ),
              title:
                  Text('Item ${index + 1}'),
              subtitle: const Text(
                'Contoh widget ListView',
              ),
            ),
          );
        },
      ),
    );
  }

  // =========================
  // SNACKBAR
  // =========================

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}

// ==========================================
// ANIMATION DEMO
// ==========================================

class _AnimationExample
    extends StatefulWidget {
  const _AnimationExample({
    super.key,
  });

  @override
  State<_AnimationExample> createState() =>
      _AnimationExampleState();
}

class _AnimationExampleState
    extends State<_AnimationExample> {
  bool active = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            AnimatedContainer(
              duration: const Duration(
                milliseconds: 500,
              ),
              width: active ? 180 : 100,
              height: active ? 180 : 100,
              decoration: BoxDecoration(
                color: active
                    ? Colors.indigo
                    : Colors.indigo.shade200,
                borderRadius:
                    BorderRadius.circular(
                  active ? 40 : 12,
                ),
              ),
              child: const Icon(
                Icons.animation,
                size: 50,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            FilledButton.icon(
              onPressed: () {
                setState(() {
                  active = !active;
                });
              },
              icon: const Icon(
                Icons.play_arrow,
              ),
              label: const Text(
                'Jalankan Animasi',
              ),
            ),
          ],
        ),
      ),
    );
  }
}