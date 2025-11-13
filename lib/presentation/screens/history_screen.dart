// screens/history_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/history_provider.dart';
import '../../presentation/widgets/history/history_item_widget.dart';
import '../../presentation/widgets/history/empty_history_widget.dart';
import '../../presentation/widgets/history/confirm_dialog.dart';
import '../widgets/custom_app_bar.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    await Provider.of<HistoryProvider>(
      context,
      listen: false,
    ).loadPredictionHistory();
  }

  void _showClearHistoryDialog() {
    showDialog(
      context: context,
      builder:
          (context) => ConfirmDialog(
            title: 'Hapus Riwayat',
            message:
                'Apakah Anda yakin ingin menghapus semua riwayat prediksi? Tindakan ini tidak dapat dibatalkan.',
            confirmText: 'Hapus Semua',
            cancelText: 'Batal',
            onConfirm: _clearHistory,
            confirmColor: Colors.red,
          ),
    );
  }

  Future<void> _clearHistory() async {
    await Provider.of<HistoryProvider>(
      context,
      listen: false,
    ).clearPredictionHistory();
  }

  Future<void> _handleRefresh() async {
    await Provider.of<HistoryProvider>(
      context,
      listen: false,
    ).loadPredictionHistory();
  }

  void _handleStartClassification() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Riwayat Prediksi',
        showBackButton: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: _showClearHistoryDialog,
            tooltip: 'Hapus Riwayat',
          ),
        ],
      ),
      body: Consumer<HistoryProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.hasError) {
            return _buildErrorState(provider.errorMessage!);
          }

          if (provider.isEmpty) {
            return EmptyHistoryWidget(
              onStartClassification: _handleStartClassification,
            );
          }

          return RefreshIndicator(
            onRefresh:
                _handleRefresh, // Sekarang sudah sesuai dengan RefreshCallback
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: provider.predictions.length,
              separatorBuilder: (context, index) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final prediction = provider.predictions[index];
                return HistoryItemWidget(prediction: prediction);
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildErrorState(String errorMessage) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              'Terjadi Kesalahan',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              errorMessage,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _loadHistory,
              child: const Text('Coba Lagi'),
            ),
          ],
        ),
      ),
    );
  }
}
