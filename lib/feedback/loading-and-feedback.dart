import 'dart:async';

import 'package:flutter/material.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  bool loading = false;
  double progress = 0;
  bool completed = false;

  Timer? timer;

  void startProcess() {
    timer?.cancel();

    setState(() {
      loading = true;
      completed = false;
      progress = 0;
    });

    timer = Timer.periodic(
      const Duration(milliseconds: 100),
      (timer) {
        if (!mounted) {
          timer.cancel();
          return;
        }

        setState(() {
          progress += 0.05;
        });

        if (progress >= 1) {
          timer.cancel();

          setState(() {
            progress = 1;
            loading = false;
            completed = true;
          });

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Proses berhasil diselesaikan'),
            ),
          );
        }
      },
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Loading & Feedback'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                loading
                    ? Icons.sync
                    : completed
                        ? Icons.check_circle
                        : Icons.cloud_upload,
                size: 70,
                color: Theme.of(context).colorScheme.primary,
              ),

              const SizedBox(height: 20),

              Text(
                loading
                    ? 'Sedang Memproses'
                    : completed
                        ? 'Proses Selesai'
                        : 'Siap Memulai',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),

              const SizedBox(height: 8),

              Text(
                loading
                    ? 'Data sedang diproses, silakan tunggu...'
                    : completed
                        ? 'Semua proses telah selesai.'
                        : 'Tekan tombol untuk memulai proses.',
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 30),

              if (loading) ...[
                const CircularProgressIndicator(),

                const SizedBox(height: 24),

                SizedBox(
                  width: 280,
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 8,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),

                const SizedBox(height: 12),

                Text(
                  '${(progress * 100).round()}%',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ] else ...[
                FilledButton.icon(
                  onPressed: startProcess,
                  icon: Icon(
                    completed ? Icons.refresh : Icons.play_arrow,
                  ),
                  label: Text(
                    completed ? 'Ulangi Proses' : 'Mulai Proses',
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}