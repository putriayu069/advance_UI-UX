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
import 'animation/implicit_animation.dart' as implicit_anim;
import 'animation/explicit_animation.dart' as explicit_anim;
import 'animation/curves_motion.dart' as curves_anim;
import 'animation/page_transition.dart' as transition_anim;
import 'animation/hero_animation.dart' as hero_anim;
import 'animation/gesture_interaction.dart' as gesture_anim;

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

// =====================================================
// SATU ITEM MENU
// =====================================================

class _MenuItem {
  final String title;
  final IconData icon;
  final WidgetBuilder builder;

  const _MenuItem(this.title, this.icon, this.builder);
}

// =====================================================
// SATU KELOMPOK MENU
// =====================================================

class _MenuSection {
  final String title;
  final List<_MenuItem> items;

  const _MenuSection(this.title, this.items);
}

// =====================================================
// HOME PAGE
// =====================================================

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static final List<_MenuSection> _sections = [
    _MenuSection('Tema & Design System', [
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
    ]),

    _MenuSection('Responsive & Adaptive', [
      _MenuItem('Responsive', Icons.devices, (_) => const ResponsivePage()),
      _MenuItem('Adaptive', Icons.phone_android, (_) => const AdaptivePage()),
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
    ]),

    _MenuSection('Widget & Form', [
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
    ]),

    _MenuSection('Efek & Animasi', [
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

      // MODUL 7 - IMPLICIT ANIMATION
      _MenuItem(
        'Implicit Animation',
        Icons.animation,
        (_) => const implicit_anim.AnimationPage(),
      ),

      // MODUL 8 - EXPLICIT ANIMATION
      _MenuItem(
        'Explicit Animation',
        Icons.rotate_right,
        (_) => const explicit_anim.ExplicitAnimationPage(),
      ),

      // MODUL 9 - CURVES & MOTION
      _MenuItem(
        'Curves & Motion',
        Icons.timeline,
        (_) => const curves_anim.CurvePage(),
      ),

      // MODUL 10 - PAGE TRANSITION
      _MenuItem(
        'Page Transition',
        Icons.swap_horiz,
        (_) => const transition_anim.TransitionPage(),
      ),

      // MODUL 11 - HERO ANIMATION
      _MenuItem(
        'Hero Animation',
        Icons.flight_takeoff,
        (_) => const hero_anim.HeroAnimationPage(),
      ),

      // MODUL 12 - GESTURE & INTERACTION
      _MenuItem(
        'Gesture & Interaction',
        Icons.touch_app,
        (_) => const gesture_anim.GesturePage(),
      ),
    ]),

    _MenuSection('Loading & Feedback', [
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
    ]),

    _MenuSection('Lainnya', [
      _MenuItem('UI State', Icons.sync_alt, (_) => const UiStatePage()),
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
                onPressed: () {
                  themeModeNotifier.value =
                      isDark ? ThemeMode.light : ThemeMode.dark;
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
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: item.builder),
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