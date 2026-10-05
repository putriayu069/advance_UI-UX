import 'package:flutter/material.dart';

// ===== Import tiap halaman =====
// Memakai prefix (as ...) karena setiap file lama punya main() dan MyApp
// sendiri, supaya namanya tidak bentrok dengan main() / MyApp di file ini.
import 'accessibility/accessibility.dart';
import 'effects/clip-and-visual-effect.dart' as clip_effect;
import 'effects/custom-painter.dart' as custom_painter;
import 'effects/micro-interaction.dart';
import 'effects/opacity-transform-filter.dart' as opacity_filter;
import 'feedback/loading-and-feedback.dart' as loading_feedback;
import 'feedback/skeleton-loading-and-shimer.dart' as skeleton;
import 'layout/interactive_layout.dart';
import 'responsive/adaptive.dart';
import 'responsive/adaptive_layout.dart' as adaptive_layout;
import 'responsive/adaptive_scroll.dart' as adaptive_scroll;
import 'responsive/responsive.dart';
import 'state/UI-state.dart';
import 'theme/design_sistem.dart';
import 'theme/theme_dark-mode.dart' as theme_dark;
import 'widgets/advance_form.dart' as advance_form;
import 'widgets/custom-widget-reusabel-UI.dart' as custom_widget;
import 'widgets/dialog_bottom_snackbar.dart' as dialog_snackbar;
import 'widgets/widget-gallery.dart';

void main() {
  runApp(const MyApp());
}

/// Mengatur mode tema (terang / gelap / ikuti sistem) untuk seluruh app.
final ValueNotifier<ThemeMode> themeModeNotifier =
    ValueNotifier<ThemeMode>(ThemeMode.system);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeModeNotifier,
      builder: (context, mode, _) {
        return MaterialApp(
          title: 'Flutter UI Lab',
          debugShowCheckedModeBanner: false,
          themeMode: mode,
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.green,
              brightness: Brightness.dark,
            ),
          ),
          home: const HomePage(),
        );
      },
    );
  }
}

/// Untuk file yang isinya berupa app utuh (punya MaterialApp sendiri) dan
/// tidak punya class halaman, seperti theme_dark-mode.dart.
/// App itu tidak punya tombol kembali, jadi ditambah tombol melayang.
class _EmbeddedApp extends StatelessWidget {
  final Widget app;
  const _EmbeddedApp(this.app);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        app,
        Positioned(
          left: 16,
          bottom: 16,
          child: SafeArea(
            child: FloatingActionButton.small(
              heroTag: null,
              tooltip: 'Kembali ke menu',
              onPressed: () => Navigator.of(context).pop(),
              child: const Icon(Icons.arrow_back),
            ),
          ),
        ),
      ],
    );
  }
}

/// Satu item menu di halaman utama.
class _MenuItem {
  final String title;
  final IconData icon;
  final WidgetBuilder builder;
  const _MenuItem(this.title, this.icon, this.builder);
}

class _MenuSection {
  final String title;
  final List<_MenuItem> items;
  const _MenuSection(this.title, this.items);
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // Nama class di bawah mengikuti isi file asli kamu.
  // Bertanda "(cek nama class)" = file belum pernah saya lihat, nama masih
  // tebakan. Kalau merah, ganti dengan nama class di file tersebut.
  static final List<_MenuSection> _sections = [
    _MenuSection('Tema & Design System', [
      _MenuItem('Design System', Icons.palette,
          (_) => const DesignSystemPage()),
      _MenuItem('Tema Dark Mode', Icons.dark_mode,
          (_) => const _EmbeddedApp(theme_dark.MyApp())),
    ]),
    _MenuSection('Responsive & Adaptive', [
      // (cek nama class)
      _MenuItem('Responsive', Icons.devices, (_) => ResponsivePage()),
      // (cek nama class)
      _MenuItem('Adaptive', Icons.phone_android, (_) => AdaptivePage()),
      _MenuItem('Adaptive Layout', Icons.dashboard_customize,
          (_) => const adaptive_layout.LayoutPage()),
      _MenuItem('Adaptive Scroll', Icons.swap_vert,
          (_) => const adaptive_scroll.SliverPage()),
    ]),
    _MenuSection('Widget & Form', [
      // (cek nama class)
      _MenuItem('Galeri Widget', Icons.widgets, (_) => WidgetGalleryPage()),
      _MenuItem('Custom Widget Reusable', Icons.extension,
          (_) => const custom_widget.CustomWidgetPage()),
      _MenuItem('Form Lanjutan', Icons.edit_note,
          (_) => const advance_form.FormPage()),
      _MenuItem('Dialog, BottomSheet & Snackbar', Icons.chat_bubble,
          (_) => const dialog_snackbar.FeedbackPage()),
    ]),
    _MenuSection('Efek & Animasi', [
      _MenuItem('Clip & Visual Effect', Icons.content_cut,
          (_) => const clip_effect.VisualPage()),
      _MenuItem('Custom Painter', Icons.brush,
          (_) => const custom_painter.PainterPage()),
      // (cek nama class)
      _MenuItem('Micro Interaction', Icons.touch_app,
          (_) => MicroInteractionPage()),
      _MenuItem('Opacity, Transform & Filter', Icons.filter_b_and_w,
          (_) => const opacity_filter.TransformPage()),
    ]),
    _MenuSection('Loading & Feedback', [
      _MenuItem('Loading & Feedback', Icons.hourglass_bottom,
          (_) => const loading_feedback.LoadingPage()),
      _MenuItem('Skeleton & Shimmer', Icons.blur_on,
          (_) => const skeleton.SkeletonPage()),
    ]),
    _MenuSection('Lainnya', [
      // (cek nama class)
      _MenuItem('UI State', Icons.sync_alt, (_) => UiStatePage()),
      _MenuItem('Interactive Layout', Icons.view_quilt,
          (_) => const InteractiveLayoutPage()),
      // (cek nama class)
      _MenuItem('Accessibility', Icons.accessibility_new,
          (_) => AccessibilityPage()),
    ]),
  ];

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter UI Lab'),
        actions: [
          ValueListenableBuilder<ThemeMode>(
            valueListenable: themeModeNotifier,
            builder: (context, mode, _) {
              final isDark = mode == ThemeMode.dark ||
                  (mode == ThemeMode.system &&
                      MediaQuery.platformBrightnessOf(context) ==
                          Brightness.dark);
              return IconButton(
                tooltip: 'Ganti tema',
                icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
                onPressed: () => themeModeNotifier.value =
                    isDark ? ThemeMode.light : ThemeMode.dark,
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          for (final section in _sections) ...[
            Padding(
              padding: const EdgeInsets.only(top: 12, bottom: 8),
              child: Text(
                section.title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: scheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            for (final item in section.items)
              Card(
                child: ListTile(
                  leading: Icon(item.icon, color: scheme.primary),
                  title: Text(item.title),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: item.builder),
                  ),
                ),
              ),
          ],
        ],
      ),
    );
  }
}