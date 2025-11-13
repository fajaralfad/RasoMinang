import 'package:flutter/material.dart';

class EmptyHistoryWidget extends StatelessWidget {
  final VoidCallback onStartClassification;

  const EmptyHistoryWidget({
    super.key,
    required this.onStartClassification,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.history_toggle_off,
              size: 80,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'Belum Ada Riwayat',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Hasil prediksi akan muncul di sini',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey[500],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: onStartClassification,
              icon: const Icon(Icons.camera_alt),
              label: const Text('Mulai Klasifikasi'),
            ),
          ],
        ),
      ),
    );
  }
}