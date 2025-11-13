import 'package:flutter/material.dart';

class HomeErrorWidget extends StatelessWidget {
  final String errorMessage;
  final VoidCallback onRetry;
  final bool isDark;

  const HomeErrorWidget({
    super.key,
    required this.errorMessage,
    required this.onRetry,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: isDark ? Colors.red.shade900.withOpacity(0.3) : Colors.red.shade50,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildErrorHeader(context),
            const SizedBox(height: 16),
            _buildRetryButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorHeader(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.error, 
          color: isDark ? Colors.red.shade300 : Colors.red.shade700
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            errorMessage,
            style: TextStyle(
              color: isDark ? Colors.red.shade300 : Colors.red.shade700,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRetryButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onRetry,
        style: OutlinedButton.styleFrom(
          foregroundColor: isDark ? Colors.red.shade300 : Colors.red.shade700,
          side: BorderSide(
            color: isDark ? Colors.red.shade300 : Colors.red.shade700,
          ),
        ),
        child: const Text('Coba Lagi'),
      ),
    );
  }
}