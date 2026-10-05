import 'dart:async';
import 'package:flutter/material.dart';

enum UiState {
  initial,
  loading,
  success,
  empty,
  error,
}

class UiStatePage extends StatefulWidget {
  const UiStatePage({super.key});

  @override
  State<UiStatePage> createState() => _UiStatePageState();
}

class _UiStatePageState extends State<UiStatePage> {
  UiState state = UiState.initial;
  Timer? timer;

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  // ================= LOAD DATA =================

  void loadData() {
    timer?.cancel();

    setState(() {
      state = UiState.loading;
    });

    timer = Timer(const Duration(seconds: 2), () {
      if (!mounted) return;

      setState(() {
        state = UiState.success;
      });
    });
  }

  void showError() {
    timer?.cancel();

    setState(() {
      state = UiState.error;
    });
  }

  void showEmpty() {
    timer?.cancel();

    setState(() {
      state = UiState.empty;
    });
  }

  void resetState() {
    timer?.cancel();

    setState(() {
      state = UiState.initial;
    });
  }

  // ================= STATE INFORMATION =================

  String get stateName {
    switch (state) {
      case UiState.initial:
        return 'Initial';
      case UiState.loading:
        return 'Loading';
      case UiState.success:
        return 'Success';
      case UiState.empty:
        return 'Empty';
      case UiState.error:
        return 'Error';
    }
  }

  String get stateDescription {
    switch (state) {
      case UiState.initial:
        return 'Aplikasi siap digunakan dan belum menjalankan proses.';
      case UiState.loading:
        return 'Aplikasi sedang mengambil dan memproses data.';
      case UiState.success:
        return 'Data berhasil dimuat dan siap ditampilkan.';
      case UiState.empty:
        return 'Proses berhasil, tetapi belum ada data yang tersedia.';
      case UiState.error:
        return 'Terjadi kesalahan saat memuat data.';
    }
  }

  IconData get stateIcon {
    switch (state) {
      case UiState.initial:
        return Icons.touch_app_rounded;
      case UiState.loading:
        return Icons.sync_rounded;
      case UiState.success:
        return Icons.check_circle_rounded;
      case UiState.empty:
        return Icons.inbox_rounded;
      case UiState.error:
        return Icons.error_rounded;
    }
  }

  Color get stateColor {
    switch (state) {
      case UiState.initial:
        return Colors.indigo;
      case UiState.loading:
        return Colors.orange;
      case UiState.success:
        return Colors.green;
      case UiState.empty:
        return Colors.blueGrey;
      case UiState.error:
        return Colors.red;
    }
  }

  // ================= STATE CARD =================

