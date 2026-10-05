import 'package:flutter/material.dart';

// ===== Import tiap halaman =====
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
import 'widgets/interactive_widget.dart' as interactive_widgets;
import 'widgets/widget-gallery.dart';

void main() {
  runApp(const MyApp());
}

// Mengatur mode tema seluruh aplikasi
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

          // Light Theme
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.green,
            ),
          ),

          // Dark Theme
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

// Satu item menu
class _MenuItem {
  final String title;
  final IconData icon;
  final WidgetBuilder builder;

  const _MenuItem(
    this.title,
    this.icon,
    this.builder,
  );
}

// Satu kelompok menu
class _MenuSection {
  final String title;
  final List<_MenuItem> items;

  const _MenuSection(
    this.title,
    this.items,
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static final List<_MenuSection> _sections = [
    // =====================================================
    // TEMA & DESIGN SYSTEM
    // =====================================================
    _MenuSection(
      'Tema & Design System',
      [
        _MenuItem(
          'Design System',
          Icons.palette,
          (_) => const DesignSystemPage(),
        ),
        _MenuItem(
          'Tema Dark Mode',
          Icons.dark_mode,
          (_) => const theme_dark.ThemePage(),
        ),
      ],
    ),

    // =====================================================
    // RESPONSIVE & ADAPTIVE
    // =====================================================
    _MenuSection(
      'Responsive & Adaptive',
      [
        _MenuItem(
          'Responsive',
          Icons.devices,
          (_) => const ResponsivePage(),
        ),
        _MenuItem(
          'Adaptive',
          Icons.phone_android,
          (_) => const AdaptivePage(),
        ),
        _MenuItem(
          'Adaptive Layout',
          Icons.dashboard_customize,
          (_) => const adaptive_layout.LayoutPage(),
        ),
        _MenuItem(
          'Adaptive Scroll',
          Icons.swap_vert,
          (_) => const adaptive_scroll.SliverPage(),
        ),
      ],
    ),

    // =====================================================
    // WIDGET & FORM
    // =====================================================
    _MenuSection(
      'Widget & Form',
      [
        _MenuItem(
          'Galeri Widget',
          Icons.widgets,
          (_) => const WidgetGalleryPage(),
        ),
        _MenuItem(
          'Custom Widget Reusable',
          Icons.extension,
          (_) => const custom_widget.CustomWidgetPage(),
        ),

        // FILE BARU
        _MenuItem(
          'Interactive Widgets',
          Icons.touch_app,
          (_) => const interactive_widgets.InteractivePage(),
        ),

        _MenuItem(
          'Form Lanjutan',
          Icons.edit_note,
          (_) => const advance_form.FormPage(),
        ),
        _MenuItem(
          'Dialog, BottomSheet & Snackbar',
          Icons.chat_bubble,
          (_) => const dialog_snackbar.FeedbackPage(),
        ),
      ],
    ),

    // =====================================================
    // EFEK & ANIMASI
    // =====================================================
    _MenuSection(
      'Efek & Animasi',
      [
        _MenuItem(
          'Clip & Visual Effect',
          Icons.content_cut,
          (_) => const clip_effect.VisualPage(),
        ),
        _MenuItem(
          'Custom Painter',
          Icons.brush,
          (_) => const custom_painter.PainterPage(),
        ),
        _MenuItem(
          'Micro Interaction',
          Icons.touch_app,
          (_) => const MicroInteractionPage(),
        ),
        _MenuItem(
          'Opacity, Transform & Filter',
          Icons.filter_b_and_w,
          (_) => const opacity_filter.TransformPage(),
        ),
      ],
    ),

    // =====================================================
    // LOADING & FEEDBACK
    // =====================================================
    _MenuSection(
      'Loading & Feedback',
      [
        _MenuItem(
          'Loading & Feedback',
          Icons.hourglass_bottom,
          (_) => const loading_feedback.LoadingPage(),
        ),
        _MenuItem(
          'Skeleton & Shimmer',
          Icons.blur_on,
          (_) => const skeleton.SkeletonPage(),
        ),
      ],
    ),

    // =====================================================
    // LAINNYA
    // =====================================================
    _MenuSection(
      'Lainnya',
      [
        _MenuItem(
          'UI State',
          Icons.sync_alt,
          (_) => const UiStatePage(),
        ),
        _MenuItem(
          'Interactive Layout',
          Icons.view_quilt,
          (_) => const InteractiveLayoutPage(),
        ),
        _MenuItem(
          'Accessibility',
          Icons.accessibility_new,
          (_) => const AccessibilityPage(),
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter UI Lab'),

        // Tombol Light/Dark Mode
        actions: [
          ValueListenableBuilder<ThemeMode>(
            valueListenable: themeModeNotifier,
            builder: (context, mode, _) {
              final isDark =
                  mode == ThemeMode.dark ||
                  (mode == ThemeMode.system &&
                      MediaQuery.platformBrightnessOf(context) ==
                          Brightness.dark);

              return IconButton(
                tooltip: 'Ganti tema',
                icon: Icon(
                  isDark
                      ? Icons.light_mode
                      : Icons.dark_mode,
                ),
                onPressed: () {
                  themeModeNotifier.value =
                      isDark
                          ? ThemeMode.light
                          : ThemeMode.dark;
                },
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
              padding: const EdgeInsets.only(
                top: 12,
                bottom: 8,
              ),
              child: Text(
                section.title,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(
                      color: scheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),

            for (final item in section.items)
              Card(
                child: ListTile(
                  leading: Icon(
                    item.icon,
                    color: scheme.primary,
                  ),
                  title: Text(item.title),
                  trailing: const Icon(
                    Icons.chevron_right,
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: item.builder,
                      ),
                    );
                  },
                ),
              ),
          ],
        ],
      ),
    );
  }
}