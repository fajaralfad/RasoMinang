// widgets/home_action_section.dart
import 'package:flutter/material.dart';

class HomeActionSection extends StatelessWidget {
  final VoidCallback onPickImage;
  final bool isSmallScreen;
  final bool isDark;

  const HomeActionSection({
    super.key,
    required this.onPickImage,
    required this.isSmallScreen,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: isDark ? 2 : 4,
      color: isDark ? Colors.grey.shade800 : Colors.white,
      child: Padding(
        padding: EdgeInsets.all(isSmallScreen ? 16 : 24),
        child: Column(
          children: [
            _buildIcon(context), // Pass context to _buildIcon
            SizedBox(height: isSmallScreen ? 12 : 16),
            _buildTitle(context),
            SizedBox(height: isSmallScreen ? 4 : 8),
            _buildDescription(context),
            SizedBox(height: isSmallScreen ? 16 : 24),
            _buildActionButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon(BuildContext context) { // Add context parameter
    return Icon(
      Icons.photo_camera,
      size: isSmallScreen ? 48 : 64,
      color: Theme.of(context).primaryColor,
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      'Pilih Gambar Makanan',
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
        fontSize: isSmallScreen ? 18 : 20,
      ),
    );
  }

  Widget _buildDescription(BuildContext context) {
    return Text(
      'Gunakan kamera atau pilih dari galeri',
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
        color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildActionButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onPickImage,
        icon: const Icon(Icons.add_photo_alternate),
        label: Text(
          'Pilih Gambar',
          style: TextStyle(
            fontSize: isSmallScreen ? 14 : 16,
          ),
        ),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(
            vertical: isSmallScreen ? 14 : 16,
            horizontal: 24,
          ),
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Colors.white,
        ),
      ),
    );
  }
}