  Widget buildStateCard() {
    final color = stateColor;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            color.withValues(alpha: 0.15),
            color.withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: color.withValues(alpha: 0.25),
        ),
      ),
      child: Column(
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: state == UiState.loading
                ? SizedBox(
                    key: const ValueKey('loading'),
                    width: 75,
                    height: 75,
                    child: CircularProgressIndicator(
                      strokeWidth: 6,
                      color: color,
                    ),
                  )
                : Icon(
                    key: ValueKey(state),
                    stateIcon,
                    size: 75,
                    color: color,
                  ),
          ),

          const SizedBox(height: 20),

          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: Text(
              stateName,
              key: ValueKey(stateName),
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ),

          const SizedBox(height: 10),

          Text(
            stateDescription,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 15,
              height: 1.5,
            ),
          ),

          const SizedBox(height: 20),

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'CURRENT STATE: ${stateName.toUpperCase()}',
              style: TextStyle(
                color: color,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ================= STATE FLOW =================

  Widget buildStateFlow() {
    final states = [
      UiState.initial,
      UiState.loading,
      UiState.success,
      UiState.empty,
      UiState.error,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'State Flow',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 12),

        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (int i = 0; i < states.length; i++) ...[
                _buildFlowItem(states[i]),
                if (i != states.length - 1)
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6),
                    child: Icon(
                      Icons.arrow_forward_rounded,
                      size: 18,
                    ),
                  ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFlowItem(UiState item) {
    final active = state == item;

    String name;

    switch (item) {
      case UiState.initial:
        name = 'Initial';
        break;
      case UiState.loading:
        name = 'Loading';
        break;
      case UiState.success:
        name = 'Success';
        break;
      case UiState.empty:
        name = 'Empty';
        break;
      case UiState.error:
        name = 'Error';
        break;
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: active
            ? stateColor.withValues(alpha: 0.15)
            : Theme.of(context)
                .colorScheme
                .surfaceContainerHighest,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: active ? stateColor : Colors.transparent,
          width: 1.5,
        ),
      ),
      child: Text(
        name,
        style: TextStyle(
          fontWeight:
              active ? FontWeight.bold : FontWeight.normal,
          color: active ? stateColor : null,
        ),
      ),
    );
  }

  // ================= ACTION BUTTON =================

  Widget buildMainButton() {
    if (state == UiState.loading) {
      return const SizedBox(
        width: double.infinity,
        height: 52,
        child: FilledButton(
          onPressed: null,
          child: Text('Sedang Memuat...'),
        ),
      );
    }

    if (state == UiState.error) {
      return SizedBox(
        width: double.infinity,
        height: 52,
        child: FilledButton.icon(
          onPressed: loadData,
          icon: const Icon(Icons.refresh),
          label: const Text('Coba Lagi'),
        ),
      );
    }

    if (state == UiState.success) {
      return SizedBox(
        width: double.infinity,
        height: 52,
        child: FilledButton.icon(
          onPressed: showEmpty,
          icon: const Icon(Icons.inbox_outlined),
          label: const Text('Simulasikan Data Kosong'),
        ),
      );
    }

    if (state == UiState.empty) {
      return SizedBox(
        width: double.infinity,
        height: 52,
        child: FilledButton.icon(
          onPressed: loadData,
          icon: const Icon(Icons.refresh),
          label: const Text('Muat Data Kembali'),
        ),
      );
    }

    return SizedBox(
      width: double.infinity,
      height: 52,
      child: FilledButton.icon(
        onPressed: loadData,
        icon: const Icon(Icons.download_rounded),
        label: const Text('Muat Data'),
      ),
    );
  }

  // ================= BUILD =================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UI State'),
        actions: [
          IconButton(
            tooltip: 'Reset',
            onPressed: resetState,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),

      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Header
          const Text(
            'State Monitor',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            'Lihat bagaimana tampilan aplikasi berubah '
            'berdasarkan kondisi yang sedang terjadi.',
            style: TextStyle(
              color: Theme.of(context)
                  .colorScheme
                  .onSurfaceVariant,
              height: 1.4,
            ),
          ),

          const SizedBox(height: 24),

          // State Card
          buildStateCard(),

          const SizedBox(height: 28),

          // Main Action
          buildMainButton(),

          const SizedBox(height: 28),

          // State Flow
          buildStateFlow(),

          const SizedBox(height: 28),

          // Simulation
          const Text(
            'Coba State Lain',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              OutlinedButton(
                onPressed: resetState,
                child: const Text('Initial'),
              ),
              OutlinedButton(
                onPressed: () {
                  setState(() {
                    state = UiState.loading;
                  });
                },
                child: const Text('Loading'),
              ),
              OutlinedButton(
                onPressed: () {
                  setState(() {
                    state = UiState.success;
                  });
                },
                child: const Text('Success'),
              ),
              OutlinedButton(
                onPressed: showEmpty,
                child: const Text('Empty'),
              ),
              OutlinedButton(
                onPressed: showError,
                child: const Text('Error'),
              ),
            ],
          ),

          const SizedBox(height: 25),

          // Information
          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.lightbulb_outline,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'UI State membantu aplikasi menampilkan '
                      'informasi yang sesuai dengan kondisi proses, '
                      'seperti loading, berhasil, kosong, atau error.',
                      style: TextStyle(
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}