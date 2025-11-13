// widgets/history_item_widget.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:klasifikasi_makanan_minang/core/constant/app_constants.dart';
import 'package:klasifikasi_makanan_minang/domain/entities/prediction_entity.dart';

class HistoryItemWidget extends StatelessWidget {
  final PredictionEntity prediction;
  final VoidCallback? onTap;

  const HistoryItemWidget({
    super.key,
    required this.prediction,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final foodName = AppConstants.foodLabels[prediction.predictedClass] ?? 
        prediction.predictedClass;
    final description = AppConstants.foodDescriptions[prediction.predictedClass] ?? 
        '';

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Gambar
              _buildImage(prediction.imagePath),
              const SizedBox(width: 12),
              
              // Informasi
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      foodName,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: Theme.of(context).textTheme.bodySmall,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    
                    // Confidence dan Tanggal
                    _buildMetadata(prediction, context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage(String imagePath) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey[200],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.file(
          File(imagePath),
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: Colors.grey[300],
              child: Icon(
                Icons.fastfood,
                color: Colors.grey[500],
                size: 32,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildMetadata(PredictionEntity prediction, BuildContext context) {
    return Row(
      children: [
        // Confidence Badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: _getConfidenceColor(prediction.confidence).withOpacity(0.1),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: _getConfidenceColor(prediction.confidence).withOpacity(0.3),
            ),
          ),
          child: Text(
            prediction.confidencePercentage,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: _getConfidenceColor(prediction.confidence),
            ),
          ),
        ),
        const Spacer(),
        // Tanggal
        Text(
          _formatDate(prediction.timestamp),
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Color _getConfidenceColor(double confidence) {
    if (confidence > 0.8) return Colors.green;
    if (confidence > 0.6) return Colors.orange;
    return Colors.red;
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inMinutes < 1) {
      return 'Baru saja';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes} menit lalu';
    } else if (difference.inDays < 1) {
      return '${difference.inHours} jam lalu';
    } else if (difference.inDays == 1) {
      return 'Kemarin';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} hari lalu';
    } else {
      return DateFormat('dd/MM/yyyy').format(date);
    }
  }
}