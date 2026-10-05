import 'package:flutter/material.dart';

class SkeletonPage extends StatefulWidget {
  const SkeletonPage({super.key});

  @override
  State<SkeletonPage> createState() => _SkeletonPageState();
}

class _SkeletonPageState extends State<SkeletonPage> {
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    setState(() {
      loading = true;
    });

    await Future.delayed(const Duration(seconds: 3));

    if (mounted) {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Skeleton & Shimmer'),
        actions: [
          IconButton(
            onPressed: loadData,
            icon: const Icon(Icons.refresh),
            tooltip: 'Muat ulang',
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            'Explore Today',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),

          const SizedBox(height: 6),

          Text(
            loading
                ? 'Menyiapkan konten untuk kamu...'
                : 'Konten berhasil dimuat.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),

          const SizedBox(height: 24),

          // Highlight Card
          loading
              ? const SkeletonHighlight()
              : const HighlightCard(),

          const SizedBox(height: 24),

          Text(
            'Rekomendasi',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),

          const SizedBox(height: 12),

          if (loading)
            ...List.generate(
              4,
              (index) => const SkeletonRecommendation(),
            )
          else
            ...List.generate(
              4,
              (index) => RecommendationCard(index: index),
            ),

          const SizedBox(height: 20),

          OutlinedButton.icon(
            onPressed: loadData,
            icon: const Icon(Icons.refresh),
            label: const Text('Muat Ulang Data'),
          ),
        ],
      ),
    );
  }
}

// ======================================================
// SHIMMER
// ======================================================

class ShimmerBox extends StatefulWidget {
  final double width;
  final double height;
  final double radius;

  const ShimmerBox({
    super.key,
    required this.width,
    required this.height,
    this.radius = 12,
  });

  @override
  State<ShimmerBox> createState() => _ShimmerBoxState();
}

class _ShimmerBoxState extends State<ShimmerBox>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.radius),
            gradient: LinearGradient(
              begin: Alignment(-1.5 + controller.value * 3, 0),
              end: Alignment(-0.5 + controller.value * 3, 0),
              colors: const [
                Color(0xFFE5E7EB),
                Color(0xFFF8FAFC),
                Color(0xFFE5E7EB),
              ],
            ),
          ),
        );
      },
    );
  }
}

// ======================================================
// SKELETON HIGHLIGHT
// ======================================================

class SkeletonHighlight extends StatelessWidget {
  const SkeletonHighlight({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          children: [
            const ShimmerBox(
              width: 85,
              height: 85,
              radius: 18,
            ),

            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  ShimmerBox(
                    width: 110,
                    height: 12,
                  ),
                  SizedBox(height: 12),
                  ShimmerBox(
                    width: double.infinity,
                    height: 18,
                  ),
                  SizedBox(height: 8),
                  ShimmerBox(
                    width: 160,
                    height: 12,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ======================================================
// SKELETON RECOMMENDATION
// ======================================================

class SkeletonRecommendation extends StatelessWidget {
  const SkeletonRecommendation({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: const [
            ShimmerBox(
              width: 65,
              height: 65,
              radius: 14,
            ),
            SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerBox(
                    width: double.infinity,
                    height: 15,
                  ),
                  SizedBox(height: 10),
                  ShimmerBox(
                    width: 180,
                    height: 11,
                  ),
                  SizedBox(height: 8),
                  ShimmerBox(
                    width: 100,
                    height: 11,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ======================================================
// DATA ASLI
// ======================================================

class HighlightCard extends StatelessWidget {
  const HighlightCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          children: [
            Container(
              width: 85,
              height: 85,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
              child: Icon(
                Icons.auto_awesome,
                size: 40,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),

            const SizedBox(width: 16),

            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'HIGHLIGHT',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Konten Hari Ini',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Konten berhasil dimuat.',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RecommendationCard extends StatelessWidget {
  final int index;

  const RecommendationCard({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final titles = [
      'Flutter UI',
      'Material Design',
      'Responsive Layout',
      'Animation',
    ];

    final icons = [
      Icons.flutter_dash,
      Icons.design_services,
      Icons.devices,
      Icons.animation,
    ];

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: CircleAvatar(
          radius: 30,
          child: Icon(icons[index]),
        ),
        title: Text(
          titles[index],
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: const Text(
          'Materi berhasil dimuat dan siap dipelajari.',
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
    );
  }
}